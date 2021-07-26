# Aliases

- Use aliases to change the column heading of the query output and table alias
- Improve readability of queries
- We can use basic column transformations and assign the result to aliases
- A temporary name during the query execution
- We use `AS` to assign aliases. But it is optional so we can do without it
- **If the column alias contains spaces, you need to enclose it in quotation marks**

```sql
column_name|expression AS column_alias
column_name|expression column_alias
```

## Example Column Alias

Using column alias with column transformations

```sql
SELECT 
  First_Name,
  Last_Name,
  First_Name + ' ' + Last_Name AS Full_Name
FROM Sales.Customers
ORDER BY Full_Name;
```

```sql
SELECT Category_Name AS 'Product Category'
FROM Production.Categories;
```

- We can use column aliases in `ORDER BY`
- **We cannot use column aliases in `GROUP BY`, `WHERE`, and `HAVING` because of the logical order of processing**
  - **Aliases are defined at the level of `SELECT` clause**
  - `ORDER BY` is evaluated after `SELECT`
  - SQL Server processes the clauses in the following sequence:

```
FROM -> ON -> OUTER -> WHERE -> GROUP BY -> HAVING -> SELECT -> DISTINCT -> ORDER BY -> TOP
```

- **Aliases cannot be used by other expressions within the same `SELECT` list**
  - This is because the logical order in which the expressions are evaluated does not matter and is not guaranteed

```sql
-- This does not work well and is not supported
SELECT 
    Col_1 + 10 AS Temp, 
    Temp + 20 AS Final;
GO

-- Instead, do the following
SELECT 
    Col_1 + 10 AS Temp, 
    Col_1 + 10 + 20 AS Final;
GO
```

## Table Aliases

- Also known as **Correlation Name** or **Range Variable**
- Works the same way as column aliases
- Very helpful when working with joins
- **When you assign an alias to a table, you must use the alias to refer to the table column**
  - Otherwise, SQL Server will issue an error
- **NOTE: `FROM` is executed before `SELECT` so we can use the table aliases in `SELECT`**

```sql
Table_Name AS Table_Alias
Table_Name Table_Alias
```

## Examples Tables Aliases

```sql
-- Join without Aliases
SELECT 
    Sales.Customers.Customer_Id AS CID, 
    First_Name, 
    Last_Name, 
    Order_Id
FROM Sales.Customers
INNER JOIN Sales.Orders 
    ON Sales.Orders.Customer_Id = CID;
```

We can re-write in the following way

```sql
-- We can use table aliases in SELECT
SELECT 
    C.Customer_Id AS CID, 
    o.Customer_Id AS Order_CID,
    First_Name, 
    Last_Name, 
    Order_Id
FROM Sales.Customers AS c
INNER JOIN Sales.Orders AS o
    ON o.Customer_Id = c.Customer_Id;
```
