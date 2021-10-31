# `ORDER BY`

Sort the result set of a query by the order of one or more columns

## Basic `ORDER BY`

- **With `SELECT` alone, SQL Server returns a result set in an unspecified order of rows**
- To guarantee that the rows in the result set are sorted, use `ORDER BY`
- If you specify multiple columns, the result set is sorted by priority: First, by the first column and then that sorted result set is sorted by the second column, and so on
- The columns that appear in the `ORDER BY` clause must correspond to either:
  - A column in the select list
  - A column defined in the table specified in the `FROM` clause
- `ASC` sorts the result from the lowest value to the highest value (Default)
- `DESC` sorts the result set from the highest value to the lowest value
- `NULL` values are treated as lowest
- When processing a `SELECT` statement with an `ORDER BY` clause, the `ORDER BY` clause is the last clause to be processed

```
- FROM
- ON
- OUTER
- WHERE
- GROUP BY
- HAVING
- SELECT
- DISTINCT
- ORDER BY
- TOP
```

```sql
SELECT           Col_1
                ,Col_2 
                ,Col_3
FROM            Schema_Name.Table_Name
ORDER BY         Col_1 [ASC|DESC]
                ,Col_2 [ASC|DESC];
```

### Examples Basic `ORDER BY`

```sql
-- Basic ORDER BY
SELECT           First_Name
                ,Last_Name
FROM            Sales.Customers
ORDER BY        Last_Name;
```

```sql
-- ORDER BY Descending
SELECT           First_Name
                ,Last_Name
FROM            Sales.Customers
ORDER BY        Last_Name DESC;
```

```sql
-- ORDER BY Multiple Columns
SELECT           City
                ,First_Name
                ,Last_Name
FROM            Sales.Customers
ORDER BY         City
                ,Last_Name;
```

```sql
-- ORDER BY Multiple Columns and Multiple Orders
SELECT           City
                ,First_Name
                ,Last_Name
FROM            Sales.Customers
ORDER BY         City DESC
                ,Last_Name ASC;
```

It is possible to sort the result set by a column that does not appear on the select list but exists on the table

```sql
-- State is not in the select list but in the table
SELECT           City
                ,First_Name
                ,Last_Name
FROM            Sales.Customers
ORDER BY        State
                ,City
                ,Last_Name;
```

It is also possible to sort by the result of functions applied on a column

```sql
-- ORDER BY the result of a function applied on a column
SELECT           First_Name 
                ,Last_Name
FROM            Sales.Customers
ORDER BY        LEN(First_Name) DESC;
```

### Sorting By Ordinal Positions of Columns

- That is, we sort based on the order of the columns in the `SELECT` clause
- **The order is 1-based**
- **However, using ordinal positions of columns in the `ORDER BY` clause is considered as bad programming practice**
  - The columns in the original table don't have ordinal positions and need to be referenced by name
  - When you modify the `SELECT` list, you may forget to make the corresponding changes in the `ORDER BY` clause
- **It is a good practice to always specify the column names explicitly in the `ORDER BY` clause**

```sql
SELECT           First_Name -- Position 1
                ,Last_Name   -- Position 2
FROM            Sales.Customers
ORDER BY         1 DESC -- first_name DESC
                ,2;      -- last_name ASC
```
