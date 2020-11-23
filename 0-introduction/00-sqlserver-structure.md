# SQL Server Structure

- RDBMS developed by Microsoft
- Tied to Transact-SQL (T-SQL)
- **T-SQL** -  Microsoft’s implementation of SQL that adds a set of proprietary programming constructs
- 2016: SQL Server 2017 made available on Linux

Components:

- **Database Engine**
- **SQLOS**
- **SQL Server Services and Tools**

<img src="../figures/sql-server-architecture.png" width=70%>

## Database Engine

- Core component
- Manage all database objects: Tables, Stored Procedures, Views, Triggers

Two components:

- **Relational Engine**
- **Storage Engine**

### Relational Engine

- Query Processor: Process the queries
- Request data from the storage engine based on the query
- Query processing
- Memory management
- Thread and task management
- Buffer management
- Distributed query processing

### Storage Engine

- Storage of data to the storage system
- Retrieval of data from the storage system
- Manage the underlying files for data, pages, index...

## SQLOS

- SQL Server Operating System
- Operating System services
  - Memory
  - I/O management
  - Exception handling
  - Synchronization services

## SQL Server Services and Tools

- Data Management
  - **SSIS** - SQL Server Integration Services
  - **SSDQS** - SQL Server Data Quality Services
  - **SSMDS** - SQL Server Master Data Services
- Data Development
  - **SSDT** - SQL Server Data tools
- Database Management, Deployment, Monitoring
  - **SSMS** - SQL Server Management Studio
- Data Analysis
  - **SSAS** - SQL Server Analysis Services
- Data Reporting and Visualizations
  - **SSRS** - SQL Server Reporting Services
- Machine Learning
  - **SSMLS** - SQL Server Machine Learning Servcies (Since SS2016, for R and Python)

## SQL Server Editions

4 Editions with different bundles:

### Developer Edition

- Free
- For database development and testing

### Express Edition

- Free
- For small databases up to 10 GB

### Standard Edition

- Paid
- Partial feature sets of the Enterprise Edition
- Limits on the Server regarding the numbers of processor core and memory that can be configured

### Enterprise Edition

- Paid
- Includes all features
- For large and critical production applications
