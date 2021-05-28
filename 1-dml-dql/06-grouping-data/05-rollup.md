# `ROLLUP`

- Similar to `CUBE`, also generate multiple grouping sets
- However, it does not produce all the combination
- Instead, it assumes a **hierachical order among the selected dimension and only produce aggregation for each hierarchical level**
- The hierarchy order is the one specified in the `ROLLUP` clause, with higher order going first
- **The order of the specified hierarchy is important**
- So `ROLLUP` generate a subset of the result set of `CUBE`
- Greate use case for getting Subtotals and Grand Totals
  - E.g. sales by `year > quarter > month > day`

```sql
CUBE (d1, d2, d3)

(d1, d2, d3)
(d1, d2)
(d2, d3)
(d1, d3)
(d1)
(d2)
(d3)
()
```

```sql
ROLLUP (d1, d2, d3) -- Assume hierarchy: d1 > d2 > d3

(d1, d2, d3)
(d1, d2)
(d1)
()
```

## Format

```sql
SELECT
  d1,
  d2,
  d3,
  aggregate_function(c4)
FROM table_name
GROUP BY ROLLUP (d1, d2, d3)
```

We can also do a partial roll up to reduce the subtotals generated

```sql
SELECT
  d1,
  d2,
  d3,
  aggregate_function(c4)
FROM table_name
GROUP BY 
  d1,
  ROLLUP (d2, d3)
```

## `ROLL UP` Examples

Calculate the sales amount by `brand` (subtotal) and both `brand` and `category` (grand total)

Assuming a hierarchy `brand > category`

```sql
SELECT
  brand,
  category,
  SUM (sales) sales
FROM sales.sales_summary
GROUP BY ROLLUP(brand, category)
```

If we change the order of `brand` and `category`, the result will be different:
  - **`brand > category` is not the same as `category > brand`**

```sql
SELECT
  brand,
  category,
  SUM (sales) sales
FROM sales.sales_summary
GROUP BY ROLLUP(category, brand)
```

We can also just run partial rollups

```sql
SELECT
  brand,
  category,
  SUM (sales) sales
FROM sales.sales_summary
GROUP BY
  brand,
  ROLLUP (category)
```
