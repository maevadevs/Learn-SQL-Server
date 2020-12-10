# `NULL`

## NULL and Three-Valued Logic

- Normally, the result of a logical expression is `TRUE` or `FALSE`
- When `NULL` is involved in the logical evaluation, the result is `UNKNOWN`
- Three-Valued Logic:
  - `TRUE`
  - `FALSE`
  - `UNKNOWN`

```sql
NULL = 0    --> UNKNOWN
NULL <> 0   --> UNKNOWN
NULL > 0    --> UNKNOWN
NULL = NULL --> UNKNOWN
```

- `NULL` is equal to nothing, not even to itself

## `IS NULL`

- We cannot compare `NULL` as in `x = NULL` because it evaluates to `UNKNWON`
- Allows to filter for values that are `NULL`

```sql
SELECT customer_id, first_name, last_name, phone
FROM sales.customers
WHERE phone = NULL --> UNKNWON: Empty set
ORDER BY first_name, last_name;
```

```sql
SELECT customer_id, first_name, last_name, phone
FROM sales.customers
WHERE phone IS NULL --> Correct
ORDER BY first_name, last_name;
```

## `IS NOT NULL`

Returns the complement set of `IS NULL`

```sql
SELECT customer_id, first_name, last_name, phone
FROM sales.customers
WHERE phone IS NOT NULL
ORDER BY first_name, last_name;
```

This is equivalent to the following, using negative sub-query for the complement set

```sql
-- The complement set of IS NULL
SELECT customer_id, first_name, last_name, phone
FROM sales.customers
WHERE customer_id NOT IN (
  SELECT customer_id
  FROM sales.customers
  WHERE phone IS NULL
)
ORDER BY first_name, last_name;
```
