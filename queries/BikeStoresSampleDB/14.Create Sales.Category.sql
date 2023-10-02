USE BikeStores;

GO

/**
 * Create or Restore BikeStores Database
 * - Load data for Sales.Category
 *
 * This is used in 11-modifying-data/06-merge
 */

--Create the Category table
CREATE TABLE Sales.Category (
             Category_Id INT PRIMARY KEY,
           Category_Name VARCHAR(255) NOT NULL,
                  Amount DECIMAL(10 , 2 )
       );

GO

--Insert values into Category
INSERT INTO Sales.Category (
           Category_Id,
           Category_Name,
           Amount
       )
VALUES (1,'Children Bicycles',15000),
       (2,'Comfort Bicycles',25000),
       (3,'Cruisers Bicycles',13000),
       (4,'Cyclocross Bicycles',10000);

GO

CREATE TABLE Sales.Category_Staging (
             Category_Id INT PRIMARY KEY,
           Category_Name VARCHAR(255) NOT NULL,
                  Amount DECIMAL(10 , 2 )
       );

GO

INSERT INTO Sales.Category_Staging(
           Category_Id,
           Category_Name,
           Amount
       )
VALUES (1,'Children Bicycles',15000),
       (3,'Cruisers Bicycles',13000),
       (4,'Cyclocross Bicycles',20000),
       (5,'Electric Bikes',10000),
       (6,'Mountain Bikes',10000);

GO
