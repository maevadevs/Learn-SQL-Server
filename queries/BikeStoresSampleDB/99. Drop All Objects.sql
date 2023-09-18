USE BikeStores;

GO

/**
 * Drop all objects in BikeStores Database
 * This can be used to restore the Database from a fresh state
 */

-- drop tables
DROP TABLE IF EXISTS Sales.Order_Items;
DROP TABLE IF EXISTS Sales.Orders;
DROP TABLE IF EXISTS Production.Stocks;
DROP TABLE IF EXISTS Production.Products;
DROP TABLE IF EXISTS Production.Categories;
DROP TABLE IF EXISTS Production.Brands;
DROP TABLE IF EXISTS Sales.Customers;
DROP TABLE IF EXISTS Sales.Staffs;
DROP TABLE IF EXISTS Sales.Stores;
DROP TABLE IF EXISTS Hr.Employees;
DROP TABLE IF EXISTS Hr.Candidates;

-- drop the schemas

DROP SCHEMA IF EXISTS Sales;
DROP SCHEMA IF EXISTS Production;
DROP SCHEMA IF EXISTS Hr;
