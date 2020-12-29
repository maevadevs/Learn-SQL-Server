# `ORDER BY`

Sort the result set of a query by one or more columns

## Basic `ORDER BY`

- With `SELECT` alone, SQL Server returns a result set in an unspecified order of rows
- To guarantee that the rows in the result set are sorted, use `ORDER BY`
- If you specify multiple columns, the result set is sorted by the first column and then that sorted result set is sorted by the second column, and so on
- The columns that appear in the `ORDER BY` clause must correspond to either:
  - A column in the select list
  - A column defined in the table specified in the `FROM` clause
- `ASC` sorts the result from the lowest value to the highest value (Default)
- `DESC` sorts the result set from the highest value to the lowest value (`NULL` is treated as lowest)
- When processing a `SELECT` statement with an `ORDER BY` clause, the `ORDER BY` clause is the very last clause to be processed
  
```sql
SELECT 
  col1, 
  col2, 
  col3
FROM schema_name.table_name
ORDER BY col1 [ASC|DESC], col2 [ASC|DESC];
```

### Examples Basic `ORDER BY`

```sql
-- Basic ORDER BY
SELECT 
  first_name, 
  last_name
FROM sales.customers
ORDER BY first_name;
```

```sql
-- ORDER BY Descending
SELECT 
  first_name, 
  last_name
FROM sales.customers
ORDER BY first_name DESC;
```

```sql
-- ORDER BY Multiple Columns
SELECT 
  city, 
  first_name, 
  last_name
FROM sales.customers
ORDER BY city, first_name;
```

```sql
-- ORDER BY Multiple Columns and Multiple Orders
SELECT 
  city, 
  first_name, 
  last_name
FROM sales.customers
ORDER BY city DESC, first_name ASC;
```

It is possible to sort the result set by a column that does not appear on the select list but exists on the table

```sql
-- State is not in the list but in the table
SELECT 
  city, 
  first_name, 
  last_name
FROM sales.customers
ORDER BY state;
```

It is also possible to sort by the result of function applied on a column

```sql
-- ORDER BY the result of a function on a column
SELECT 
  first_name, 
  last_name
FROM sales.customers
ORDER BY LEN(first_name) DESC;
```

### Sorting By Ordinal Positions of Columns

- That is, we sort based on the order of the columns in the `SELECT` clause
- The order is 1-based
- **However, using ordinal positions of columns in the `ORDER BY` clause is considered as bad programming practice**
  - The columns in the original table don’t have ordinal positions and need to be referenced by name
  - When you modify the `SELECT` list, you may forget to make the corresponding changes in the `ORDER BY` clause
- **It is a good practice to always specify the column names explicitly in the `ORDER BY` clause**

```sql
SELECT 
  first_name, 
  last_name
FROM sales.customers
ORDER BY 1 DESC, 2; -- First_name DESC, then last_name ASC
```
