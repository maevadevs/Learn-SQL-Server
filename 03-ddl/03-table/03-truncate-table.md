# `TRUNCATE TABLE`

---

- [`TRUNCATE TABLE` vs `DELETE`](#truncate-table-vs-delete)
  - [`TRUNCATE` uses less transaction log](#truncate-uses-less-transaction-log)
  - [`TRUNCATE` uses less locks](#truncate-uses-less-locks)
  - [`TRUNCATE` resets Identity Column](#truncate-resets-identity-column)

---

- Allows to remove all rows from a table faster and more efficiently
- Faster than deleting rows from the table
- Let's try with an example

```sql
CREATE TABLE Sales.Customer_Groups (
             Group_Id INT PRIMARY KEY IDENTITY,
           Group_Name VARCHAR (50) NOT NULL
       );

GO

INSERT INTO Sales.Customer_Groups (Group_Name)
VALUES ('Intercompany'),
       ('Third Party'),
       ('One time');

GO
```

- To delete all rows from the table, we could use `DELETE`

```sql
DELETE
  FROM Sales.Customer_Groups;
```

- When we want to delete all data from a table, `TRUNCATE` is preferred over `DELETE`
  - The end result is the same
  - However, `TRUNCATE` executes faster
  - Uses a fewer system and transaction log resources

```sql
TRUNCATE TABLE [Database_Name.][Schema_Name.]Table_Name;
```

- `Database_Name`
  - Must be the name of an existing database
  - If skipped, defaults to the currently connected database
- `Schema_Name`
  - Schema to which the new table will belong
  - If skipped, defaults to the current default schema

```sql
TRUNCATE TABLE Sales.Customer_Groups;
```

## `TRUNCATE TABLE` vs `DELETE`

### `TRUNCATE` uses less transaction log

- `DELETE` removes rows one at a time
- `DELETE` inserts an entry in the transaction log for each removed row
- `TRUNCATE TABLE` deletes data by deallocating the data pages used to store the table data
- `TRUNCATE TABLE` only inserts the page deallocations in the transaction logs

### `TRUNCATE` uses less locks

- `DELETE` locks each row for removal
- `TRUNCATE TABLE` locks the table and pages

### `TRUNCATE` resets Identity Column

- `DELETE` does not reset identity columns when deleting rows
- When using `TRUNCATE TABLE`, if the table to be truncated has an identity column, the counter for that column is reset to the seed value
