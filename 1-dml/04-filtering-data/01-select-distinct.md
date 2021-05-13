# `SELECT DISTINCT`

- Retrieve only the distinct (unique) values in a specified list of columns
- It removes the duplicate values in the column from the result setik

```sql
SELECT DISTINCT 
  col1, 
  col2
FROM table_name
```

- Uses the combination of values in all specified columns in the `SELECT` list to evaluate the uniqueness
- If applied to a column that has `NULL`, it will keep only one `NULL` and eliminates the others
- **Note: The `DISTINCT` clause is redundant when `GROUP BY` is used**

## Examples `SELECT DISTINCT`

Select only the unique cities

```sql
SELECT DISTINCT city
FROM sales.customers
ORDER BY city
```

Select only the *unique combinations* of city and state

```sql
SELECT DISTINCT 
  city, 
  state
FROM sales.customers
ORDER BY 
  state, 
  city
```

Select `NULL` only once

```sql
SELECT DISTINCT phone
FROM sales.customers
ORDER BY phone
```

## Equivalent `GROUP BY`

- We can also return uniques using `GROUP BY` by grouping by all the selected columns
- Here, we return distinct cities together with state and zip

```sql
SELECT 
  city, 
  state, 
  zip_code
FROM sales.customers
GROUP BY 
  city, 
  state, 
  zip_code
ORDER BY 
  state, 
  city
```

This is equivalent to the following `SELECT DISTINCT`

```sql
SELECT DISTINCT 
  city, 
  state, 
  zip_code
FROM sales.customers
ORDER BY 
  state, 
  city
```

- Both `DISTINCT` and `GROUP BY` reduces the number of returned rows in the result set by removing the duplicates
- Use the `GROUP BY` when you want to apply an aggregate function on one or more columns
