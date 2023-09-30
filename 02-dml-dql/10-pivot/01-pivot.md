# `PIVOT`

---

- [Steps for Pivotting](#steps-for-pivotting)
- [Generating Column Values](#generating-column-values)
- [Generating Column Values Dynamically](#generating-column-values-dynamically)

---

- For converting rows into columns
- Rotates a table-valued expression
- Turns the unique values in one column into multiple columns in the output
- Performs aggregations on any remaining column values

```sql
-- Find the number of product by category
SELECT Category_Name,
       COUNT(Product_Id) AS Product_Count
  FROM Production.Products AS P
       JOIN Production.Categories AS C
         ON P.Category_Id = C.Category_Id
 GROUP BY Category_Name;
```

- Now, we want to turn the list of categories in `Category_Name` into their own columns
- We could add additional column to group the result

## Steps for Pivotting

- Select a base dataset for pivoting

```sql
SELECT Category_Name,
       Product_Id
  FROM Production.Products AS P
       JOIN Production.Categories AS C
         ON P.Category_Id = C.Category_Id;
```

- Create a temporary result with a derived table or CTE

```sql
SELECT *
  FROM (
           SELECT Category_Name,
                  Product_Id
             FROM Production.Products AS P
                  JOIN Production.Categories AS C
                    ON P.Category_Id = C.Category_Id
       ) AS Temp;
```

- Apply the `PIVOT` operator

```sql
SELECT *
  FROM (
           SELECT Category_Name,
                  Product_Id
             FROM Production.Products AS P
                  JOIN Production.Categories AS C
                    ON P.Category_Id = C.Category_Id
       ) AS Temp
 PIVOT (
           COUNT(Product_Id)
           FOR Category_Name IN (
                   [Children Bicycles],
                   [Comfort Bicycles],
                   [Cruisers Bicycles],
                   [Cyclocross Bicycles],
                   [Electric Bikes],
                   [Mountain Bikes],
                   [Road Bikes]
               )
       ) AS Pivot_Table;
```

- If we add additional columns to the Temporary table, they become *Grouping Columns*

```sql
  WITH Temp AS (
           SELECT Category_Name,
                  -- Grouping Column
                  Model_Year,
                  -- Grouing Column
                  Brand_Id,
                  Product_Id
             FROM Production.Products AS P
                  JOIN Production.Categories AS C
                    ON P.Category_Id = C.Category_Id
       )
SELECT *
  FROM Temp
 PIVOT (
           COUNT(Product_Id)
           FOR Category_Name IN (
                   [Children Bicycles],
                   [Comfort Bicycles],
                   [Cruisers Bicycles],
                   [Cyclocross Bicycles],
                   [Electric Bikes],
                   [Mountain Bikes],
                   [Road Bikes]
               )
       ) AS Pivot_Table;
```

## Generating Column Values

- Instead of manually listing the column names in `PIVOT()`, we can use `QUOTENAME()` to generate them
- `LEFT()` removes the last comma from the `@columns` string
- The `QUOTENAME()` function wraps the category name by the square brackets

```sql
--Generating the column names list into a variable
DECLARE @columns NVARCHAR(MAX) = '';

SELECT @columns += QUOTENAME(Category_Name) + ','
  FROM Production.Categories
 ORDER BY Category_Name;

SET @columns = LEFT(@columns, LEN(@columns) - 1);

PRINT @columns;
```

## Generating Column Values Dynamically

- Construct the category name list and pass it to an SQL statement
- Execute this statement dynamically using the stored procedure `sp_executesql`

```sql
DECLARE @columns NVARCHAR(MAX) = '',
        @sql NVARCHAR(MAX) = '';

-- Select the category names
SELECT @columns += QUOTENAME(category_name) + ','
  FROM Production.Categories
 ORDER BY Category_name;

-- Remove the last comma
SET @columns = LEFT(@columns, LEN(@columns) - 1);

-- Construct dynamic SQL
SET @sql = '
        WITH Temp AS (
                 SELECT Category_Name,
                        -- Grouping Column
                        Model_Year,
                        -- Grouing Column
                        Brand_Id,
                        Product_Id
                   FROM Production.Products AS P
                        JOIN Production.Categories AS C
                          ON P.Category_Id = C.Category_Id
             )
      SELECT *
        FROM Temp
       PIVOT (
                 COUNT(Product_Id)
                 FOR Category_Name IN ('+ @columns +')
             ) AS Pivot_Table;
    ';

-- Execute the dynamic SQL
EXECUTE sp_executesql @sql;
```
