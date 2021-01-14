# `ALL`

- Compare a value with a single-column set of values returned by a subquery
- Return `TRUE` if the value matches **all** values in the set. `FALSE` otherwise
- If one of the pairs (`scalar_expression`, `value`) returns `FALSE`, then the `ALL` operator returns `FALSE`

## Format

```sql
scalar_expression comparison_operator ALL (subquery)
```

## Examples

Finds the products whose list prices are bigger than the average list price of products of all brands

```sql
SELECT
  product_name,
  list_price
FROM production.products
WHERE list_price > ALL (
  SELECT AVG(list_price) avg_list_price
  FROM production.products
  GROUP BY brand_id
)
ORDER BY list_price
```

Find the products whose list price is less than the smallest price in the average price list by brand

```sql
SELECT
  product_name,
  list_price
FROM production.products
WHERE list_price < ALL (
  SELECT AVG(list_price) AS avg_list_price
  FROM production.products
  GROUP BY brand_id
)
ORDER BY list_price DESC
```
