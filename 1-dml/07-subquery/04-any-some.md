# `ANY`/`SOME`

- Compare a value with a single-column set of values returned by a subquery
- Returns `TRUE` if any comparison (`scalar_expression`, `value`) returns `TRUE`. Returns `FALSE` otherwise
- `SOME` is an alias to `ANY`

## Format

```sql
scalar_expression comparison_operator ANY (subquery)
```

## Examples

Find the products that were sold with more than two units in a sales order

```sql
SELECT
  product_name,
  list_price
FROM production.products
WHERE product_id = ANY (
  SELECT product_id
  FROM sales.order_items
  WHERE quantity >= 2
)
ORDER BY product_name
```

- `ANY` is similar to `IN` when using the `=` operator
- However, it behaves differently with other operators

So the previous query is equivalent to the following:

```sql
SELECT
  product_name,
  list_price
FROM production.products
WHERE product_id IN (
  SELECT product_id
  FROM sales.order_items
  WHERE quantity >= 2
)
ORDER BY product_name
```
