# `ANY`/`SOME`

---

- [Format](#format)
- [Examples](#examples)

---

- Compare a value with a single-column set of values returned by a subquery
- Returns `TRUE` if any comparison (`scalar_expression`, `value`) returns `TRUE`
  - Returns `FALSE` otherwise
- **`SOME` is an alias to `ANY`**

## Format

```sql
scalar_expression comparison_operator ANY (subquery)
```

## Examples

Find the products that were sold with more than two units in a sales order

```sql
SELECT Product_Name,
       List_Price
  FROM Production.Products
 WHERE Product_Id = ANY (
           SELECT Product_Id
             FROM Sales.Order_Items
            WHERE Quantity >= 2
       )
 ORDER BY Product_Name;
```

- `ANY` is similar to `IN` when using the `=` operator
- However, it behaves differently with other operators
- So the previous query is equivalent to the following:

```sql
SELECT Product_Name,
       List_Price
  FROM Production.Products
 WHERE Product_Id IN (
           SELECT Product_Id
             FROM Sales.Order_Items
            WHERE Quantity >= 2
       )
 ORDER BY Product_Name;
```
