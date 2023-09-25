# `HAVING`

---

- [Format](#format)
- [`HAVING` Examples](#having-examples)
  - [`HAVING` with `COUNT()`](#having-with-count)
- [`HAVING` with `SUM()`](#having-with-sum)
- [`HAVING` with `MAX()` and `MIN()`](#having-with-max-and-min)
- [`HAVING` with `AVG()`](#having-with-avg)

---

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
HAVING conditions;
```

- **Remember that, overall, SQL Server processes the clauses in the following sequence:**

```sql
- FROM
- JOIN
- ON
- WHERE
- GROUP BY
- HAVING
- SELECT
- DISTINCT
- ORDER BY
- TOP
```

- **Because SQL Server processes the `HAVING` clause *after* the `GROUP BY` clause and before the `SELECT` clause, you cannot refer to the aggregate function specified in the `SELECT` list by using the column alias**
  - The following will fail:

```sql
SELECT Column_Name1,
       Column_Name2,
       Aggregate_Function(Column_Name3) AS Column_Alias
  FROM Table_Name
 GROUP BY Column_Name1,
          Column_Name2
HAVING Column_Alias > value; -- Cannot use Column_Alias here
```

- Instead, we have to refer to the actual aggregate function in `HAVING`

```sql
SELECT Column_Name1,
       Column_Name2,
       Aggregate_Function(Column_Name3) AS Column_Alias
  FROM Table_Name
 GROUP BY Column_Name1,
          Column_Name2
HAVING Aggregate_Function(Column_Name3) > value; -- Use Aggregate_Function op here instead of the Column_Alias
```

## `HAVING` Examples

### `HAVING` with `COUNT()`

- Find the customers who placed at least two orders per year

```sql
SELECT Customer_Id,
       YEAR(Order_Date) AS Order_Year,
       COUNT(Order_Id) AS Order_Count
  FROM Sales.Orders
 GROUP BY Customer_Id,
          YEAR(Order_Date)
HAVING COUNT(Order_Id) >= 2
 ORDER BY Customer_Id;
```

## `HAVING` with `SUM()`

- Find the sales orders whose net values are greater than 20,000

```sql
SELECT Order_Id,
       SUM(Quantity * List_Price * (1 - Discount)) AS Net_Value
  FROM Sales.Order_Items
 GROUP BY Order_Id
HAVING SUM(Quantity * List_Price * (1 - Discount)) > 20000
 ORDER BY Net_Value DESC;
```

## `HAVING` with `MAX()` and `MIN()`

```sql
SELECT Category_Id,
       MAX(List_Price) AS Max_List_Price,
       MIN(List_Price) AS Min_List_Price
  FROM Production.Products
 GROUP BY Category_Id
HAVING MAX(List_Price) > 4000
       OR MIN(List_Price) < 500;
```

## `HAVING` with `AVG()`

- Find product categories whose average list prices are between 500 and 1,000

```sql
SELECT Category_Id,
       AVG(List_Price) AS Avg_List_Price
  FROM Production.Products
 GROUP BY Category_Id
HAVING AVG(List_Price) BETWEEN 500 AND 1000;
```
