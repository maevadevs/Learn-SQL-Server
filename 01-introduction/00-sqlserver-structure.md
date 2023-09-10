# SQL Server Structure

---

- [Database Engine](#database-engine)
  - [Relational Engine / Query Processor](#relational-engine--query-processor)
  - [Storage Engine](#storage-engine)
- [SQLOS - SQL Server Operating System](#sqlos---sql-server-operating-system)
- [SQL Server Services and Tools](#sql-server-services-and-tools)
- [SQL Server Editions](#sql-server-editions)
  - [Developer Edition](#developer-edition)
  - [Express Edition](#express-edition)
  - [Standard Edition](#standard-edition)
  - [Enterprise Edition](#enterprise-edition)

---

- RDBMS developed and marketed by Microsoft
- Built on top of SQL
- Tied to *Transact-SQL* (*T-SQL*)
  - Microsoft's implementation of SQL
  - Adds a set of proprietary programming constructs
- Made available on Linux since SQL Server 2017
- Primary Components:
  - **Database Engine**
  - **SQLOS - SQL Server Operating System**
  - **SQL Server Services and Tools**

<img src="../figures/sql-server-architecture.png" width=80%>

## Database Engine

- Core component
  - *Relational Engine* - process queries
  - *Storage Engine* - manage database objects
- Manage and execute database objects
  - Tables
  - Stored Procedures
  - Views
  - Triggers
  - ...
- Two components:
  - **Relational Engine / Query Processor**
  - **Storage Engine**

### Relational Engine / Query Processor

- Process and execute queries
- Determine the best way to execute queries
- Request data from the storage engine based on the query
- Process and return the result of the query
- Handles some other tasks as well:
  - Memory management
  - Thread and task management
  - Buffer management
  - Distributed query processing

### Storage Engine

- Storage of data to the storage system
- Retrieval of data from the storage system
- Manage the underlying files for data, pages, index...

## SQLOS - SQL Server Operating System

- Provide Operating System services and API
- For interaction with the OS
  - Memory
  - I/O management
  - Exception handling
  - Synchronization services

## SQL Server Services and Tools

Service/Tool | Description | Category
:-|:-|:-
SSIS | SQL Server Integration Services | Data Management
SSDQS | SQL Server Data Quality Services | Data Management
SSMDS | SQL Server Master Data Services | Data Management
SSDT | SQL Server Data tools | Data Development
SSMS | SQL Server Management Studio | Database Management, Deployment, Monitoring
SSAS | SQL Server Analysis Services | Data Analysis
SSRS |  SQL Server Reporting Services | Data Reporting and Visualizations
SSMLS | SQL Server Machine Learning Servcies (Since SS2016, for R and Python) | Machine Learning

## SQL Server Editions

- 4 Editions with different bundles
  - Developer Edition
  - Express Edition
  - Standard Edition
  - Enterprise Edition

### Developer Edition

- Free
- Fully equivalent to Enterprise Edition
- For database development and testing
- Not licensed for production

### Express Edition

- Free
- For small databases up to 10 GB
- Limited features

### Standard Edition

- Paid
- Partial feature-sets of the Enterprise Edition
- Limits on the Server regarding the numbers of processor core and memory that can be configured

### Enterprise Edition

- Paid
- Includes all features
- For large and critical production applications
