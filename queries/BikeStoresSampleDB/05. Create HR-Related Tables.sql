USE BikeStores;

GO

/**
 * Create or Restore BikeStores Database
 * - Create and load data for hr-related Tables
 */

-- CREATE SCHEMAS --
--------------------

CREATE SCHEMA Hr;

GO

-- CREATE TABLES --
-------------------

CREATE TABLE Hr.Candidates (
           Id INT PRIMARY KEY IDENTITY,
    Full_Name VARCHAR(100) NOT NULL
);

GO

CREATE TABLE Hr.Employees (
           Id INT PRIMARY KEY IDENTITY,
    Full_Name VARCHAR(100) NOT NULL
);

GO
