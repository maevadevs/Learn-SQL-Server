# `SELECT`

---

- [Basic `SELECT`](#basic-select)
  - [Notes on `SELECT *`](#notes-on-select-)
  - [Examples `SELECT`](#examples-select)
- [`SELECT WHERE`](#select-where)
  - [Example `SELECT WHERE`](#example-select-where)
- [`SELECT` with `ORDER BY`](#select-with-order-by)
  - [Example `SELECT ORDER BY`](#example-select-order-by)
- [`SELECT` with `GROUP BY`](#select-with-group-by)
  - [Example `SELECT GROUP BY`](#example-select-group-by)
- [`SELECT` with Group Conditions `HAVING`](#select-with-group-conditions-having)
  - [Example `SELECT HAVING`](#example-select-having)

---

- Introduction to the basic of the SQL Server `SELECT` statement
- Focusing on how to query against a single table

## Basic `SELECT`

- Tables are objects that store all the data in a database
  - Each row represents a unique record
  - Each column represents a field
- SQL Server uses *Schemas* to logically group related tables and other database objects
- The most basic form of `SELECT`
- The return of the query is called a `Result Set`

```sql
SELECT Col_1,
       Col_2,
       Col_3
  FROM Schema_Name.Table_Name;
```

- Even though the `SELECT` clause appears first in the query, SQL Server processes in this order:

1. The `FROM` clause first
2. Then the `SELECT` clause

- **Overall, SQL Server processes most-used clauses in the following sequence:**

```sql
- FROM
- JOIN
- ON
- WHERE
- GROUP BY
- HAVING
- SELECT
- DISTINCT
- ORDER BY
- TOP
```

```sql
SELECT TOP 10 *
  FROM Schema_Name.Table_Name;
```

### Notes on `SELECT *`

- `SELECT *` is useful for examining the columns and data of a table that you are not familiar with
  - **However, do not use `SELECT *` in real production code**
  - It retrieves more data than your application needs to function
  - This causes unnecessary data to transfer
  - Affecting performance
  - When you use it for testing, it is better to use it with `TOP`

### Examples `SELECT`

```sql
SELECT First_Name,
       Last_Name,
       Email
  FROM Sales.Customers;
```

```sql
SELECT TOP 10 *
  FROM Sales.Customers;
```

## `SELECT WHERE`

- To filter rows based on one or more conditions
- When the `WHERE` clause is available, SQL Server processes the clauses of the query in the following sequence:

```sql
- FROM
- WHERE
- SELECT
```

### Example `SELECT WHERE`

```sql
SELECT TOP 10 *
  FROM Sales.Customers
 WHERE State = 'CA';
```

## `SELECT` with `ORDER BY`

- The order of the result set from `SELECT` by itself is not assured
- Use `ORDER BY` to sort the result set based on one or more columns
- SQL Server processes the clauses of the query in the following sequence:

```sql
- FROM
- WHERE
- SELECT
- ORDER BY
```

- By default, `ORDER BY` will return in an ascending order
  - Specify `DESC` to invert the order

### Example `SELECT ORDER BY`

```sql
SELECT TOP 10 *
  FROM Sales.Customers
 WHERE State = 'CA'
 ORDER BY Last_Name DESC;
```

## `SELECT` with `GROUP BY`

- To group rows into groups
- **Requires the use of aggregate functions**
- Can also be used to get distinct values
- SQL Server processes the clauses in the following sequence:

```sql
- FROM
- WHERE
- GROUP BY
- SELECT
- ORDER BY
```

### Example `SELECT GROUP BY`

```sql
SELECT City,
       Count(*) AS City_Count
  FROM Sales.Customers
 WHERE State = 'CA'
 GROUP BY City
 ORDER BY City_Count DESC;
```

## `SELECT` with Group Conditions `HAVING`

- To filter resulting groups based on one or more conditions
  - The `WHERE` clause applies on individual rows before aggregation happens (i.e. applies on the result set before `GROUP BY`)
  - The `HAVING` clause applies on aggregated values after aggregation happened (i.e. applies on the result set after `GROUP BY`)
- **NOTE: You cannot use column aliases in `HAVING` clause**
- SQL Server processes the clauses in the following sequence:

```sql
- FROM
- WHERE
- GROUP BY
- HAVING
- SELECT
- ORDER BY
```

### Example `SELECT HAVING`

```sql
SELECT City,
       Count(*) AS City_Count
  FROM Sales.Customers
 WHERE State = 'CA'
 GROUP BY City
HAVING Count(*) > 10 -- No column aliases here
 ORDER BY City_Count DESC;
```
