# `ROLLUP`

---

- [Format](#format)
- [`ROLL UP` Examples](#roll-up-examples)

---

- Similar to `CUBE`, also generates multiple Grouping Sets
  - However, it does not produce every single possible combinations
  - Instead, it assumes a ***hierachical order among the selected dimensions and only produce aggregation for each hierarchical level***
- The hierarchy order is the one specified in the `ROLLUP` clause, with higher order going first
  - **The order of the specified hierarchy is important**
- ***So `ROLLUP` generate a subset of the result set of `CUBE`***
- Great use case for getting Subtotals and Grand Totals
  - E.g. Sales by `year > quarter > month > day`

```sql
-- There is no order assumption with CUBE
CUBE (dim_1, dim_2, dim_3, dim_4)

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
```

```sql
-- Assume hierarchy: dim_1 > dim_2 > dim_3 > dim_4
ROLLUP (dim_1, dim_2, dim_3, dim_4)

(dim_1, dim_2, dim_3, dim_4),
(dim_1, dim_2, dim_3),
(dim_1, dim_2),
(dim_1),
()
```

## Format

```sql
SELECT dim_1,
       dim_2,
       dim_3,
       aggregate_function(c4)
  FROM table_name
 GROUP BY ROLLUP (dim_1, dim_2, dim_3);
```

- We can also do a partial roll up to reduce the subtotals generated

```sql
SELECT dim_1,
       dim_2,
       dim_3,
       aggregate_function(c4)
  FROM table_name
 GROUP BY dim_1,
          ROLLUP (dim_2, dim_3);
```

## `ROLL UP` Examples

- Calculate the sales amount by `Brand` (subtotal) and both `Brand` and `Category` (grand total)
- Assuming a hierarchy `Brand > Category`

```sql
SELECT Brand,
       Category,
       SUM(Sales) AS Sales
  FROM Sales.Sales_Summary
 GROUP BY ROLLUP (Brand, Category);
```

- If we change the order of `Brand` and `Category`, the result will be different:

- **`brand > category` is not the same as `category > brand`**

```sql
SELECT Brand,
       Category,
       SUM(Sales) AS Sales
  FROM Sales.Sales_Summary
 GROUP BY ROLLUP (Category, Brand);
```

- We can also just run partial rollups

```sql
SELECT Brand,
       Category,
       SUM(Sales) AS Sales
  FROM Sales.Sales_Summary
 GROUP BY Brand,
          ROLLUP (Category);
```
