/**
 * Create or Restore BikeStores Database
 * - Create and load data for hr-related Tables
 */

USE BikeStoresSampleDB
GO

-- New Schema for HR
CREATE SCHEMA hr;
GO

-- Table: candidates
CREATE TABLE hr.candidates(
    id INT PRIMARY KEY IDENTITY,
    fullname VARCHAR(100) NOT NULL
);
GO

-- Table: employees
CREATE TABLE hr.employees(
    id INT PRIMARY KEY IDENTITY,
    fullname VARCHAR(100) NOT NULL
);
GO
