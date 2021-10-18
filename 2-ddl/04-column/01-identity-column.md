# `IDENTITY` Column

The `IDENTITY` property allows to add an *identity* column to a table

- **SQL Server allows only one identity column per table**

```sql
Column_Name TYPE [CONSTRAINTS] IDENTITY [(seed,increment)]
```

- `seed` - The value of the first row loaded into the table
  - Default value: `1`
- `increment` - The incremental value added to the identity value of the previous row
  - Default value: `1`

## Example `IDENTITY` Column

```sql
CREATE TABLE Hr.Person (
    Person_Id INT IDENTITY(1,1) PRIMARY KEY,
    First_Name VARCHAR(50) NOT NULL,
    Last_Name VARCHAR(50) NOT NULL,
    Gender CHAR(1) NOT NULL
);
```

Now, we can test with inserting rows

```sql
INSERT INTO Hr.Person (
  First_Name, 
  Last_Name, 
  Gender
)
OUTPUT Inserted.Person_Id
VALUES('John','Doe','M');
```

- `Inserted.Person_Id` shows `1`

Now, let's add another entry

```sql
INSERT INTO Hr.Person (
  First_Name, 
  Last_Name, 
  Gender
)
OUTPUT Inserted.Person_Id
VALUES('Jane','Doe','F');
```

- `Inserted.Person_Id` is incremented to `2`

## No-Reuse Of Identity Values

SQL Server does not reuse the identity values

- If row insertion fails, that identity value is lost
- If a row is deleted from a table, its identity value will not be reclaimed

These situations can result in gaps in the identity column