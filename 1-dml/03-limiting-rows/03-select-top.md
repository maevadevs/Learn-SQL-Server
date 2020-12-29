# `SELECT TOP`

- Limit the number of rows returned by a query
- A special case of `OFFSET/FETCH`
- Only returns the `TOP n` or `TOP n%` of the result set
- **Because the order of rows stored in a table is unspecified, the `SELECT TOP` statement is always used in conjunction with the `ORDER BY` clause, similar to `OFFSET/FETCH`**

```sql
SELECT TOP n [PERCENT] [WITH TIES] 
  col1, 
  col2, 
  col3
FROM schema_name.table_name
ORDER BY col1;
```

- The `SELECT` statement can have other clauses
- `n` - Specifies the number of rows to be returned
  - Could be any expressions that returns a float or an int
  - Evaluated to a `FLOAT` value if `PERCENT` is used
  - Otherwise evaluated to a `BIGINT`
- `PERCENT` - The query returns the first `n%` of rows
- `WITH TIES` - If there are tied values, return more rows with values that match the last row in the limited result set
  - Might cause more rows to be returned than you specify with `n`
  - For example, if you want to return the most expensive products, you can use the `TOP 1`. However, if two or more products have the same prices as the most expensive product, then you miss the other most expensive products in the result set
  - To avoid this, you can use `TOP 1 WITH TIES`. It will include not only the first expensive product but also the second one, and so on

## Examples `SELECT TOP`

We can use `SELECT TOP` with a constant value

```sql
SELECT TOP 10
  product_name, 
  list_price
FROM production.products
ORDER BY list_price DESC;
```

We can use `PERCENT` to specify the number of products returned in the result set. If the result is a float, it is rounded to the next integer.

```sql
SELECT TOP 1 PERCENT
  product_name, 
    list_price
FROM production.products
ORDER BY list_price DESC;
```

We can use `WITH TIES` to include any rows that match the values in the last row (ties)

```sql
SELECT TOP 3 WITH TIES 
  product_name, 
  list_price
FROM production.products
ORDER BY list_price DESC;
```
