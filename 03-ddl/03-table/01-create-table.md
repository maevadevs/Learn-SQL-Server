# `CREATE TABLE`

Allows to create a new table

- Tables are used to store data in the database
- Tables are uniquely named within a database and schema
- Each table contains one or more columns
- Each column has an associated data type
- A Data Type defines the kind of data a column can store
- A column may have one or more column constraints such as `NOT NULL` and `UNIQUE`

```sql
CREATE TABLE [Database_Name.][Schema_Name.]Table_Name 
(
     PK_Column   data_type    PRIMARY KEY
    ,Column_1    data_type    NOT NULL
    ,Column_2    data_type
    ,...
    ,table_constraints
);
```

- `Database_Name` - Must be the name of an existing database
  - If skipped, defaults to the current default database
- `PK_Column` - Each table must have a primary key which consists of one or more columns
  - List the primary key columns first and then other columns
  - If only one single key, use `PRIMARY KEY` keywords on the column
  - If composite keys, specify the `PRIMARY KEY` constraint as a `table_constraints`
- `table_constraints` - A table may have some constraints specified in the *table constraints* section such as:
  - `FOREIGN KEY`
  - `PRIMARY KEY` for Composite keys
  - `UNIQUE`
  - `CHECK`

## Example of `CREATE TABLE`

```sql
CREATE TABLE     Sales.Visits 
(
     Visit_Id    INT            PRIMARY KEY 
                                IDENTITY (1, 1)
    ,First_Name  VARCHAR(50)    NOT NULL
    ,Last_Name   VARCHAR(50)    NOT NULL
    ,Visited_At  DATETIME
    ,Phone       VARCHAR(20)
    ,Store_Id    INT            NOT NULL
    --Table Constraints
    ,FOREIGN KEY (Store_Id) 
                 REFERENCES      Sales.Stores (Store_Id)
);
```

- Default Current Database: `BikeStoresSampleDB`
- Schema: `Sales`
- Table: `Visits`
- `IDENTITY (1,1)` - SQL Server will automatically generate integer numbers for the column 
  - Starting from `1`
  - Increasing by `1` for each new row

## Example `CREATE TABLE` With Composite Key

```sql
--Schema not defined: Default to dbo
CREATE TABLE    Persons 
(
    --Columns
     ID         INT             NOT NULL
    ,Last_Name  VARCHAR(255)    NOT NULL
    ,First_Name VARCHAR(255)
    ,Age        INT
    --Table Constraints: We want to use (ID, Last_Name) as Composite Primary Key
    ,CONSTRAINT PK_Person 
                PRIMARY KEY (ID, Last_Name)
);
```

`PK_Person` will not show up as a column in the table

- It is only a constraint on the table
- It will show up under `Keys` though