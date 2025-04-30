**Salesforce CSV Export Agent**

This agent automates the process of exporting Salesforce data into CSV files based on user-defined criteria. It eliminates the need for users to write SOQL queries or use external tools. Instead, the agent collects simple inputs through a conversational flow, such as object name, field names, filters, and record limits. It dynamically queries Salesforce, generates a CSV file, and provides a direct download link for the user.

✅ **Key Benefits:**

No need for technical expertise: Users don’t need to know SOQL or Apex.

Quick and customizable exports: Easily export specific data sets from any Salesforce object.

Supports filters and record limits: Filter records based on any conditions (e.g., date ranges, status) and limit the number of records.

Saves time: Ideal for support, admins, and reporting teams who need quick data exports without manual intervention.

**Use Cases:**

1. Account Analysis
Use Case: A business analyst needs to pull a list of Accounts in the Technology industry, including fields like Id, Name, and AnnualRevenue, for a performance report.

How the agent helps: The agent filters Accounts based on the industry and generates a CSV file for easy sharing or further analysis.

2. Financial Audits
Use Case: An auditor needs to export Opportunity data to verify discrepancies in Amount and CloseDate for the last financial year.

How the agent helps: The agent filters Opportunities by date range and revenue fields, then exports the data as a CSV for easy analysis and discrepancy identification.

3. Data Quality Monitoring
Use Case: A data quality manager needs to export records from Leads or Contacts where key fields like Email or Phone Number are missing.

How the agent helps: The agent runs a query to filter records with missing data and exports those records into a CSV file for further review and correction by the data team.

**How to Use the CSV Export Agent:**

1. Initialize the Flow
   
To begin, the agent will prompt the user to enter the following information:

Object Name (e.g., Account, Contact, Opportunity, or a custom object like Project__c).

Fields to Export (comma-separated field names such as Id, Name, AnnualRevenue, Email).

Filters (optional): A natural language filter to narrow down the records, e.g., "Status = 'Active' AND AnnualRevenue > 1000000".

Limit (optional): The number of records to retrieve (e.g., 1000).

Example Input 1:

I want to export the Id, Name, and Custom_Status__c fields from the Project__c object, but only include projects where the Custom_Status__c field is In Progress.

Example Input 2:

Object Name: Opportunity

Fields to Export: Id, OpportunityName, Amount, CloseDate

Filters: CloseDate = LAST_N_DAYS:30 AND StageName = 'Closed Won'

Limit: 500
