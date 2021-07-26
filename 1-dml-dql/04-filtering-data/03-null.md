# `NULL`

## NULL and Three-Valued Logic

- Normally, the result of a logical expression is `TRUE` or `FALSE`
- **When `NULL` is involved in the logical evaluation, the result is `UNKNOWN`**
- Three-Valued Logic:
  - `TRUE`
  - `FALSE`
  - `UNKNOWN`
- **`NULL` is never equal to anything, not even to itself**

```sql
NULL = 0    --> UNKNOWN
NULL <> 0   --> UNKNOWN
NULL > 0    --> UNKNOWN
NULL = NULL --> UNKNOWN
```

## `IS NULL`

- **We cannot compare `NULL` as in `x = NULL` because it evaluates to `UNKNWON`**
- Instead, we use `IS NULL`
  - Allows to filter for values that are `NULL`

```sql
--This does not work: Return an empty set
SELECT 
    Customer_Id, 
    First_Name, 
    Last_Name, 
    Phone
FROM Sales.Customers
WHERE Phone = NULL --> UNKNWON: Return an empty set
ORDER BY 
    First_Name, 
    Last_Name;
```

```sql
--This works
SELECT 
    Customer_Id, 
    First_Name, 
    Last_Name, 
    Phone
FROM Sales.Customers
WHERE Phone IS NULL --> CORRECT
ORDER BY 
    First_Name, 
    Last_Name;
```

## `IS NOT NULL`

Returns the complement set of `IS NULL`

```sql
SELECT 
    Customer_Id, 
    First_Name, 
    Last_Name, 
    Phone
FROM Sales.Customers
WHERE Phone IS NOT NULL
ORDER BY 
    First_Name, 
    Last_Name;
```

This is equivalent to the following, using negative sub-query for the complement set

```sql
-- The complement set of IS NULL
SELECT 
    Customer_Id, 
    First_Name, 
    Last_Name, 
    Phone
FROM Sales.Customers
WHERE Customer_Id NOT IN (
    SELECT Customer_Id
    FROM Sales.Customers
    WHERE Phone IS NULL
)
ORDER BY 
    First_Name, 
    Last_Name;
```
