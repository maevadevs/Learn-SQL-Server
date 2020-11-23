USE [DB_Name]; -- Replace this with the database you want to use

SELECT DB_Name = c.table_catalog,
       Schema_Name = c.table_schema,
       Table_Name = c.table_name,
       Field_Name = c.column_name,
       Data_Type = data_type,
       Is_Nullable = is_nullable,
       Default_Value = column_default,
       Max_Length = character_maximum_length,
       Precision = numeric_precision,
       Char_Set = character_set_name,
       Collation = collation_name
FROM information_schema.columns c INNER JOIN information_schema.tables t
ON c.table_name = t.table_name
   AND c.table_schema = t.table_schema
   AND t.table_type = 'BASE TABLE' -- Check if this criteria applies to what you want
ORDER BY Schema_Name, Table_Name, Field_Name;
GO
