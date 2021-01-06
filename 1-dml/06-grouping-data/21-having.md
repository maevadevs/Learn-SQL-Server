# `HAVING`

- Specify a search condition for a group or an aggregate
- Used with the `GROUP BY` clause to filter groups based on a specified list of conditions
- `GROUP BY` summarizes the rows into groups
- `HAVING` applies one or more conditions to these groups
  - Only groups that make the conditions evaluate to `TRUE` are included in the result
  - The groups for which the condition evaluates to  `FALSE` or `UNKNOWN` are filtered out

## Format

```sql
SELECT select_list
FROM table_name
GROUP BY group_list
HAVING conditions
```

**Because SQL Server processes the `HAVING` clause *after* the `GROUP BY` clause, you cannot refer to the aggregate function specified in the select list by using the column alias**

The following will fail:

```sql
SELECT
  column_name1,
  column_name2,
  aggregate_function (column_name3) AS column_alias
FROM table_name
GROUP BY
  column_name1,
  column_name2
HAVING column_alias > value
```

## `HAVING` Examples

### `HAVING` with `COUNT()`

Find the customers who placed at least two orders per year

```sql
SELECT
  customer_id,
  YEAR (order_date) AS order_year,
  COUNT (order_id) AS order_count
FROM sales.orders
GROUP BY
  customer_id,
  YEAR (order_date)
HAVING COUNT (order_id) >= 2
ORDER BY customer_id
```

## `HAVING` with `SUM()`

Find the sales orders whose net values are greater than 20,000

```sql
SELECT
  order_id,
  SUM (quantity * list_price * (1 - discount)) AS net_value
FROM sales.order_items
GROUP BY order_id
HAVING
  SUM (quantity * list_price * (1 - discount)) > 20000
ORDER BY net_value
```

## `HAVING` with `MAX()` and `MIN()`

```sql
SELECT
  category_id,
  MAX (list_price) AS max_list_price,
  MIN (list_price) AS min_list_price
FROM production.products
GROUP BY category_id
HAVING MAX (list_price) > 4000 
  OR MIN (list_price) < 500
```

## `HAVING` with `AVG()`

Find product categories whose average list prices are between 500 and 1,000

```sql
SELECT
  category_id,
  AVG (list_price) AS avg_list_price
FROM production.products
GROUP BY category_id
HAVING AVG (list_price) BETWEEN 500 AND 1000
```
