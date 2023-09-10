USE BikeStores;
GO

/**
 * Create or Restore BikeStores Database
 * - Load data for hr-related Tables
 */

-- Values for candidates
INSERT INTO Hr.Candidates(Full_Name)
VALUES
    ('John Doe'),
    ('Lily Bush'),
    ('Peter Drucker'),
    ('Jane Doe');
GO

-- Values for employees
INSERT INTO Hr.Employees(Full_Name)
VALUES
    ('John Doe'),
    ('Jane Doe'),
    ('Michael Scott'),
    ('Jack Sparrow');
GO
