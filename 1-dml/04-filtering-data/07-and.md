# `AND`

Combine two Boolean expressions and return `TRUE` if and only if **all** expressions are `TRUE`, otherwise return `FALSE`

- If any expression is `FALSE`, always return `FALSE`
- `FALSE AND UNKNOWN -> FALSE`
- `TRUE AND UNKNOWN -> UNKNOWN`
- `UNKNOWN AND UNKNOWN -> UNKNOWN`

```sql
boolean_expression AND boolean_expression
```

## Examples `AND`

```sql
SELECT *
FROM production.products
WHERE category_id = 1
AND list_price > 400
ORDER BY list_price DESC;
```

We can use multiple conditions with `AND`

```sql
SELECT *
FROM production.products
WHERE category_id = 1
AND list_price > 400
AND brand_id = 1
ORDER BY list_price DESC;
```

- We can also combine with other logical operators
- `AND` takes precedence over `OR`
- If we want to be explicit on the order of priority, we can wrap the conditions inside parentheses

```sql
SELECT *
FROM production.products
WHERE (brand_id = 1 OR brand_id = 2)
AND list_price > 1000
ORDER BY brand_id DESC;
```
