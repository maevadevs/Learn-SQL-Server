SELECT 
	schema_name(tab.schema_id) AS schema_name,
    tab.name AS table_name, 
    col.column_id,
    col.name AS column_name, 
    t.name AS data_type,    
    col.max_length,
    col.precision
FROM sys.tables AS tab 
	INNER JOIN sys.columns AS col ON tab.object_id = col.object_id
    LEFT JOIN sys.types AS t ON col.user_type_id = t.user_type_id
WHERE tab.name = 'Your Table Name Here'
ORDER BY column_name;