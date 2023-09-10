USE BikeStores;
GO

/**
 * Create or Restore BikeStores Database
 * - Load data for Sales.Sales_Summary
 *
 * This is used in 06-grouping-data/03-union-all-and-grouping-sets
 */

SELECT
    B.Brand_Name AS Brand,
    C.Category_Name AS Category,
    P.Model_Year,
    ROUND(
        SUM(Quantity * OI.List_Price * (1 - Discount)),
        0
    ) AS Sales
INTO Sales.Sales_Summary -- Create into a new table
FROM Sales.Order_Items AS OI
INNER JOIN Production.Products AS P
    ON P.Product_Id = OI.Product_Id
INNER JOIN Production.Brands AS B
    ON B.Brand_Id = P.Brand_Id
INNER JOIN Production.Categories AS C
    ON C.Category_Id = P.Category_Id
GROUP BY
    B.Brand_Name,
    C.Category_Name,
    P.Model_Year
ORDER BY
    B.Brand_Name,
    C.Category_Name,
    P.Model_Year;
GO
