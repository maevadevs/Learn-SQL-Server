# `CUBE`

- To generate multiple grouping sets
- Grouping sets specify groupings of data in a single query
- `CUBE` is a subclause of the `GROUP BY` clause 
- `CUBE` generates all possible grouping sets based on the dimension columns
- With `N` dimension columns specified in the `CUBE`, we will have `2^N-dim` grouping sets
- **`CUBE` generate all the possible combinations from the specified dimensions**

## Format

```sql
SELECT
  d1,
  d2,
  d3,
  aggregate_function (c4)
FROM table_name
GROUP BY CUBE (d1, d2, d3)
```

This is equivalent to:

```sql
SELECT -- N=4 columns
  d1,
  d2,
  d3,
  aggregate_function (c4)
FROM table_name
GROUP BY GROUPING SETS ( -- 2N=8 grouping sets
  (d1,d2,d3), 
  (d1,d2),
  (d1,d3),
  (d2,d3),
  (d1),
  (d2),
  (d3), 
  ()
)
```

It is possible to reduce the number of grouping sets by using the CUBE partially

```sql
SELECT
  d1,
  d2,
  d3,
  aggregate_function (c4)
FROM table_name
GROUP BY
  d1,
  CUBE (d2, d3)
```

## `CUBE` Examples

```sql
SELECT
  brand,
  category,
  SUM (sales) AS total_sales
FROM sales.sales_summary
GROUP BY CUBE(brand, category)
```

- 2 dimension columns specified in the `CUBE` clause
  - A total of 4 grouping sets (2^N-dim)

We can have a partial `CUBE`

```sql
SELECT
  brand,
  category,
  SUM (sales) sales
FROM sales.sales_summary
GROUP BY
  brand,
  CUBE(category)
```
