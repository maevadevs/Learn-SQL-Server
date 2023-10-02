--List all existing DB Names in the current instance
SELECT "Name"
  FROM master.sys.databases
 ORDER BY "Name";

GO

--List all existing DBs in the current instance
EXEC sp_databases;

GO
