# `CUBE`

- To quickly generate multiple Grouping Sets
- Grouping Sets specify groupings of data in a single query
- `CUBE` is a subclause of the `GROUP BY` clause 
- **`CUBE` generates all possible Grouping Sets combinations based on the specified dimension columns**
  - With `N` dimension columns specified in the `CUBE`, we will have `2^N-dim` grouping sets

## Format

```sql
SELECT
    dim_1,
    dim_2,
    dim_3,
    dim_4,
    aggregate_function(c5)
FROM table_name
GROUP BY CUBE (dim_1, dim_2, dim_3, dim_4);
```

This is equivalent to:

```sql
SELECT -- N=4 columns
    dim_1,
    dim_2,
    dim_3,
    dim_4,
    aggregate_function(c5)
FROM table_name
GROUP BY GROUPING SETS ( -- 2^N=16 Grouping Sets
    (dim_1, dim_2, dim_3, dim_4), 
    (dim_1, dim_2, dim_3),
    (dim_1, dim_2, dim_4),
    (dim_1, dim_3, dim_4),
    (dim_2, dim_3, dim_4),
    (dim_1, dim_2),
    (dim_1, dim_3),
    (dim_1, dim_4),
    (dim_2, dim_3),
    (dim_2, dim_4),
    (dim_3, dim_4),
    (dim_1),
    (dim_2),
    (dim_3), 
    (dim_4),
    ()
);
```

It is possible to reduce the number of grouping sets by using the CUBE partially

```sql
SELECT
    dim_1,
    dim_2,
    dim_3,
    dim_4,
    aggregate_function(c5)
FROM table_name
GROUP BY
    dim_1,
    dim_2,
    CUBE (dim_3, dim_4);
```

## `CUBE` Examples

```sql
SELECT
    Brand,
    Category,
    SUM(Sales) AS Total_Sales
FROM Sales.Sales_Summary
GROUP BY CUBE(Brand, Category);
```

- 2 dimension columns specified in the `CUBE` clause
  - A total of 4 grouping sets (`2^N-dim`)

We can have a partial `CUBE`

```sql
SELECT
    Brand,
    Category,
    SUM(Sales) AS Total_Sales
FROM Sales.Sales_Summary
GROUP BY
    Brand,
    CUBE(Category);
```
