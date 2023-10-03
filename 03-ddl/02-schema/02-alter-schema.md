# `ALTER SCHEMA`

---

- [Example `ALTER SCHEMA`](#example-alter-schema)

---

- Allows to transfer a securable from one schema to another ***within the same database***
- **Securable**
  - A resource to which the *Database Engine Authorization System* controls the access (E.g. A table)

```sql
   ALTER SCHEMA Target_Schema_Name
TRANSFER [ entity_type ::] Securable_Name;
```

- `Target_Schema_Name`
  - Name of a schema in the current database into which we want to move the object
  - It cannot be `SYS` or `INFORMATION_SCHEMA`
- `entity_type`
  - Object, Type, or XML Schema Collection
  - Defaults to `Object`
  - The class of the entity for which the owner is being changed
- `Securable_Name`
  - Name of the securable to move into the `Target_Schema_Name`
- **NOTE on *Stored Procedure*, *Function*, *View*, *Trigger***
  - Moving a *Stored Procedure*, *Function*, *View*, or *Trigger* with `ALTER SCHEMA` **will not** change the schema name of these securables
  - It is recommended to drop and recreate these objects in the new schema instead of using the `ALTER SCHEMA` on them
- **NOTE on altering *Objects***
  - When moving objects (Table, Synonym), SQL Server **will not** update the references for these objects automatically
  - Must manually modify the references to reflect the new schema name
  - E.g. if you move a Table that is referenced in a Stored Procedure, you must modify the Stored Procedure to reflect the new schema name

## Example `ALTER SCHEMA`

- First, let's create a test table `Offices` in `dbo` schema

```sql
CREATE TABLE dbo.Offices (
                Office_Id INT PRIMARY KEY IDENTITY,
              Office_Name NVARCHAR(40) NOT NULL,
           Office_Address NVARCHAR(255) NOT NULL,
                    Phone VARCHAR(20)
       );
```

- And insert some rows into the table

```sql
INSERT INTO dbo.Offices (
           Office_Name,
           Office_Address
       )
VALUES ('Silicon Valley','400 North 1st Street, San Jose, CA 95130'),
       ('Sacramento','1070 River Dr., Sacramento, CA 95820');
```

- Then, create a Stored Procedure that finds offices by `Office_Id`

```sql
CREATE PROCEDURE Usp_Get_Office_By_Id (
           @id INT
       ) AS
       BEGIN
           SELECT *
             FROM dbo.Offices
            WHERE Office_Id = @id;
       END;
```

- Now, let's transfer `Offices` from `dbo` to `Sales` schema

```sql
-- Move dbo.Offices -> Sales schema
   ALTER SCHEMA Sales
TRANSFER OBJECT ::dbo.Offices;
```

- If we execute the `Usp_Get_Office_By_Id` stored procedure now, SQL Server will issue an error

```sql
EXEC dbo.Usp_Get_Office_By_Id @id = 1;
-- Error: Invalid object name 'dbo.Offices'.
```

- We have to manually modify the Stored Procedure to reflect the new schema

```sql
ALTER PROCEDURE Usp_Get_Office_By_Id (
          @id INT
      ) AS
      BEGIN
          SELECT *
            FROM Sales.Offices
            -- Manually modify the Schema from dbo to Sales
           WHERE Office_Id = @id;
      END;
```

- Now, calling the stored procedure will not cause an error

```sql
EXEC dbo.Usp_Get_Office_By_Id @id = 1;
-- No Error
```
