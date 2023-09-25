# `CROSS JOIN`

---

- [Format](#format)
- [Figure Explanations](#figure-explanations)
- [Example of Cross Joins](#example-of-cross-joins)

---

- Returns a Cartesian product of rows from both tables
- Join every single row from the first table with every single row from the second table
- Does not establish a relationship between the joined tables
  - No join condition is required
- **NOTE: Cross-joins can negatively affect performance because we join every single row from one table to every single row in the second table**

## Format

```sql
SELECT select_list
  FROM T1
 CROSS JOIN T2;
```

- The count of result rows is the same as

```sql
SELECT (SELECT Count(*) FROM T1) * (SELECT Count(*) FROM T2)
```

## Figure Explanations

<img src="../../figures/cross-join-explanation.png">

## Example of Cross Joins

- Combinations of all products and stores

```sql
SELECT P.Product_Id,
       P.Product_Name,
       S.Store_Id,
       0 AS Quantity -- Giving a default value
  FROM Production.Products P
 CROSS JOIN Sales.Stores S
 ORDER BY P.Product_Name,
          S.Store_Id;
```

- Find products that have no sales across the stores

```sql
WITH SPS AS (
    -- Store | Product | Sales
    SELECT S.Store_Id,
           P.Product_Id,
           SUM(OI.Quantity * OI.List_Price) AS Sales
      FROM Sales.Orders AS O
           JOIN Sales.Order_Items AS OI
             ON O.Order_Id = OI.Order_Id
           JOIN Sales.Stores AS S
             ON O.Store_Id = S.Store_Id
           JOIN Production.Products AS P
             ON OI.Product_Id = P.Product_Id
     GROUP BY S.Store_Id,
              P.Product_Id
)
SELECT S.Store_Id,
       P.Product_Id,
       ISNULL(SPS.Sales, 0) AS Sales
  FROM Sales.Stores AS S
 CROSS JOIN Production.Products AS P
  LEFT JOIN SPS
         ON S.Store_Id = SPS.Store_Id
        AND SPS.Product_Id = P.Product_Id
 WHERE Sales IS NULL
 ORDER BY P.Product_Id,
          S.Store_Id;
```
