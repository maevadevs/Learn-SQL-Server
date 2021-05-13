# `SELECT`

- Introduction to the basic of the SQL Server `SELECT` statement
- Focusing on how to query against a single table

## Basic `SELECT`

- SQL Server uses *schemas* to logically groups related tables and other database objects
- The most basic form of `SELECT`
- The return of the query is called a `result set`

```sql
SELECT 
  col1, 
  col2, 
  col3
FROM schema_name.table_name;
```

- SQL Server processes the `FROM` clause first and then the `SELECT` clause even though the `SELECT` clause appears first in the query

```
FROM > SELECT
```

```sql
SELECT *
FROM schema_name.table_name;
```

- `SELECT *` is useful for examining the columns and data of a table that you are not familiar with
  - **However, do not use `SELECT *` for real production code**
  - It retrieves more data than your application needs to function
  - This causes unnecessary data to transfer
  - Affecting performance

**SQL Server processes the clauses in the following sequence:**

```
FROM > ON > OUTER > WHERE > GROUP BY > HAVING > SELECT > DISTINCT > ORDER BY > TOP
```

### Examples `SELECT`

```sql
SELECT 
  first_name, 
  last_name, 
  email
FROM sales.customers;
```

```sql
SELECT *
FROM sales.customers;
```

## `SELECT WHERE`

- To filter rows based on one or more conditions
- When the `WHERE` clause is available, SQL Server processes the clauses of the query in the following sequence

```
FROM > WHERE > SELECT`
```

### Example `SELECT WHERE`

```sql
SELECT *
FROM sales.customers
WHERE state = 'CA';
```

## `SELECT` with `ORDER BY`

- The order of the result set from `SELECT` is not assured
- To sort the result set based on one or more columns
- SQL Server processes the clauses of the query in the following sequence

```
FROM > WHERE > SELECT > ORDER BY
```

### Example `SELECT ORDER BY`

```sql
SELECT *
FROM sales.customers
WHERE state = 'CA'
ORDER BY first_name;
```

## `SELECT` with `GROUP BY`

- To group rows into groups
- Requires the use of an aggregate function
- SQL Server processes the clauses in the following sequence: 

```
FROM > WHERE > GROUP BY > SELECT > ORDER BY
```

### Example `SELECT GROUP BY`

```sql
SELECT 
  city, 
  COUNT(*) AS city_count
FROM sales.customers
WHERE state = 'CA'
GROUP BY city
ORDER BY city_count DESC;
```

## `SELECT` with group conditions `HAVING`

- To filter groups based on one or more conditions
- The `WHERE` clause filters on individual rows while the `HAVING` clause filter on aggregations (i.e. the results of `GROUP BY`)
- SQL Server processes the clauses in the following sequence: 

```
FROM > WHERE > GROUP BY > HAVING > SELECT > ORDER BY
```

### Example `SELECT HAVING`

```sql
SELECT 
  city, 
  COUNT(*) AS city_count
FROM sales.customers
WHERE state = 'CA'
GROUP BY city
HAVING COUNT(*) > 10
ORDER BY city_count DESC;
```
