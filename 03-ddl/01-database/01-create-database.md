# `CREATE DATABASE`

---

- [Example of Creating a Database](#example-of-creating-a-database)
- [List all Existing Databases in the Current Instance](#list-all-existing-databases-in-the-current-instance)
- [Create a Database in SSMS](#create-a-database-in-ssms)

---

- Create a new database in a SQL Server instance

```sql
CREATE DATABASE Database_Name;
```

- `Database_Name`
  - Must be unique within an instance of SQL Server
  - Must comply with the SQL Server identifier’s rules
  - Typically has a maximum of 128 characters
- **NOTE: You might need to refresh the refresh the *Object Explorer* view in SSMS after creating a new DB Object**

## Example of Creating a Database

```sql
--Create a simple Test_DB
CREATE DATABASE Test_DB;
```

## List all Existing Databases in the Current Instance

```sql
--List all existing DB Names in the current instance
SELECT "Name"
  FROM master.sys.databases
 ORDER BY "Name";
```

- Or we can also execute a Stored Procedure

```sql
--List all existing DBs in the current instance
EXEC sp_databases;
```

## Create a Database in SSMS

- We can also create a new database in SSMS
  - Right-click the *Database* folder
  - Select *New Database*
  - Enter the new database name
  - Press *OK*
  - Refresh the *Object Explorer* view
