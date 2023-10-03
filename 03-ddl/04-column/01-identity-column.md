# `IDENTITY` Column

---

- [Example `IDENTITY` Column](#example-identity-column)
- [No-Reuse Of Identity Values](#no-reuse-of-identity-values)

---

- The `IDENTITY` property allows to add an *identity* column to a table
- **SQL Server allows only one identity column per table**

```sql
Column_Name TYPE [CONSTRAINTS] IDENTITY [(start_value, increment)]
```

- `start_value`
  - The value of the first row loaded into the table
  - Default value: `1`
- `increment`
  - The incremental value added to the identity value of the previous row
  - Default value: `1`

## Example `IDENTITY` Column

```sql
CREATE TABLE Hr.Person (
            Person_Id INT IDENTITY(1, 1) PRIMARY KEY,
           First_Name VARCHAR(50) NOT NULL,
            Last_Name VARCHAR(50) NOT NULL,
               Gender CHAR(1) NOT NULL
       );
```

- Now, we can test with inserting rows

```sql
INSERT INTO Hr.Person (
           First_Name,
            Last_Name,
               Gender
       )
OUTPUT Inserted.Person_Id
VALUES ('John','Doe','M');
```

- `Inserted.Person_Id` shows `1`
- Now, let's add another entry

```sql
INSERT INTO Hr.Person (
           First_Name,
            Last_Name,
               Gender
       )
OUTPUT Inserted.Person_Id
VALUES ('Jane','Doe','F');
```

- `Inserted.Person_Id` is incremented to `2`

## No-Reuse Of Identity Values

- SQL Server does not reuse the identity values
  - If row insertion fails, that identity value is lost
  - If a row is deleted from a table, its identity value will not be reclaimed
  - These situations can result in gaps in the identity column
- For testing this, we create two tables in the `hr` schema: `Position` and `Person_Position`

```sql
CREATE TABLE Hr.Position (
             Position_Id INT IDENTITY (1, 1) PRIMARY KEY,
           Position_name VARCHAR (255) NOT NULL,
       );

CREATE TABLE Hr.Person_Position (
             Person_Id INT,
           Position_Id INT,
               PRIMARY KEY (Person_Id, Position_Id),
           FOREIGN KEY (Person_Id) REFERENCES Hr.Person (Person_Id),
           FOREIGN KEY (Position_Id) REFERENCES hr. Position (Position_Id)
       );
```

- Insert a new person and assign this new person a position by inserting a new row into the `Person_Position` table

```sql
BEGIN TRANSACTION

      BEGIN TRY
            -- Insert a new person
            INSERT INTO Hr.Person (
                       First_Name,
                        Last_Name,
                           Gender
                   )
            VALUES ('Joan','Smith','F');

            -- Assign the person a position
            INSERT INTO Hr.Person_Position (
                         Person_Id,
                       Position_Id
                   )
            VALUES (@@IDENTITY, 1);
        END TRY

      BEGIN CATCH
            IF @@TRANCOUNT > 0
               ROLLBACK TRANSACTION;
        END CATCH

         IF @@TRANCOUNT > 0
            COMMIT TRANSACTION;

GO
```

- The first insert statement was executed successfully
- But the second one failed due to no position with id one in the `Position` table
- Because of the error, the whole transaction was rolled back
- Because the first `INSERT` statement consumed the identity value of three and the transaction was rolled back, the next identity value will be `4`

```sql
INSERT INTO Hr.Person (
           First_Name,
            Last_Name,
               Gender
       )
OUTPUT Inserted.Person_Id
VALUES ('Peter','Drucker','F');
-- Returned Person_Id is 4
```
