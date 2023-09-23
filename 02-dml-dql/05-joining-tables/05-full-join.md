# `FULL JOIN`/`FULL OUTER JOIN`

---

- [Format](#format)
- [Figure Explanations](#figure-explanations)
- [Example of Full Join](#example-of-full-join)
  - [Exclusive Full Join](#exclusive-full-join)

---

- Returns a result set that includes all rows from both left and right tables
- When no matching rows exist for the row in any table, the columns of the opposite table will have `NULL`

## Format

- `OUTER` keyword is optional

```sql
SELECT select_list
  FROM T1
  FULL OUTER JOIN T2
               ON join_predicate;

SELECT select_list
  FROM T1
  FULL JOIN T2
         ON join_predicate;
```

## Figure Explanations

<img src="../../figures/venn-diagram-full-join.png">

## Example of Full Join

```sql
SELECT P.Product_Name,
       OI.Order_Id
  FROM Production.Products AS P
  FULL JOIN Sales.Order_Items AS OI
         ON P.Product_Id = OI.Product_Id
 ORDER BY OI.Order_Id;
```

### Exclusive Full Join

- We can get rows only in the right table or left tabel but not in the intersection by applying a `WHERE` condition with `NULL`
- This could be considered a complement of `INNER JOIN` with the right conditions

```sql
SELECT P.Product_Name,
       OI.Order_Id
  FROM Production.Products AS P
  FULL JOIN Sales.Order_Items AS OI
         ON P.Product_Id = OI.Product_Id
 WHERE P.Product_Name IS NULL
       OR OI.Order_Id IS NULL
 ORDER BY OI.Order_Id;
```

- **If we apply `IS NOT NULL` with `AND` instead, we get the same result as `INNER JOIN`**

```sql
SELECT P.Product_Name,
       OI.Order_Id
  FROM Production.Products AS P
  FULL JOIN Sales.Order_Items AS OI
         ON P.Product_Id = OI.Product_Id
 WHERE P.Product_Name IS NOT NULL
       AND OI.Order_Id IS NOT NULL
 ORDER BY OI.Order_Id;
```

- This is the same as

```sql
SELECT P.Product_Name,
       OI.Order_Id
  FROM Production.Products AS P
       JOIN Sales.Order_Items AS OI
         ON P.Product_Id = OI.Product_Id
 ORDER BY OI.Order_Id;
```
