# `RIGHT JOIN`/`RIGHT OUTER JOIN`

---

- [Format](#format)
- [Figure Explanations](#figure-explanations)
- [Example of Right Join](#example-of-right-join)
- [Conditions in `WHERE` vs in `ON` clause](#conditions-in-where-vs-in-on-clause)
  - [Case in `WHERE`: Finds the `Products` that belong to the `Order` id 100](#case-in-where-finds-the-products-that-belong-to-the-order-id-100)
  - [Case in `ON`: Return all `Orders` but only the `Products` with id \> 100 has the associated product's information](#case-in-on-return-all-orders-but-only-the-products-with-id--100-has-the-associated-products-information)
  - [Exclusive Right Join](#exclusive-right-join)
  - [Right Join Exclusive Figure Explanation](#right-join-exclusive-figure-explanation)

---

- Join two or more tables on a column
- Returns all rows from the right table and matching rows or `NULL` values from the left table
- **Right-Prioirty: It is the same as left join with the order of the tables swapped**

## Format

- `OUTER` keyword is optional

```sql
SELECT select_list
  FROM T1
 RIGHT OUTER JOIN T2
               ON join_predicate;

SELECT select_list
  FROM T1
 RIGHT JOIN T2
         ON join_predicate;
```

- Include all rows from the right table that meet the predicate
- Only includes rows from the left table which have matching rows from the right table
- If a row in the right table does not have a matching row in the left table, the columns of the left table will have `NULL`

## Figure Explanations

<img src="../../figures/venn-diagram-right-join.png">

## Example of Right Join

```sql
SELECT P.Product_Name,
       OI.Order_Id
  FROM Production.Products AS P
 RIGHT JOIN Sales.Order_Items AS OI
         ON OI.Product_Id = P.Product_Id
 ORDER BY OI.Order_Id;
```

- We can run right join on multiple tables at once

```sql
SELECT P.Product_Name,
       O.Order_Id,
       OI.Item_Id,
       O.Order_Date
  FROM Production.Products AS P
 RIGHT JOIN Sales.Order_Items AS OI
         ON P.Product_Id = OI.Product_Id
 RIGHT JOIN Sales.Orders AS O
         ON OI.Order_Id = O.Order_Id
 ORDER BY O.Order_Id;
```

## Conditions in `WHERE` vs in `ON` clause

- Conditions could be added on either `ON` or `WHERE`
- Each one would have a different result

### Case in `WHERE`: Finds the `Products` that belong to the `Order` id 100

- Strict Condition: Excluded all orders where the `order_id` does not match the condition given value

```sql
SELECT P.Product_Id,
       P.Product_Name,
       OI.Order_Id
  FROM Production.Products AS P
 RIGHT JOIN Sales.Order_Items AS OI
         ON P.Product_Id = OI.Product_Id
 WHERE OI.Order_Id = 100
 ORDER BY OI.Order_Id DESC;
```

### Case in `ON`: Return all `Orders` but only the `Products` with id > 100 has the associated product's information

- Flexible Condition: Substitute with `NULL` where `Product_Id` does not match the condition given value

```sql
SELECT P.Product_Id,
       P.Product_Name,
       OI.Order_Id
  FROM Production.Products AS P
 RIGHT JOIN Sales.Order_Items AS OI
         ON P.Product_Id = OI.Product_Id
        AND OI.Order_Id BETWEEN 1591 AND 1691
 ORDER BY OI.Order_Id DESC;
```

### Exclusive Right Join

- We can get rows only in the right table but not in the left table by applying a `WHERE` condition with `NULL`

```sql
SELECT P.Product_Id,
       P.Product_Name,
       OI.Order_Id
  FROM Sales.Order_Items AS OI
 RIGHT JOIN Production.Products AS P
         ON OI.Product_Id = P.Product_Id
 WHERE OI.Order_Id IS NULL
 ORDER BY OI.Order_Id;
```

- SQL Server processes the `WHERE` clause after the `RIGHT JOIN` clause

### Right Join Exclusive Figure Explanation

<img src="../../figures/venn-diagram-exclusive-right-join.png">
