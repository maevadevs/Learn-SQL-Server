# `BETWEEN`

- Test if a value is between a range of values
- A logical operator that allows to specify a range to test
- **The values used with `BETWEEN` are inclusive on both end**

```sql
column|expression BETWEEN start_expression AND end_expression
```

1. Specify the column or expression to test
1. Place the `start_expression` and `end_expression` together with the `BETWEEN` and the `AND` keywords

- **The `start_expression`, `end_expression`, and the `expression` to test must have the same data type**
- Returns `TRUE` if and only if `start_expression <= expression <= end_expression`

The following is an equivalent of `BETWEEN` using `AND`

```sql
(column|expression >= start_expression)
AND 
(column|expression <= end_expression)
```

## `NOT BETWEEN`

Returns the complement of the result set from `BETWEEN`

```sql
column|expression NOT BETWEEN start_expression AND end_expresion
```

The following is an equivalent of `NOT BETWEEN` using `AND`

```sql
(column|expression < start_expression)
AND 
(column|expression > end_expression)
```

**If any input to the `BETWEEN` or `NOT BETWEEN` is `NULL`, then the result is `UNKNOWN`**

## Examples `BETWEEN` and `NOT BETWEEN`

```sql
SELECT 
  product_id, 
  product_name, 
  list_price
FROM production.products
WHERE list_price BETWEEN 149.99 AND 199.99
ORDER BY list_price
```

We use `NOT BETWEEN` to get the complement

```sql
SELECT 
  product_id, 
  product_name, 
  list_price
FROM production.products
WHERE list_price NOT BETWEEN 149.99 AND 199.99
ORDER BY list_price
```

- We can use dates with `BETWEEN`
- Remember that `BETWEEN` is inclusive on both end
- To specify a date constant, you use the format `YYYYMMDD`, `YYYY-MM-DD`, or `YYYY/MM/DD`

```sql
SELECT 
  order_id, 
  customer_id, 
  order_date, 
  order_status
FROM sales.orders
WHERE order_date BETWEEN '2017-01-15' AND '2017-01-17'
ORDER BY order_date
```
