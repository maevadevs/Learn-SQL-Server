/**
 * Get a list of fields in a specific table in a DB
 */

-- Replace this with the database you want to use
USE [<Your Database Name Here>];

DECLARE @tableName NVARCHAR(100);

-- Set the name of the table you want to list the fields for
SET @tableName = '<Your Table Name Here>';

SELECT Schema_Name(TAB.Schema_Id) AS Schema_Name,
       TAB.Name                   AS Table_Name,
       COL.Column_Id,
       COL.Name                   AS Column_Name,
       TP.Name                    AS Data_Type,
       COL.Max_Length,
       COL.Precision
  FROM SYS.Tables AS TAB
 INNER JOIN SYS.Columns AS COL
         ON TAB.Object_Id = COL.Object_Id
  LEFT JOIN SYS.Types AS TP
         ON COL.User_Type_Id = TP.User_Type_Id
 WHERE TAB.Name = @tableName
 ORDER BY COL.Column_Id;

GO
