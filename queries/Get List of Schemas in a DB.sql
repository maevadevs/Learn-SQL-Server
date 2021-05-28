/**
 * Get a list of all the schemas existing in the whole DB
 */

SELECT 
	schemas.name AS schema_name, 
    schemas.schema_id,
    users.name AS schema_owner
FROM sys.schemas AS schemas 
INNER JOIN sys.sysusers AS users
    ON users.uid = schemas.principal_id
ORDER BY schemas.name;
