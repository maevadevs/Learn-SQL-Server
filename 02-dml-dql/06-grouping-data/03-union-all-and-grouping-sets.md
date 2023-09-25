# `GROUPING SETS`

---

- [Creating a New Table for Example](#creating-a-new-table-for-example)
- [`UNION ALL`](#union-all)
- [`GROUPING SETS`](#grouping-sets-1)
  - [Format](#format)
  - [Example `GROUPING SETS`](#example-grouping-sets)
- [`GROUPING()`](#grouping)
  - [`GROUPING()` Example](#grouping-example)

---

- Generates multiple grouping sets in one query
- Think of it as a way to generate in one single result set:
  - aggregates/subtotals by subgroups
  - aggregates/subtotals by groups
  - aggregates/grand-total

## Creating a New Table for Example

Retrieve the sales amount data by brand and category and populate it into the `Sales.Sales_Summary` table

```sql
SELECT B.Brand_Name                                             AS Brand,
       C.Category_Name                                          AS Category,
       P.Model_Year,
       ROUND(SUM(Quantity * OI.List_Price * (1 - Discount)), 0) AS Sales
  INTO Sales.Sales_Summary -- Create into a new table
  FROM Sales.Order_Items AS OI
       JOIN Production.Products AS P
         ON P.Product_Id = OI.Product_Id
       JOIN Production.Brands AS B
         ON B.Brand_Id = P.Brand_Id
       JOIN Production.Categories AS C
         ON C.Category_Id = P.Category_Id
 GROUP BY B.Brand_Name,
          C.Category_Name,
          P.Model_Year
 ORDER BY B.Brand_Name,
          C.Category_Name,
          P.Model_Year;
```

- A *Grouping Set* is a group of columns by which you group
  - A single `GROUP BY` query with an aggregate function defines a single grouping set

The following query defines a grouping set that includes `Brand` and `Category` which is denoted as `(Brand, Category)`

```sql
SELECT
    Brand,
    Category,
    SUM(Sales) AS Sales
FROM Sales.Sales_Summary
GROUP BY -- 1 Grouping Set (Brand, Category)
    Brand,
    Category
ORDER BY
    Brand,
    Category;
```

The following query returns the sales amount by `Brand`: It defines a grouping set `(Brand)`

```sql
SELECT
    Brand,
    SUM(Sales) AS Sales
FROM Sales.Sales_Summary
GROUP BY Brand -- 1 Grouping Set (Brand)
ORDER BY Brand;
```

The following query defines an *Empty* grouping set `()`: It returns the sales amount for *All* brands and categories

- There is no grouping: This is the **Grand-Total**

```sql
SELECT SUM(Sales) AS Sales
FROM Sales.Sales_Summary;
```

So we can have multiple queries with different grouping sets

```
(Brand, Category)
(Brand)
(Category)
()
```

## `UNION ALL`

- To get a unified result set with the aggregated data for all those grouping sets, we could use `UNION ALL`
- **`UNION ALL` operator requires all result set to have the same number of columns**
  - We need to add `NULL` to the select list to the queries

```sql
-- For Grouping Set: (Brand, Category)
SELECT
    Brand,
    Category,
    SUM(Sales) AS Sales
FROM Sales.Sales_Summary
GROUP BY
    Brand,
    Category
UNION ALL
-- For Grouping Set: (Brand)
SELECT
    Brand,
    NULL,
    SUM(Sales) AS Sales
FROM Sales.Sales_Summary
GROUP BY Brand
UNION ALL
-- For Grouping Set: (Category)
SELECT
    NULL,
    Category,
    SUM(Sales) AS Sales
FROM Sales.Sales_Summary
GROUP BY Category
UNION ALL
-- For Grouping Set: ()
SELECT
    NULL,
    NULL,
    SUM(Sales) AS Sales
FROM Sales.Sales_Summary
ORDER BY
    Brand,
    Category;
```

- The query generated a single result set with the aggregates for all grouping sets as we expected
- But it has two major problems:
  - The query is quite lengthy
  - The query is slow:
    - Execute four subqueries
    - Combine the result sets into a single one with `UNION ALL`

To fix this, SQL Server provides a subclause of the `GROUP BY` clause called `GROUPING SETS`

## `GROUPING SETS`

- Defines multiple grouping sets in the same query

### Format

```sql
SELECT
    column1,
    column2,
    aggregate_function(column3) AS alias
FROM table_name
GROUP BY GROUPING SETS (
    (column1, column2),
    (column1),
    (column2),
    ()
);
```

This query creates 4 grouping sets:

```
(column1, column2)
(column1)
(column2)
()
```

### Example `GROUPING SETS`

The previous query with `UNION ALL` can be re-written as follow

```sql
SELECT
    Brand,
    Category,
    SUM(Sales) AS Sales
FROM Sales.Sales_Summary
GROUP BY GROUPING SETS (
    (Brand, Category),
    (Brand),
    (Category),
    ()
)
ORDER BY
    Brand DESC,
    Category DESC;
```

## `GROUPING()`

Indicates whether a specified column in a `GROUP BY` clause is aggregated on or not

- Returns `1` for aggregated
- Returns `0` for not aggregated

### `GROUPING()` Example

```sql
SELECT
    GROUPING(Brand) AS Is_Grouping_Brand,
    GROUPING(Category) AS Is_Grouping_Category,
    Brand,
    Category,
    SUM(Sales) AS Sales
FROM Sales.Sales_Summary
GROUP BY GROUPING SETS (
    (Brand, Category),
    (Brand),
    (Category),
    ()
)
ORDER BY
    Brand,
    Category;
```
