# `DROP TABLE`

---

- [What Gets Dropped](#what-gets-dropped)
- [Examples](#examples)
  - [Dropping A Table That Does Not Exist](#dropping-a-table-that-does-not-exist)
  - [Dropping A Single Table](#dropping-a-single-table)
  - [Dropping A Table With A `FOREIGN KEY` Constraint](#dropping-a-table-with-a-foreign-key-constraint)

---

- Allows to remove one or more tables from a database

```sql
DROP TABLE [IF EXISTS] [Database_Name.][Schema_Name.]Table_Name;
```

- `Database_Name`
  - Must be the name of an existing database
  - If skipped, defaults to the currently connected database
- `Schema_Name`
  - Schema to which the new table will belong
  - If skipped, defaults to the current default schema
- `IF EXIST`
  - Conditionally remove the table only if it exists
  - Optional but recommended to avoid errors
  - If skipped and the table does not exist, an error will be thrown
  - Supported since SQL Server 2016 13.x
- We can remove multiple tables at once

```sql
DROP TABLE [IF EXISTS] [Database_Name.][Schema_Name.]Table_Name1,
                       [Database_Name.][Schema_Name.]Table_Name2,
                       ...;
```

## What Gets Dropped

- When dropping a table, the following associated elements also gets dropped
  - All data on the table
  - Associated Triggers
  - Associated Constraints
  - Associated Permissions for the table
- However, the following are NOT dropped
  - Associated Views (must use `DROP VIEW` explicitly)
  - Referencing Stored Procedures (must use `DROP PROCEDURE` explicitly)
  -

## Examples

### Dropping A Table That Does Not Exist

- When we drop a table that does not exist, SQL Server throws an error

```sql
DROP TABLE Sales.Revenues;
-- Error: Cannot drop the table 'Sales.Revenues', because it does not exist or you do not have permission.
```

- We should always use `IF EXISTS` to avoid this error
  - If the table exist, it gets dropped
  - If it does not exist, skip

```sql
DROP TABLE IF EXISTS Sales.Revenues;
```

### Dropping A Single Table

- Let's create a new table for testing

```sql
CREATE TABLE Sales.Delivery (
             Delivery_Id INT PRIMARY KEY,
           Delivery_Note VARCHAR(255) NOT NULL,
           Delivery_Date DATE NOT NULL
       );
```

- We can drop the table as follow (since we know the table exist, we can skip `IF EXISTS`)

```sql
DROP TABLE Sales.Delivery;
```

### Dropping A Table With A `FOREIGN KEY` Constraint

```sql
CREATE SCHEMA Procurement;

GO

CREATE TABLE Procurement.Supplier_Groups (
             Group_Id INT IDENTITY PRIMARY KEY,
           Group_Name VARCHAR (50) NOT NULL
       );

CREATE TABLE Procurement.Suppliers (
             Supplier_Id INT IDENTITY PRIMARY KEY,
           Supplier_Name VARCHAR (50) NOT NULL,
                Group_Id INT NOT NULL,
                 FOREIGN KEY (Group_Id) REFERENCES Procurement.Supplier_Groups (Group_Id)
       );

GO
```

- If we try to drop the `Supplier_Groups` table, we get an error because it has a `FOREIGN KEY` constraint

```sql
DROP TABLE Procurement.Supplier_Groups;
-- Error: Could not drop object 'Procurement.Supplier_Groups' because it is referenced by a FOREIGN KEY constraint.
```

- **SQL Server does not allow to drop a table that is referenced by a foreign constraint**
  - To drop the table, we must drop the referencing foreign key constraint or referencing table first
  - We can remove the constraint by dropping the foreign key constraint or the referencing table
- **They must be listed in the correct order**

```sql
DROP TABLE Procurement.Suppliers;
DROP TABLE Procurement.Supplier_Groups;
```

- We can also use a single `DROP` statement to drop multiple tables

```sql
DROP TABLE Procurement.Suppliers,
           Procurement.Supplier_Groups;
```
