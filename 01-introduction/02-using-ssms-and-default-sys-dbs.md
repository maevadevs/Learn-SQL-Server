# Using SSMS and Default System Databases

---

- [Connecting To SQL Server](#connecting-to-sql-server)
- [Executing a Query](#executing-a-query)
- [4 Default System Databases](#4-default-system-databases)
  - [NOTE on Polybase DBs](#note-on-polybase-dbs)
  - [`master`](#master)
  - [`model`](#model)
  - [`msdb`](#msdb)
  - [`tempdb`](#tempdb)

---

## Connecting To SQL Server

- Launch SSMS
- Click on *Connect* under *Object Explorer*
- Choose *Database Engine*
- Enter the information:
  - Server Name
  - Authentication Type
  - Login Information
- Click *Connect*
- If the connection is establish, the *Object Explorer* would be populated

## Executing a Query

- Right-click on the server node (*localhost*)
- Select *New Query*
- Enter the SQL Query

```sql
-- Test SQL Query by checking SQL Server version
SELECT @@version AS SqlServerVersion;
```

- Click the *Execute* button (Or F5)
- The Results window should show the version of the SQL Server

## 4 Default System Databases

- `master`
- `model`
- `msdb`
- `tempdb`

### NOTE on Polybase DBs

If you install the *Polybase* feature (for querying external *Hadoop* data and data in *Azure Blob Storage*), the following DBs would also be installed by default:

- `DWConfiguration`
- `DWDiagnostics`
- `DWQueue`

<!---->
- They are not databases you will ever be querying unless directed by Microsoft Support while troubleshooting a support case
- Even then, typically log files and DMV data are all that will be requested
- Leave these DBs alone
- Back them up along with the other system databases
- However, most likely it would be easier to uninstall/reinstall Polybase than to worry about ever restoring these dbs

### `master`

- Contains information about SQL Server configuration
  - Metadata information about all other objects
  - Login information of users
- **Without Master database, the server can't be started**
  - If the master database gets corrupted and is not recoverable from the backup, then a user has to rebuild the master database
  - **It is always recommended to maintain a current backup of the master database**
  - It cannot be deleted as it is the heart of SQL SERVER
  - Everything crucial to SQL server is stored in the master database

### `model`

- Sets a template for every database that is newly created
- A template for the SQL server in order to create a new database
- When we create a new database, the data present in model database are moved to new database to create its default objects
- By default, it does not contain any data
  - This can be customized in order to get custom startup database at creation
- Not specific to creation of new database only
  - Whenever the SQL server starts, the `Tempdb` is created by using `model` database as template

### `msdb`

- Used mainly by *SSMS* and *SQL Server Agent* to store system activities
  - Server jobs
  - Mail
  - Service broker
  - Maintenance plans
  - User and system database backup history
  - Replication information
  - Log shipping
- **Take a backup of this database for the proper function of SQL Server Agent Service**

### `tempdb`

- A database for temporary storage
  - A temporary location for storing temporary Tables, Stored Procedures
  - Hold intermediate results during the sorting or query processing and cursors
- It can be accessed by all users in the SQL Server Instance
- If more temporary objects are created and use the storage of ``tempdb``, the performance of SQL Server will be affected
- Will be created by SQL Server instance when the SQL Server service starts
- Created using the `model` database
- **We cannot take a backup of `tempdb`**
