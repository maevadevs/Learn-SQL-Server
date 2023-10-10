# `CREATE SYNONYM`

---

- [Creating a synonym within the same database](#creating-a-synonym-within-the-same-database)
- [Creating a synonym for a table in another database](#creating-a-synonym-for-a-table-in-another-database)
- [Listing all synonyms of a database](#listing-all-synonyms-of-a-database)
- [Listing synonyms using SQL Server Management Studio](#listing-synonyms-using-sql-server-management-studio)
- [When to use Synonyms](#when-to-use-synonyms)
- [Benefits of Synonyms](#benefits-of-synonyms)

---

- Synonym is an alias or alternative name for a database object
- Provides many benefits when used properly

```sql
CREATE SYNONYM [Schema_Name.]Synonym_Name
   FOR [Server_Name.[Database_Name].[Schema_Name].]Object_Name
;
```

- **NOTE: The object for which we create the synonym does not have to exist at the time the synonym is created**
- Once created, the synonym can be used anywhere where we would use the target object
  - Synonyms are stored in the `Synonyms` folder
- Let's look at an example

## Creating a synonym within the same database

```sql
CREATE SYNONYM SalesOrders FOR Sales.Orders;

GO

SELECT *
  FROM SalesOrders;

GO
```

## Creating a synonym for a table in another database

```sql
CREATE DATABASE Test;

GO

USE Test;

GO

CREATE SCHEMA Purchasing;

GO

CREATE TABLE Purchasing.Suppliers (
             Supplier_Id INT PRIMARY KEY IDENTITY,
           Supplier_Name NVARCHAR(100) NOT NULL
       );

GO
```

- Now we can create a synonym for `Purchasing.Suppliers` in `BikeStores`

```sql
USE BikeStores;

GO

CREATE SYNONYM TestSuppliers
FOR Test.Purchasing.Suppliers;

GO
```

- We can use this synonym to refer to the table in a different database

```sql
Use BikeStores;

GO

SELECT *
  FROM TestSuppliers;

GO
```

## Listing all synonyms of a database

- We can query the `Sys.Synonyms` catalog view

```sql
SELECT "Name",
       Base_Object_Name,
       "Type"
  FROM Sys.Synonyms
 ORDER BY "Name";
```

## Listing synonyms using SQL Server Management Studio

- Synonyms are stored in the `Synonyms` folder of the database

## When to use Synonyms

- Simplify object names
- Using an object from another database (even from a remote server)
- Enable seamless object name changes
  - When renaming an object, the existing database objects that reference to this object need to be manually modified to reflect the new name
  - All current applications that use this table need to be changed and possibly to be recompiled
  - To avoid all of these hard work, we can rename the object and create a synonym for it to keep existing applications function properly

## Benefits of Synonyms

- Provide a layer of abstraction over the base objects
- Shorten the lengthy name with a simplified alias
- Allow backward compatibility for the existing applications when renaming database objects
