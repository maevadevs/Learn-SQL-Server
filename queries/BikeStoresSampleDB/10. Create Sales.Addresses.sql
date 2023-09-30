USE BikeStores;

GO

/**
 * Create or Restore BikeStores Database
 * - Load data for Sales.Promotions
 *
 * This is used in 11-modifying-data/02-insert-into-select
 */
CREATE TABLE Sales.Addresses (
           Address_Id INT IDENTITY PRIMARY KEY,
               Street VARCHAR (255) NOT NULL,
                 City VARCHAR (50),
              "State" VARCHAR (25),
             Zip_Code VARCHAR (5)
       );

GO

INSERT INTO Sales.Addresses (
           Street,
           City,
           "State",
           Zip_Code
       )
SELECT Street,
       City,
       "State",
       Zip_Code
  FROM Sales.Customers
 ORDER BY First_Name,
          Last_Name;

GO

INSERT INTO Sales.Addresses (
           Street,
           City,
           "State",
           Zip_Code
       )
SELECT Street,
       City,
       "State",
       Zip_Code
  FROM Sales.Stores
 WHERE City IN (
           'Santa Cruz',
           'Baldwin'
       );

GO

INSERT TOP (10)
  INTO Sales.Addresses (
           Street,
           City,
           "State",
           Zip_Code
       )
SELECT Street,
       City,
       "State",
       Zip_Code
  FROM Sales.Customers
 ORDER BY First_Name,
          Last_Name;

GO
