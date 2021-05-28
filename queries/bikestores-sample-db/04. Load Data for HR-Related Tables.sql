/**
 * Create or Restore BikeStores Database
 * - Load data for hr-related Tables
 */

USE BikeStoresSampleDB;

-- Values for candidates
INSERT INTO hr.candidates(fullname)
VALUES
    ('John Doe'),
    ('Lily Bush'),
    ('Peter Drucker'),
    ('Jane Doe');
GO

-- Values for employees
INSERT INTO hr.employees(fullname)
VALUES
    ('John Doe'),
    ('Jane Doe'),
    ('Michael Scott'),
    ('Jack Sparrow');
GO
