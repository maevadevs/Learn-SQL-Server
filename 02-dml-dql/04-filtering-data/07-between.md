# `BETWEEN`

---

- [`NOT BETWEEN`](#not-between)
- [Examples `BETWEEN` and `NOT BETWEEN`](#examples-between-and-not-between)

---

- Test if a value is between a range of values
- A logical operator that allows to specify a range to test
- **The values used with `BETWEEN` are inclusive on both end**

```sql
column|expression BETWEEN start_expression AND end_expression
```

1. Specify the column or expression to test
1. Place the `start_expression` and `end_expression` together with the `BETWEEN` and the `AND` keywords

- **The `start_expression`, `end_expression`, and the `expression` to test must have the same data type**
- **Returns `TRUE` if and only if `start_expression <= expression <= end_expression`**

The following is an equivalent of `BETWEEN` using `AND`

```sql
(column|expression >= start_expression)
AND
(column|expression <= end_expression)
```

## `NOT BETWEEN`

- Returns the complement of the result set from `BETWEEN`

```sql
column|expression NOT BETWEEN start_expression AND end_expresion
```

- The following is an equivalent of `NOT BETWEEN` using `OR`

```sql
(column|expression < start_expression)
OR
(column|expression > end_expression)
```

- **NOTE: If any input to `BETWEEN` or `NOT BETWEEN` is `NULL`, then the result is `UNKNOWN`**

## Examples `BETWEEN` and `NOT BETWEEN`

```sql
SELECT Product_Id,
       Product_Name,
       List_Price
  FROM Production.Products
 WHERE List_Price BETWEEN 149.99 AND 199.99
 ORDER BY List_Price;
```

- We use `NOT BETWEEN` to get the complement

```sql
SELECT Product_Id,
       Product_Name,
       List_Price
  FROM Production.Products
 WHERE List_Price NOT BETWEEN 149.99 AND 199.99
 ORDER BY List_Price;
```

- We can use dates with `BETWEEN`
- Remember that `BETWEEN` is inclusive on both end
- **To specify a date constant, you use the formats:**
  - `'YYYYMMDD'`
  - `'YYYY-MM-DD'`
  - `'YYYY/MM/DD'`

```sql
SELECT Order_Id,
       Customer_Id,
       Order_Date,
       Order_Status
  FROM Sales.Orders
 WHERE Order_Date BETWEEN '2017-01-15' AND '2017-01-17'
 ORDER BY Order_Date;
```
