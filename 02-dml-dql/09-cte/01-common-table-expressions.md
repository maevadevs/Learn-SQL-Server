# Common Table Expressions with `WITH`

- A CTE allows to define a temporary named result set that is available in memory in the execution scope of the statement
- CTEs are preferred over Subqueries because of their readability

## Format

```sql
WITH expression_name [(column_name [,...])] AS (
    CTE_Definition
)
SQL_Statement;
```

- Specify the `expression_name` to which we can refer later in a query
- Specify a list of comma-separated columns after `expression_name` (Optional)
  - This can be used to give aliases to the columns
  - The number of columns must be the same as the number of columns defined in the `CTE_Definition`
- Use the `AS` keyword after the expression name or column list
- Define a `SELECT` statement whose result set populates the CTE
- Refer to the CTE in a `SQL_Statement` such as `SELECT`, `INSERT`, `UPDATE`, `DELETE`, or `MERGE`

## CTE Examples

Return the sales amounts by sales staffs in 2018

```sql
WITH Cte_Sales_Amounts (Staff_Name, Sales, Year) AS (
    SELECT    
        First_Name + ' ' + Last_Name, 
        SUM(Quantity * List_Price * (1 - Discount)),
        YEAR(Order_Date)
    FROM Sales.Orders AS O
    INNER JOIN Sales.Order_Items AS OI 
        ON OI.Order_Id = O.Order_Id
    INNER JOIN Sales.Staffs AS S
        ON S.Staff_Id = O.Staff_Id
    GROUP BY 
        First_Name + ' ' + Last_Name,
        YEAR(Order_Date)
)
SELECT
    Staff_Name, 
    Sales
FROM Cte_Sales_Amounts
WHERE Year = 2018;
```

Return the average number of sales orders in 2018 for all sales staffs

```sql
WITH Cte_Sales AS (
    SELECT 
        Staff_Id, 
        COUNT(*) AS Order_Count  
    FROM Sales.Orders
    WHERE YEAR(Order_Date) = 2018
    GROUP BY Staff_Id
)
SELECT AVG(Order_Count) AS Average_Orders_By_Staff
FROM Cte_Sales;
```

Return the number of the products and sales for each product category

```sql
WITH Cte_Category_Counts (
    Category_Id, 
    Category_Name, 
    Product_Count
) AS (
    SELECT 
        C.Category_Id, 
        C.Category_Name, 
        COUNT(P.Product_Id)
    FROM Production.Products AS P
    INNER JOIN Production.Categories AS C
        ON C.Category_Id = P.Category_Id
    GROUP BY 
        C.Category_Id, 
        C.Category_Name
),
Cte_Category_Sales (Category_Id, Sales) AS (
    SELECT    
        P.Category_Id, 
        SUM(OI.Quantity * OI.List_Price * (1 - OI.Discount))
    FROM Sales.Order_Items AS OI
    INNER JOIN Production.Products AS P 
        ON P.Product_Id = OI.Product_Id
    INNER JOIN Sales.Orders AS O 
        ON O.Order_Id = OI.Order_Id
    WHERE Order_Status = 4 -- completed
    GROUP BY P.Category_Id
) 
SELECT 
    C.Category_Id, 
    C.Category_Name, 
    C.Product_Count, 
    S.Sales
FROM Cte_Category_Counts AS C
INNER JOIN Cte_Category_Sales AS S 
    ON S.Category_Id = C.Category_Id
ORDER BY C.Category_Name;
```