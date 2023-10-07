# `ALTER TABLE ALTER Column`

---

- [Modifying The Data Type](#modifying-the-data-type)
- [Change Size of Column](#change-size-of-column)
- [Add a `NOT NULL` Constraint To a Nullable Column](#add-a-not-null-constraint-to-a-nullable-column)

---

- Although it says `ALTER TABLE`, it really is all about the columns of the table
- Allows to modify the column of a table
- The following chaanges can be performed on a column:
  - Modify the data type
  - Change the size
  - Add a `NOT NULL` constraint

## Modifying The Data Type

```sql
ALTER TABLE Table_Name
ALTER COLUMN Column_Name new_data_type(size);
```

- The new data type must be compatible with the old one, else a conversion error is thrown if unable to implicitly convert
- Let's create a table for an example:

```sql
CREATE TABLE T1 (Col1 INT);
```

- And insert some rows to the table

```sql
INSERT INTO T1
VALUES (1),
       (2),
       (3);

GO

SELECT *
  FROM T1;

GO
```

- Modify the data type of the column from `INT` to `VARCHAR`

```sql
ALTER TABLE T1
ALTER COLUMN Col1 VARCHAR(2);
```

- Test with a string data

```sql
INSERT INTO T1
VALUES ('@');
```

- Now, if we test to convert back into `INT`, we will get an error because the `@` value is incompatible

```sql
ALTER TABLE T1
ALTER COLUMN Col1 INT;
-- Error: Conversion failed when converting the varchar value '@' to data type int.
```

## Change Size of Column

- Let's create a new table for testing

```sql
CREATE TABLE T2 (Col VARCHAR(10));
```

- And insert some sample data

```sql
INSERT INTO T2
VALUES ('SQL Server'),
       ('Modify'),
       ('Column');

GO

SELECT *
  FROM T2;

GO
```

- Let's increase the size of the column

```sql
ALTER TABLE T2
ALTER COLUMN Col VARCHAR(50);
```

- **NOTE: When decreasing the size of the column, SQL Server checks the existing data to see if it can convert data based on the new size
  - If unable, SQL Server terminates the statement and issues an error message
  - *It does not allow implicit truncation of data*

```sql
ALTER TABLE T2
ALTER COLUMN Col VARCHAR(5);
-- Error: String or binary data would be truncated in table 'BikeStores.dbo.T2', column 'Col'. Truncated value: ''.
```

## Add a `NOT NULL` Constraint To a Nullable Column

- Let's create a new table with a nullable column

```sql
CREATE TABLE T3 (Col VARCHAR(50));
```

- And add some rows to the table

```sql
INSERT INTO T3
VALUES ('Nullable column'),
       (NULL);

GO

SELECT *
  FROM T3;
```

- To add a `NOT NULL` constraint to a column, we first must update all `NULL` values in that column with a different value

```sql
UPDATE T3
   SET Col = ''
 WHERE Col IS NULL;

 GO

SELECT *
  FROM T3;
```

- Then, we can add the `NULL` constraint

```sql
ALTER TABLE T3
ALTER COLUMN Col VARCHAR(20) NOT NULL;
```

- If we add `NOT NULL` constraint without updating the `NULL` values, we get the following error

```sql
ALTER TABLE T3
ALTER COLUMN Col VARCHAR(20) NOT NULL;
-- Error: Cannot insert the value NULL into column 'Col', table 'BikeStores.dbo.T3'; column does not allow nulls. UPDATE fails.
```
