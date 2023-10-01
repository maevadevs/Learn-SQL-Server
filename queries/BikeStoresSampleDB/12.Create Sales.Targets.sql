USE BikeStores;

GO

/**
 * Create or Restore BikeStores Database
 * - Load data for Sales.Targets
 *
 * This is used in 11-modifying-data/04-update-join
 */

--If exist, drop before re-create
DROP TABLE IF EXISTS Sales.Targets;

GO

--Create/Re-create the table
CREATE TABLE Sales.Targets (
              Target_Id INT PRIMARY KEY,
           "Percentage" DECIMAL(4, 2) NOT NULL DEFAULT 0
       );

GO

--Insert values into the table
INSERT INTO Sales.Targets (
              Target_Id,
           "Percentage"
       )
VALUES (1,0.2),
       (2,0.3),
       (3,0.5),
       (4,0.6),
       (5,0.8);

GO
