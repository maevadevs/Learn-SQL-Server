# `GROUPING SETS`

- Generates multiple grouping sets

## Creating a New Table for Example

Retrieve the sales amount data by brand and category and populate it into the `sales.sales_summary` table

```sql
SELECT
  b.brand_name AS brand,
  c.category_name AS category,
  p.model_year,
  round(
    SUM (quantity * i.list_price * (1 - discount)),
    0
  ) AS sales 
  -- Create into a new table
  INTO sales.sales_summary
FROM sales.order_items i
INNER JOIN production.products p 
  ON p.product_id = i.product_id
  INNER JOIN production.brands b 
    ON b.brand_id = p.brand_id
    INNER JOIN production.categories c 
      ON c.category_id = p.category_id
GROUP BY
  b.brand_name,
  c.category_name,
  p.model_year
ORDER BY
  b.brand_name,
  c.category_name,
  p.model_year
```

- A *Grouping Set* is a group of columns by which you group
  - A single query with an aggregate defines a single grouping set

The following query defines a grouping set that includes `brand` and `category` which is denoted as `(brand, category)`

```sql
SELECT
  brand,
  category,
  SUM (sales) AS sales
FROM sales.sales_summary
GROUP BY -- 1 Grouping set (brand, category)
  brand,
  category
ORDER BY
  brand,
  category
```

The following query returns the sales amount by `brand`: It defines a grouping set `(brand)`

```sql
SELECT
  brand,
  SUM (sales) AS sales
FROM sales.sales_summary
GROUP BY brand -- 1 Grouping Set (brand)
ORDER BY brand
```

The following query defines an *empty* grouping set `()`: It returns the sales amount for *all* brands and categories
  - There is no grouping

```sql
SELECT SUM (sales) AS sales
FROM sales.sales_summary
```

So we can have multiple queries with different grouping sets

```
(brand, category)
(brand)
(category)
()
```

## `UNION ALL`

- To get a unified result set with the aggregated data for all grouping sets, you can use `UNION ALL`
- `UNION ALL` operator requires all result set to have the same number of columns
  - We need to add `NULL` to the select list to the queries

```sql
SELECT
  brand,
  category,
  SUM (sales) AS sales
FROM sales.sales_summary
GROUP BY
  brand,
  category

UNION ALL

SELECT
  brand,
  NULL,
  SUM (sales) AS sales
FROM sales.sales_summary
GROUP BY brand

UNION ALL

SELECT
  NULL,
  category,
  SUM (sales) AS sales
FROM sales.sales_summary
GROUP BY category

UNION ALL

SELECT -- Need the same number of columns
  NULL,
  NULL,
  SUM (sales)
FROM sales.sales_summary
ORDER BY brand, category
```

- The query generated a single result with the aggregates for all grouping sets as we expected
- But it has two major problems:
  - The query is quite lengthy
  - The query is slow: 
    - Execute four subqueries
    - Combine the result sets into a single one

To fix this, SQL Server provides a subclause of the `GROUP BY` clause called `GROUPING SETS`

## `GROUPING SETS`

- Defines multiple grouping sets in the same query

### Format

```sql
SELECT
  column1,
  column2,
  aggregate_function (column3) AS alias
FROM table_name
GROUP BY GROUPING SETS (
  (column1, column2),
  (column1),
  (column2),
  ()
)
```

This query creates 4 grouping sets:

```
(column1,column2)
(column1)
(column2)
()
```

### Example `GROUPING SETS`

The previous query with `UNION ALL` can be re-written as follow

```sql
SELECT
  brand,
  category,
	SUM (sales) AS sales
FROM sales.sales_summary
GROUP BY GROUPING SETS (
  (brand, category),
  (brand),
  (category),
  ()
)
ORDER BY
	brand,
	category
```

## `GROUPING()`

Indicates whether a specified column in a `GROUP BY` clause is aggregated or not

- Returns `1` for aggregated
- Returns `0` for not aggregated

### `GROUPING()` Example

```sql
SELECT
  GROUPING (brand) AS grouping_brand,
  GROUPING (category) AS grouping_category,
  brand,
  category,
  SUM (sales) sales
FROM sales.sales_summary
GROUP BY GROUPING SETS (
  (brand, category),
  (brand),
  (category),
  ()
)
ORDER BY
  brand,
  category
```
