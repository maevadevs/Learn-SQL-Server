# Temporary Table

---

- [Creating Temporary Tables](#creating-temporary-tables)
- [Global Temporary Tables](#global-temporary-tables)
- [Dropping Temporary Tables](#dropping-temporary-tables)

---

- Tables that exist temporarily on SQL Server
- Useful for storing the immediate result sets that are accessed multiple times
- Visible only to the current session
- Deleted when the session ends
- **The name of the temporary table starts with a hash (`#`) symbol**

## Creating Temporary Tables

- We can use `SELECT INTO` or `CREATE TABLE`

```sql
SELECT select_list
  INTO temporary_table
  FROM table_name;
```

- Here is an example

```sql
SELECT Product_Name,
       List_Price
  INTO #Trek_Products
  FROM Production.Products
 WHERE Brand_Id = 9;

GO

SELECT *
  FROM #Trek_Products;

GO
```

- **Temporary tables are created in the System Databases `tempdb` > `Temporary Tables`**
- The temporary table consists of a sequence of numbers as a postfix
  - Unique identifier for the temporary table
  - Because multiple database connections can create temporary tables with the same name

```sql
CREATE TABLE #Haro_Products (
           Product_Name VARCHAR(MAX),
             List_Price DEC(10,2)
       );

GO

INSERT INTO #Haro_Products
SELECT Product_Name,
       List_Price
  FROM Production.Products
 WHERE Brand_Id = 2;

GO

SELECT *
  FROM #Haro_Products;

GO
```

- **NOTE: Closing the current connection and opening a new connection effectively drops the temporary table**
  - Temporary tables are only accessible within the session that created them
  - Attempting to query the temporary table in those cases will result into an error

```sql
SELECT *
  FROM #Haro_Products;
-- Error: Invalid object name '#Haro_Products'
```

## Global Temporary Tables

- Temporary table that is accessible across any connections
- Visible to all sessions
- eleted when the session that create the table completes and there is no active references to the table
- Starts with a double hash symbol (`##`)

```sql
CREATE TABLE ##Heller_Products (
           Product_Name VARCHAR(MAX),
             List_Price DEC(10,2)
       );

GO

INSERT INTO ##Heller_Products
SELECT Product_Name,
       List_Price
  FROM Production.Products
 WHERE Brand_Id = 3;

GO

SELECT *
  FROM ##Heller_Products;

GO
```

## Dropping Temporary Tables

Temporary Table|Dropping
:-|:-
Local Temporary Tables|Dropped automatically when closing the connection that created it
Global Temporary Tables|Once the connection that created it closed AND the queries against this table from other connections completes

- We can also manually drop temporary tables
- **This can be done from the session that created the temporary table**

```sql
DROP TABLE ##Table_Name;
```
