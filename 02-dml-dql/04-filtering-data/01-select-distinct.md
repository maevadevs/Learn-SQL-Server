# `SELECT DISTINCT`

---

- [Examples `SELECT DISTINCT`](#examples-select-distinct)
- [Equivalent `GROUP BY`](#equivalent-group-by)

---

- Retrieve only the distinct (unique) values in a specified list of columns
- It removes the duplicate values in the column from the result set

```sql
SELECT DISTINCT
       Col_1,
       Col_2
  FROM Table_Name;
```

- If multiple columns are specified, it uses the distinct values from the combination of all specified columns in the `SELECT` list to evaluate the uniqueness
- If applied to a column that has `NULL`, it will keep only one `NULL` and eliminates the others
- **Note: The `DISTINCT` clause is redundant when `GROUP BY` is used**

## Examples `SELECT DISTINCT`

- Select only the unique cities

```sql
SELECT DISTINCT City
  FROM Sales.Customers
 ORDER BY City;
```

- Select only the *unique combinations* of city and state

```sql
SELECT DISTINCT
       City,
       State
  FROM Sales.Customers
 ORDER BY State,
          City;
```

- When applied to a column that contains `NULL` values, select `NULL` only once

```sql
SELECT DISTINCT Phone
  FROM Sales.Customers
 ORDER BY Phone;
```

## Equivalent `GROUP BY`

- We can also return uniques using `GROUP BY` by grouping by all the selected columns
- Here, we return distinct cities together with state and zip

```sql
SELECT City,
       State,
       Zip_Code
  FROM Sales.Customers
 GROUP BY City,
          State,
          Zip_Code
 ORDER BY State,
          City;
```

- This is equivalent to the following `SELECT DISTINCT`

```sql
SELECT DISTINCT
       City,
       State,
       Zip_Code
  FROM Sales.Customers
 ORDER BY State,
          City;
```

- Both `DISTINCT` and `GROUP BY` reduces the number of returned rows in the result set by removing the duplicates
- Use the `GROUP BY` when you want to apply an aggregate function on one or more columns
