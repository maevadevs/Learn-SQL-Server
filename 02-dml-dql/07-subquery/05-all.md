# `ALL`

---

- [Format](#format)
- [Examples](#examples)

---

- Compare a value with a single-column set of values returned by a subquery
- Return `TRUE` if the value matches **all** values in the set
  - Returns `FALSE` otherwise
- If one of the pairs (`scalar_expression`, `value`) returns `FALSE`, then the `ALL` operator returns `FALSE`

## Format

```sql
scalar_expression comparison_operator ALL (subquery)
```

## Examples

- Finds the products whose list prices are bigger than the average list price of products of all brands

```sql
SELECT Product_Name,
       List_Price
  FROM Production.Products
 WHERE List_Price > ALL (
           SELECT AVG(List_Price) Avg_List_Price
             FROM Production.Products
            GROUP BY Brand_Id
       )
 ORDER BY List_Price;
```

- Find the products whose list price is less than the smallest average price in the list of average prices by brand

```sql
SELECT Product_Name,
       List_Price
  FROM Production.Products
 WHERE List_Price < ALL (
           SELECT AVG(List_Price) Avg_List_Price
             FROM Production.Products
            GROUP BY Brand_Id
       )
 ORDER BY List_Price;
```
