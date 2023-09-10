# `INNER JOIN`

- One of the most commonly used joins in SQL Server
- Query data from two or more related tables
- **`INNER` keyword is optional: Default join is `INNER`**

## Format

```sql
SELECT select_list
FROM T1 
[INNER] JOIN T2 
    ON join_predicate;
```

- Only rows that cause the join predicate to evaluate to `TRUE` are included in the result set
- Compares each row of the table `T1` with rows of table `T2`
- Find all pairs of rows that satisfy the join predicate
- Column values of the matching rows of `T1` and `T2` are combined into a new row and included in the result set

## Figure Explanations

<img src="../../figures/venn-diagram-inner-join.png">
<img src="../../figures/inner-join-explanation.png">

## Example of Inner Join

```sql
SELECT
    Product_Name,
    Category_Name,
    List_Price
FROM Production.Products AS P 
INNER JOIN Production.Categories AS C 
    ON C.Category_Id = P.Category_Id
ORDER BY Product_Name DESC;
```

We can run inner join on multiple tables at once

```sql
SELECT
    Product_Name,
    Category_Name,
    List_Price,
    Brand_Name
FROM Production.Products AS P 
INNER JOIN Production.Categories AS C 
    ON C.Category_Id = P.Category_Id
INNER JOIN Production.Brands AS B 
    ON B.Brand_Id = P.Brand_Id
ORDER BY Product_Name DESC;
```

## Conditions in `WHERE` vs in `ON` clause

- Normally, filtering is processed in the `WHERE` clause once the two tables have already been joined
- It is possible though that you might want to filter one or both of the tables before joining them
  - The `WHERE` clause applies to the whole result set (after join)
  - The `ON` clause only applies while the tables are being joined
- **For `INNER JOIN`, additional conditions in `ON` is functionally equivalent if it is placed in the `WHERE` clause**

```sql
SELECT *
FROM Sales.Customers AS C
JOIN Sales.Orders AS O
    ON C.Customer_Id = O.Customer_Id
WHERE C.Customer_Id = 1
    AND O.Order_Id > 1000;
```

Which is functionally equivalent to

```sql
SELECT *
FROM Sales.Customers AS C
JOIN Sales.Orders AS O
    ON C.Customer_Id = O.Customer_Id
    AND C.Customer_Id = 1
    AND O.Order_Id > 1000;
```
