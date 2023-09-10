# `DROP SCHEMA`

Allows to remove/delete a schema from a database

```sql
DROP SCHEMA [IF EXISTS] Schema_Name;
```

**NOTES**

- *You must delete all objects in the schema before removing the schema*
  - If the schema contains any objects, the statement will fail
- *Attempting to drop a nonexisting schema will result in an error*
  - Use the `IF EXISTS` option to conditionally remove the schema only if the schema exists

## Example `DROP SCHEMA`

First, let's create a test schema

```sql
CREATE SCHEMA Logistics;
GO
```

And add a test table to the schema as well

```sql
CREATE TABLE          Logistics.Deliveries 
(
     Order_Id         INT         PRIMARY KEY
    ,Delivery_Date    DATE        NOT NULL
    ,Delivery_Status  TINYINT     NOT NULL
);
```

Let's attempt to drop the schema

```sql
DROP SCHEMA IF EXISTS Logistics;
-- Error Message: Cannot drop schema 'Logistics' because it is being referenced by object 'Deliveries'.
```

Let's drop the table to fix this

```sql
DROP TABLE IF EXISTS Logistics.Deliveries;
```

Now, we can finally drop the empty schema

```sql
DROP SCHEMA IF EXISTS Logistics;
```