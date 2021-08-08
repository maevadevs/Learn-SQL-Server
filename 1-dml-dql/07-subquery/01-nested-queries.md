# Subquery

- A Subquery is a query nested within another statement such as `SELECT`, `INSERT`, `UPDATE` or `DELETE`
- Also known as an *Inner Query* or *Inner Select*
- **Always enclose the `SELECT` query of a subquery in parentheses**
- The query automatically adjusts whenever the data changes

## Example

Find the sales orders of the customers who are located in New York

```sql
SELECT
	Customer_Id,
    Order_Id,
    Order_Date
FROM Sales.Orders
WHERE Customer_Id IN (
    -- This is a subquery
    SELECT Customer_Id
    FROM Sales.Customers
    WHERE City = 'New York'
)
ORDER BY Order_Date DESC;
```

## Order of Execution

- **The inner-most subquery is executed first**
  - Substitute the result of the subquery where the subquery is
- Execute next outer-level query until all parent queries are executed

## Nesting Query

- A subquery can be nested within another subquery
- **SQL Server supports up to 32 levels of nesting**
- However, with each level, there is a performance hit

```sql
-- This is executed 3rd
SELECT
    Product_Name,
    List_Price
FROM Production.Products
WHERE List_Price > (
    -- This is executed 2nd
    SELECT AVG(List_Price)
    FROM Production.Products
    WHERE Brand_Id IN (
        -- This is executed 1st
        SELECT Brand_Id
        FROM Production.Brands
        WHERE Brand_Name = 'Strider'
            OR Brand_Name = 'Trek'
    )
)
ORDER BY List_Price DESC;
```

## SQL Server Subquery Use-Cases

- In place of an expression
- With `IN` or `NOT IN`
- With `ANY` or `ALL`
- With `EXISTS` or `NOT EXISTS`
- In `UPDATE`, `DELETE`, `INSERT`
- In `FROM` 

### Use In Place of an Expression

- If a subquery returns a single value, it can be used anywhere an expression is used
- **This can be used to create *Calculated Columns***

```sql
SELECT
    Order_Id,
    Order_Date,
    (
        SELECT MAX(List_Price)
        FROM Sales.Order_Items AS OI
        WHERE OI.Order_Id = O.Order_Id
    ) AS Max_List_Price
FROM Sales.Orders AS O
ORDER BY Order_Date DESC;
```

### Use With `IN` or `NOT IN`

- Returns a set of zero or more values
- After the subquery returns values, the outer query makes use of them
- **This can be used for *Filtering***


Find the names of all mountain bikes and road bikes products that the Bike Stores sell

```sql
SELECT
    Product_Id,
    Product_Name
FROM Production.Products
WHERE Category_Id IN (
    SELECT Category_Id
    FROM Production.Categories
    WHERE Category_Name = 'Mountain Bikes'
        OR Category_Name = 'Road Bikes'
);
```

### Use With `ANY` or `ALL`

Follows the syntax

```sql
scalar_expression comparison_operator ANY|ALL (subquery)
```

- Assuming that the subquery returns a list of value `v1`, `v2`,... `vn`
  - `ANY` returns `TRUE` if just one of a comparison pair evaluates to `TRUE`
    - `FALSE` otherwise
  - `ALL` returns `TRUE` only if all comparison pairs evaluate to `TRUE`
    - `FALSE` otherwise

Find the products whose list prices are greater than or equal to the average list price of any product brand

```sql
SELECT
    Product_Name,
    List_Price
FROM Production.Products
WHERE List_Price >= ANY (
    SELECT AVG(List_Price)
    FROM Production.Products
    GROUP BY Brand_Id
);
```

Finds the products whose list price is greater than or equal to all the average list prices returned by the subquery

```sql
SELECT
    Product_Name,
    List_Price
FROM Production.Products
WHERE List_Price >= ALL (
    SELECT AVG(List_Price)
    FROM Production.Products
    GROUP BY Brand_Id
);
```

### Use With `EXISTS` or `NOT EXISTS`

Follows the syntax

```sql
WHERE [NOT] EXISTS (subquery)
```

- **The condition evaluates to `TRUE` *right away* if the subquery returns any result (subquery contains any row)**
  - Otherwise, the condition evaluates to `FALSE`
  - Using `NOT` flips this
  - This is faster and better than using `IN` and `NOT IN`

Finds the customers who bought products in 2017

```sql
SELECT
    Customer_Id,
    First_Name,
    Last_Name,
    City
FROM Sales.Customers AS C
WHERE EXISTS (
    SELECT Customer_Id
    FROM Sales.Orders AS O
    WHERE O.Customer_Id = C.Customer_Id
    AND YEAR(Order_Date) = 2017
)
ORDER BY
    First_Name,
    Last_Name;
```

Find the customers who did not buy any products in 2017

```sql
SELECT
    Customer_Id,
    First_Name,
    Last_Name,
    City
FROM Sales.Customers AS C
WHERE NOT EXISTS (
    SELECT Customer_Id
    FROM Sales.Orders AS O
    WHERE O.Customer_Id = C.Customer_Id
    AND YEAR(Order_Date) = 2017
)
ORDER BY
    First_Name,
    Last_Name;
```

### Use with `FROM`

- ***This is useful to use the result set as a temporary table***
- The query in the `FROM` clause **must have a table alias**

```sql
SELECT columns
FROM subquery;
```

```sql
SELECT AVG(Temp_Table.Order_Count) AS Avg_Order_Count_By_Staff
FROM (
    SELECT 
        Staff_Id, 
        COUNT(Order_Id) AS Order_Count
    FROM Sales.Orders
    GROUP BY Staff_Id
) AS Temp_Table;
```
