USE BikeStores;

GO

/**
 * Create or Restore BikeStores Database
 * - Load data for Sales.Commissions
 *
 * This is used in 11-modifying-data/04-update-join
 */

--Create the Commissions table
CREATE TABLE Sales.Commissions (
              Staff_Id INT PRIMARY KEY,
             Target_Id INT,
           Base_Amount DECIMAL(10, 2) NOT NULL DEFAULT 0,
            Commission DECIMAL(10, 2) NOT NULL DEFAULT 0,
               FOREIGN KEY (Target_Id) REFERENCES Sales.Targets (Target_Id),
               FOREIGN KEY (Staff_Id) REFERENCES Sales.Staffs (Staff_Id)
       );

GO

--Insert values into Commissions
INSERT INTO Sales.Commissions (
           Staff_Id,
           Base_Amount,
           Target_Id
       )
VALUES (1,100000,2),
       (2,120000,1),
       (3,80000,3),
       (4,900000,4),
       (5,950000,5);

GO
