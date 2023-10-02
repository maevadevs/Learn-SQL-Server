# `DROP DATABASE`

---

- [Example of Dropping a Database](#example-of-dropping-a-database)

---

Allows to delete a database in an SQL Server instance

```sql
DROP DATABASE [IF EXISTS] database_name [,database_name2,...];
```

**`IF EXISTS` option is available from SQL Server 2016 (13.x)**

- Conditionally delete a database only if the database already exists
- If you attempt to delete a nonexisting database without specifying the `IF EXISTS` option, SQL Server will issue an error

**NOTE:**

- `DROP DATABASE` deletes the database + the physical disk files used by the database
  - **Make sure to have a backup of the database in case you want to restore it in the future**
- You cannot drop the database that is currently being used: Throws an error

## Example of Dropping a Database

```sql
--Dropping a simple Test_DB
DROP DATABASE IF EXISTS Test_DB;
```
