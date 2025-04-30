public with sharing class CSVGenerator {

    // Input wrapper for Flow
    public class InputWrapper {
        @InvocableVariable(label='Object Name')
        public String objectName;
		
        @InvocableVariable(label='filters')
        public String filters;
        
        @InvocableVariable(label='limit')
        public String limitCount;
        
        @InvocableVariable(label='Fields to Export (comma-separated)')
        public String fieldList;
    }

    // Output wrapper for Flow
    public class OutputWrapper {
        @InvocableVariable(label='Download URL')
        public String downloadUrl;
    }

    @InvocableMethod(label='Generate CSV File' description='Generates a CSV file based on input parameters and returns a download URL.')
    public static List<OutputWrapper> generateCSV(List<InputWrapper> inputList) {
        InputWrapper input = inputList[0];

        // Sanitize
        String objectName = input.objectName;
        List<String> fields = input.fieldList.replaceAll(' ', '').split(',');
        String filters  = input.filters;
        String limitCount = input.limitCount;
        String query;
        if(limitCount != null && limitCount != 'All'){
            query = 'SELECT ' + String.join(fields, ', ') +
               ' FROM ' + objectName +
               ' WHERE ' + filters +
               ' LIMIT ' + limitCount;
        }
        else{
            query = 'SELECT ' + String.join(fields, ', ') +
               ' FROM ' + objectName +
               ' WHERE ' + filters;
        }
       
        
        List<SObject> records = Database.query(query);

        List<String> csvLines = new List<String>();
        csvLines.add(String.join(fields, ',')); 

        for (SObject record : records) {
            List<String> row = new List<String>();
            for (String field : fields) {
                Object value = record.get(field);
                row.add(value != null ? String.valueOf(value) : '');
            }
            csvLines.add(String.join(row, ','));
        }

        Blob csvBlob = Blob.valueOf(String.join(csvLines, '\n'));

        ContentVersion cv = new ContentVersion();
        cv.Title = 'Exported data';
        cv.PathOnClient = 'data.csv';
        cv.VersionData = csvBlob;
        cv.IsMajorVersion = true;
        insert cv;

        ContentVersion insertedCV = [SELECT Id, ContentDocumentId FROM ContentVersion WHERE Id = :cv.Id LIMIT 1];

        // Optional: Link the file to the first record (if needed)
        if (!records.isEmpty()) {
            ContentDocumentLink link = new ContentDocumentLink();
            link.ContentDocumentId = insertedCV.ContentDocumentId;
            link.LinkedEntityId = records[0].Id;
            link.ShareType = 'V';
            link.Visibility = 'AllUsers';
            insert link;
        }

        OutputWrapper ow = new OutputWrapper();
        ow.downloadUrl = URL.getOrgDomainUrl().toExternalForm() +
                         '/sfc/servlet.shepherd/version/download/' + insertedCV.Id;

        return new List<OutputWrapper>{ ow };
    }
}