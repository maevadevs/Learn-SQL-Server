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
DROP TABLE IF EXISTS Sales.Feedback;
DROP TABLE IF EXISTS Hr.Employees;
DROP TABLE IF EXISTS Hr.Candidates;
DROP TABLE IF EXISTS Sales.Sales_Summary;
DROP TABLE IF EXISTS Sales.Promotions;
DROP TABLE IF EXISTS Sales.Addresses;
DROP TABLE IF EXISTS Sales.Taxes;
DROP TABLE IF EXISTS Sales.Targets;
DROP TABLE IF EXISTS Sales.Commissions;
DROP TABLE IF EXISTS Sales.Category;
DROP TABLE IF EXISTS Sales.Category_Staging;
DROP TABLE IF EXISTS Invoices;
DROP TABLE IF EXISTS Invoice_Items;

-- drop the schemas

DROP SCHEMA IF EXISTS Sales;
DROP SCHEMA IF EXISTS Production;
DROP SCHEMA IF EXISTS Hr;
