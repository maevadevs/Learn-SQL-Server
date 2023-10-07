# `ALTER TABLE ADD Column`

---

- Although it says `ALTER TABLE`, it really is all about the columns of the table
- Allows to add one ore more columns to a table

```sql
ALTER TABLE Table_Name
      ADD Column_Name data_type column_constraint;
```

- To add multiple columns at once, separate by commas

```sql
ALTER TABLE Table_Name
      ADD Column_Name data_type column_constraint,
          Column_Name data_type column_constraint,
          Column_Name data_type column_constraint;
```

- **SQL Server does not support the syntax for adding a column after an existing column**
- Let's create a table for an example

```sql
CREATE TABLE Sales.Quotations (
           Quotation_No INT IDENTITY PRIMARY KEY,
             Valid_From DATE NOT NULL,
               Valid_To DATE NOT NULL
       );
```

- Now, add a new column `Description` to the table

```sql
ALTER TABLE Sales.Quotations
      ADD "Description" VARCHAR(255) NOT NULL;
```

- Add 2 additional columns `Amount` and `Customer_Name`

```sql
ALTER TABLE Sales.Quotations
      ADD Amount DECIMAL(10, 2) NOT NULL,
          Customer_Name VARCHAR(50) NOT NULL;
```
