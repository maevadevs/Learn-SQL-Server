USE BikeStores;

GO

/**
 * Create or Restore BikeStores Database
 * - Load data for Sales.Quotations
 *
 * This is used in 03-ddl/03-table/02-alter-table
 */

--Create the Quotations table
CREATE TABLE Sales.Quotations (
           Quotation_No INT IDENTITY PRIMARY KEY,
             Valid_From DATE NOT NULL,
               Valid_To DATE NOT NULL
       );

GO

ALTER TABLE Sales.Quotations
      ADD "Description" VARCHAR(255) NOT NULL;

GO

ALTER TABLE Sales.Quotations
      ADD Amount DECIMAL(10, 2) NOT NULL,
          Customer_Name VARCHAR(50) NOT NULL;
