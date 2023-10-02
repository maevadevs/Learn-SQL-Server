/**
 * Get a list of fields in each table in a DB
 */

-- Replace this with the database you want to use
USE [<Your Database Name Here>];

DECLARE @tableType NVARCHAR(100);

-- Set the type of the tables you want to list the fields for
SET @tableType = 'BASE TABLE'; -- Check if this criteria applies to what you want

SELECT COL.table_catalog        AS DB_Name,
       COL.table_schema         AS Schema_Name,
       COL.table_name           AS Table_Name,
       COL.column_name          AS Field_Name,
       Data_Type,
       Is_Nullable,
       Column_Default           AS Default_Value,
       Character_Maximum_Length AS Max_Length,
       Numeric_Precision        AS "Precision",
       Character_Set_Name       AS Charset,
       Collation_Name           AS Collation
  FROM Information_Schema.Columns AS COL
 INNER JOIN Information_Schema.Tables AS TAB
         ON COL.Table_Name = TAB.Table_Name
        AND COL.Table_Schema = TAB.Table_Schema
        AND TAB.Table_Type = @tableType -- Check if this criteria applies to what you want
 ORDER BY Schema_Name,
          Table_Name,
          Field_Name;

GO
