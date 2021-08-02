/**
 * Create or Restore BikeStores Database
 * - Create and load data for hr-related Tables
 */

USE BikeStoresSampleDB
GO

-- New Schema for HR
CREATE SCHEMA Hr;
GO

-- Table: Candidates
CREATE TABLE Hr.Candidates(
    Id INT PRIMARY KEY IDENTITY,
    Full_Name VARCHAR(100) NOT NULL
);
GO

-- Table: Employees
CREATE TABLE Hr.Employees(
    Id INT PRIMARY KEY IDENTITY,
    Full_Name VARCHAR(100) NOT NULL
);
GO
