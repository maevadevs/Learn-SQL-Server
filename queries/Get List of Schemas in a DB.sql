/**
 * Get a list of all the schemas existing in the whole DB
 */
-- Replace this with the database you want to use
USE [<Your Database Name Here>];

SELECT SCH.Name      AS Schema_Name,
       SCH.Schema_Id,
       USR.Name      AS Schema_Owner
  FROM Sys.Schemas AS SCH
 INNER JOIN Sys.SysUsers AS USR
         ON USR.Uid = SCH.Principal_Id
 ORDER BY SCH.Name;

GO
