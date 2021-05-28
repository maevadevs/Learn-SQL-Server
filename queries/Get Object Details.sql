/**
 * Get Object Details
 */

-- Replace DB_Name with the Database you want to query
USE [DB_Name] 

-- Replace with the Namespace and Object you want to query
EXEC sp_help '[Namespace].[Object_Name]';
GO
