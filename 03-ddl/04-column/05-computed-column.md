# Computer Column

---

- [Adding Computed Columns to a Table](#adding-computed-columns-to-a-table)
- [Persisted Computed Column](#persisted-computed-column)

---

- Allow to reuse calculation logic in multiple queries
- Let's create a new table for demo

```sql
USE BikeStores;

GO

CREATE TABLE Persons (
            Person_Id INT PRIMARY KEY IDENTITY,
           First_Name NVARCHAR(100) NOT NULL,
            Last_Name NVARCHAR(100) NOT NULL,
                  Dob DATE
       );

GO
```

- And insert rows into the table

```sql
INSERT INTO Persons (
           First_Name,
           Last_Name,
           Dob
       )
VALUES ('John','Doe','1990-05-01'),
       ('Jane','Doe','1995-03-01');

GO
```

- We can now select from the table
- The `Full_Name` column below is a *Computed Column*
  - We could also use `CONCAT()`

```sql
SELECT Person_Id,
       First_Name + ' ' + Last_Name AS Full_Name,
       Dob
  FROM Persons
 ORDER BY Full_Name;
```

## Adding Computed Columns to a Table

- We could re-use this concept in many places
- However, adding the `Full_Name` expression as `First_Name + ' ' + Last_Name` in every query is not convenient
  - We could potentially alter the table and add `Full_Name` calculated directly on the table
  - This column will then be computed on the table directly

```sql
CREATE TABLE Table_Name (
    ...,
    Column_Name AS expression [PERSISTED],
    ...
);

ALTER TABLE Table_Name
  ADD Column_Name AS expression [PERSISTED];
```

- To apply this on the `Persons` table:

```sql
ALTER TABLE Persons
  ADD Full_Name AS (First_Name + ' ' + Last_Name);

GO

SELECT *
  FROM Persons;

GO
```

## Persisted Computed Column

- Computed columns can be persisted
- Physically stores the data of the computed columns on disk
  - Not calculated during a `SELECT` or runtime
  - The resulting data from the calculation is stored in disk
  - Avoids calculation overhead with the cost of extra storage
  - We use the `PERSISTED` keyword

```sql
ALTER TABLE Persons
 DROP COLUMN Full_Name;

GO

ALTER TABLE Persons
  ADD Full_Name AS (First_Name + ' ' + Last_Name) PERSISTED;

GO

SELECT *
  FROM Persons;

GO
```

- **NOTE: Computed column is persisted only if its expression is deterministic**
  - For a set of inputs, the expression must always returns the same result
  - E.g. `GETDATE()` is *not* deterministic

```sql
ALTER TABLE Persons
  ADD Age_In_Years AS (
          CONVERT(INT, CONVERT(CHAR(8), GETDATE(), 112)) - CONVERT(CHAR(8), Dob, 112)
      ) / 10000 PERSISTED;
-- Error: Computed column 'Age_In_Years' in table 'Persons' cannot be persisted because the column is non-deterministic.
```

- Removing the `PERSISTED` keyword will work
- The column will be computed during `SELECT` runtime

```sql
ALTER TABLE Persons
  ADD Age_In_Years AS (
          CONVERT(INT, CONVERT(CHAR(8), GETDATE(), 112)) - CONVERT(CHAR(8), Dob, 112)
      ) / 10000;

GO

SELECT *
  FROM Persons;

GO
```

- **NOTE: We can create an index on a persisted computed column to improve the speed of data retrieval from the computed column**
