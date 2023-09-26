# `EXISTS`

---

- [Format](#format)
- [Examples](#examples)
  - [Using `EXISTS` with a subquery that returns `NULL` example](#using-exists-with-a-subquery-that-returns-null-example)
  - [Using `EXISTS` with a correlated subquery example](#using-exists-with-a-correlated-subquery-example)
  - [`EXISTS` vs `IN` Example](#exists-vs-in-example)
  - [`EXISTS` vs `JOIN`](#exists-vs-join)

---

- Test for the existence of rows in a subquery
- Check whether a subquery returns any row
  - Returns `TRUE` if the subquery returns one or more rows
  - Returns `FALSE` if the subquery returns no rows
- **As soon as the subquery returns a row, the `EXISTS` operator returns `TRUE` and stop processing immediately**
- **Even if the subquery returns a `NULL` value, the `EXISTS` operator is still evaluated to `TRUE`**

## Format

```sql
EXISTS (subquery)
```

## Examples

### Using `EXISTS` with a subquery that returns `NULL` example

- This returns all rows from the `Customers` table
- This is the same as without the `WHERE` condition

```sql
SELECT Customer_Id,
       First_Name,
       Last_Name
  FROM Sales.Customers
 -- This is always TRUE
 WHERE EXISTS (SELECT NULL)
 ORDER BY First_Name,
          Last_Name;
```

### Using `EXISTS` with a correlated subquery example

- If the number of orders placed by the customer is less than or equal to 2, the subquery returns an empty result set that causes the `EXISTS` operator to evaluate to `FALSE`

```sql
SELECT Customer_Id,
       First_Name,
       Last_Name
  FROM Sales.Customers AS C
 WHERE EXISTS (
           SELECT COUNT(*)
             FROM Sales.Orders AS O
            WHERE O.Customer_Id = C.Customer_Id
            GROUP BY Customer_Id
           HAVING COUNT(*) > 2
       )
 ORDER BY First_Name,
          Last_Name;
```

- Based on the result of the `EXISTS` operator, the customer will be included in the result set

### `EXISTS` vs `IN` Example

- The following queries return equivalent results
- However, `EXISTS` is usually better in peformance and atomicity
  - It can return earlier
  - It consider `NULL` values

```sql
SELECT *
  FROM Sales.Orders
 WHERE Customer_Id IN (
           SELECT Customer_Id
             FROM Sales.Customers
            WHERE City = 'San Jose'
       )
 ORDER BY Customer_Id,
          Order_Date;
```

```sql
SELECT *
  FROM Sales.Orders AS O
 WHERE EXISTS (
           SELECT Customer_Id
             FROM Sales.Customers AS C
            WHERE C.Customer_Id = O.Customer_Id
                  AND City = 'San Jose'
       )
 ORDER BY O.Customer_Id,
          Order_Date;
```

### `EXISTS` vs `JOIN`

- `EXISTS` returns `TRUE` or `FALSE`
  - Use `EXISTS` to test if a subquery returns any row
  - Short-circuits as soon as it does
  - Use `EXISTS` when you just need to check the existence of rows from related tables without returnning data from them
- `JOIN` returns rows from combined tables
  - Use `JOIN` to extend the result set by combining it with the columns from related tables

```sql
SELECT Customer_Id,
       First_Name,
       Last_Name
  FROM Sales.Customers AS C
 WHERE EXISTS (
           SELECT COUNT(*)
             FROM Sales.Orders AS O
            WHERE O.Customer_Id = C.Customer_Id
            GROUP BY Customer_Id
           HAVING COUNT (*) > 2
       )
 ORDER BY First_Name,
          Last_Name;
```

- Based on the result of the `EXISTS` operator, the customer will be included in the result set
- However, this can be achieved better and with more details with a `INNER JOIN`

```sql
SELECT C.Customer_Id,
       C.First_Name,
       C.Last_Name,
       COUNT(O.Customer_Id) AS Order_Counts
  FROM Sales.Customers AS C
       JOIN Sales.Orders AS O
       ON C.Customer_Id = O.Customer_Id
 GROUP BY C.Customer_Id,
          C.First_Name,
          C.Last_Name
HAVING COUNT(O.Customer_Id) > 2
 ORDER BY C.First_Name,
          C.Last_Name;
```
