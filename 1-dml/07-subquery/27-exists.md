# `EXISTS`

- Test for the existence of rows in a subquery
- Check whether a subquery returns any row
  - Returns `TRUE` if the subquery returns one or more rows
  - Returns `FALSE` if the subquery returns no rows
- **As soon as the subquery returns a row, the `EXISTS` operator returns `TRUE` and stop processing immediately**
- **Even if the subquery returns a `NULL` value, the `EXISTS` operator is still evaluated to `TRUE`**

## Format

```sql
EXISTS (subquery)
```

## Examples

### Using `EXISTS` with a subquery that returns `NULL` example

This returns all rows from the `customers` table

```sql
SELECT
  customer_id,
  first_name,
  last_name
FROM sales.customers
WHERE EXISTS (SELECT NULL) -- This is always TRUE
ORDER BY
  first_name,
  last_name
```

### Using `EXISTS` with a correlated subquery example

If the number of orders placed by the customer is less than or equal to two, the subquery returns an empty result set that causes the `EXISTS` operator to evaluate to `FALSE`

```sql
SELECT
  customer_id,
  first_name,
  last_name
FROM sales.customers c
WHERE EXISTS (
  SELECT COUNT (*)
  FROM sales.orders o
  WHERE o.customer_id = c.customer_id
  GROUP BY customer_id
  HAVING COUNT (*) > 2
)
ORDER BY
  first_name,
  last_name
```

- Based on the result of the `EXISTS` operator, the customer will be included in the result set

### `EXISTS` vs `IN` Example

- The following queries return equivalent results
- However, `EXISTS` is usually better in peformance and atomicity
  - It can return earlier
  - It consider `NULL` values

```sql
SELECT *
FROM sales.orders
WHERE customer_id IN (
  SELECT customer_id
  FROM sales.customers
  WHERE city = 'San Jose'
)
ORDER BY
  customer_id,
  order_date
```

```sql
SELECT *
FROM sales.orders o
WHERE EXISTS (
  SELECT customer_id
  FROM sales.customers c
  WHERE o.customer_id = c.customer_id
  AND city = 'San Jose'
)
ORDER BY
  o.customer_id,
  order_date
```

### `EXISTS` vs `JOIN`

- `EXISTS` returns `TRUE` or `FALSE`
  - Use `EXISTS` to test if a subquery returns any row 
  - Short-circuits as soon as it does
  - Use `EXISTS` when you just need to check the existence of rows from related tables without returnning data from them
- `JOIN` returns rows from combined tables
  - Use `JOIN` to extend the result set by combining it with the columns from related tables

```sql
SELECT
  customer_id,
  first_name,
  last_name
FROM sales.customers c
WHERE EXISTS (
  SELECT COUNT (*)
  FROM sales.orders o
  WHERE o.customer_id = c.customer_id
  GROUP BY customer_id
  HAVING COUNT (*) > 2
)
ORDER BY
  first_name,
  last_name
```

- Based on the result of the `EXISTS` operator, the customer will be included in the result set
- However, this can be achieved better and with more details with a `INNER JOIN`

```sql
SELECT
  c.customer_id,
  c.first_name,
  c.last_name,
  COUNT(o.customer_id) AS order_counts
FROM sales.customers c INNER JOIN sales.orders o
ON o.customer_id = c.customer_id
GROUP BY 
  c.customer_id, 
  c.first_name,
  c.last_name
HAVING COUNT(o.customer_id) > 2
ORDER BY
  c.first_name,
  c.last_name
```
