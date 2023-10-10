# `SELECT INTO`

---

---

- Allows to copy a table
- Creates a new table and inserts rows from the query into it

```sql
SELECT Select_List
  INTO Destination_Table
  FROM Source_Table
[WHERE Optional_Condition];
```

- `Select_List` - List of columns existing in `Source_Table` that will be added to `Destination_Table`
- `Destination_Table` - Table that will be created
- `Source_Table` - Source from which to get the data to copy
- `Optional_Condition` - Condition to limit the data to be copied
- **NOTE: `SELECT INTO` does not copy *constraints* such as primary key and indexes from the source table**

## Copy table within the same database

- Let's create a new schema for the new table

```sql
CREATE SCHEMA Marketing;

GO

SELECT *
  INTO Marketing.Customers
  FROM Sales.Customers;

GO

SELECT *
  FROM Marketing.Customers;

GO
```

## Copy table across databases

```sql
CREATE DATABASE TestDb;

GO

SELECT Customer_Id,
       First_Name,
       Last_Name,
       Email
  INTO TestDb.dbo.Customers_CA
  FROM Sales.Customers
 WHERE "State" = 'CA';

GO

SELECT *
  FROM TestDb.dbo.Customers_CA;

GO
```
