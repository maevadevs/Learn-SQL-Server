USE BikeStores;

GO

/**
 * Create or Restore BikeStores Database
 * - Load data for Sales.Category
 *
 * This is used in 11-modifying-data/07-transactions
 */

--Create the Invoices table: Stores the header of the invoice
CREATE TABLE Invoices (
                    Id INT IDENTITY PRIMARY KEY,
           Customer_Id INT NOT NULL,
                 Total DECIMAL(10, 2) NOT NULL DEFAULT 0 CHECK (total >= 0)
       );

GO

--Create the Invoice_Items table: Stores the line items
CREATE TABLE Invoice_Items (
                   Id INT,
           Invoice_Id INT NOT NULL,
            Item_Name VARCHAR(100) NOT NULL,
               Amount DECIMAL(10, 2) NOT NULL CHECK (Amount >= 0),
                  Tax DECIMAL(4, 2) NOT NULL CHECK (Tax >= 0),
              PRIMARY KEY (Id, Invoice_Id),
              FOREIGN KEY (Invoice_Id) REFERENCES Invoices (Id)
                      ON UPDATE CASCADE
                      ON DELETE CASCADE
       );

GO
