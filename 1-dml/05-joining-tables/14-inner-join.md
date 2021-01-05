# `INNER JOIN`

- One of the most commonly used joins in SQL Server
- Query data from two or more related tables
- `INNER` keyword is optional. Default join is `INNER`

## Format

```sql
SELECT select_list
FROM T1 INNER JOIN T2 
  ON join_predicate
```

- Only rows that cause the join predicate to evaluate to `TRUE` are included in the result set
- Compares each row of the table `T1` with rows of table `T2`
- Find all pairs of rows that satisfy the join predicate
- Column values of the matching rows of `T1` and `T2` are combined into a new row and included in the result set

## Figure Explanations

<img src="../../figures/venn-diagram-inner-join.png">
<img src="../../figures/inner-join-explanation
.png">

## Example of Inner Join

```sql
SELECT
  product_name,
  category_name,
  list_price
FROM production.products p INNER JOIN production.categories c 
  ON c.category_id = p.category_id
ORDER BY product_name DESC
```

We can run inner join on multiple tables at once

```sql
SELECT
  product_name,
  category_name,
  brand_name,
  list_price
FROM production.products p 
  INNER JOIN production.categories c 
    ON c.category_id = p.category_id
  INNER JOIN production.brands b 
    ON b.brand_id = p.brand_id
ORDER BY product_name DESC
```

## Conditions in `WHERE` vs in `ON` clause

For `INNER JOIN`, the condition in `ON` is functionally equivalent if it is placed in the `WHERE` clause
