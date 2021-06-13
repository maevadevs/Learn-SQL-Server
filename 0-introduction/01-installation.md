# Installation

## Installing SQL Server Database Engine & Features

- [Download the installation media](https://www.microsoft.com/en-us/sql-server/sql-server-downloads) (Choose the Free *Developer Edition* for learning-purposes. This has the same features as the *Enterprise Edition* but cannot be used for production.)
- Choose Custom installation
- Specify the download location and start downloading
- Open the download and start `SETUP.exe`
- In the *SQL Server Installation Center*, Select the `Installation` option
- Click the first link to launch a wizard to install SQL Server
- Specify the edition that you want to install and enter the product key
- Accept the license terms
- Check the *Use Microsoft Update to check for updates (recommended)* to get the security and other important updates
- The installation checks for the prerequisites before installation: If no error found, click the *Next* button
- Select the features that you want to install:
  - **Required: Database Engine Services**
- Specify the name and install ID for the instance of the SQL Server
- Specify the service account and collation configuration
- Specify the database engine security mode
  - Windows Authentication Mode
  - Mixed Mode
- Confirm the features to be installed

## Installing SSMS

- [Download the installation media](https://docs.microsoft.com/en-us/sql/ssms/download-sql-server-management-studio-ssms?view=sql-server-ver15)
- To interact with SQL Servers, SSMS is required
- Software for querying, designing, and managing SQL Server on your local computer or in the cloud
- Tools to configure, monitor, and administer SQL Server instances
- Beginning with SSMS 18.7, Azure Data Studio is automatically installed alongside SSMS
- Users of SSMS are now able to benefit from the innovations and features in AzDS
- AzDS is a cross-platform and open-source desktop tool for your environments, whether in the cloud, on-premises, or hybrid

Check the `knowledgebase` folder for additional goodies
