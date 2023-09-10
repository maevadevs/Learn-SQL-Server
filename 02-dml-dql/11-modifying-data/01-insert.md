# `INSERT`

- Allows to add a new row into a table

```sql
INSERT INTO Schema_Name.Table_Name (Column_List)
VALUES (Value_List);
```

- The `Column_List` must be enclosed in parenthesis, separated by commas
- The `Value_List` must be enclosed in parenthesis, separated by commas
- If a column of a table does not appear in `Column_List`, SQL Server must be able to provide a value for insertion or the row cannot be inserted. The following are the values used:

Column | Value
--|--
With `IDENTITY` Property | Next incremental value
With Default | Default value
With Timestamp type | Current timestamp
Nullable | `NULL`
Computed column | Calculated value

## Examples of `INSERT`

Let's create a new table for demonstration

```sql
CREATE TABLE Sales.Promotions 
(
    Promotion_Id INT PRIMARY KEY IDENTITY (1, 1),
    Promotion_Name VARCHAR (255) NOT NULL,
    Discount NUMERIC (3, 2) DEFAULT 0,
    Start_Date DATE NOT NULL,
    Expired_Date DATE NOT NULL
);
```

`Promotion_Id` is an identity column 

- Its value is automatically populated by the SQL Server when you add a new row to the table

### Example of Basic `INSERT`

Insert a new row into the `Promotions` table

```sql
INSERT INTO Sales.Promotions 
(
    Promotion_Name,
    Discount,
    Start_Date,
    Expired_Date
)
VALUES 
(
    '2018 Summer Promotion',
    0.15,
    '20180601',
    '20180901'
);
```

We did not specify a value for the `Promotion_Id` because SQL Server provides the value for this column automatically

- If the `INSERT` statement executes successfully, we get the number of rows inserted

### Example of `INSERT` with `OUTPUT`

`OUTPUT` allows to capture the inserted values and return it right away in the Results of SSMS

```sql
INSERT INTO Sales.Promotions 
(
    Promotion_Name,
    Discount,
    Start_Date,
    Expired_Date
) 
OUTPUT Inserted.Promotion_Id
VALUES 
(
    '2018 Fall Promotion',
    0.15,
    '20181001',
    '20181101'
);
```

We can also specify multiple columns that we want to show

```sql
INSERT INTO Sales.Promotions 
(
    Promotion_Name,
    Discount,
    Start_Date,
    Expired_Date
) 
OUTPUT 
    Inserted.Promotion_Id,
    Inserted.Promotion_Name,
    Inserted.Discount,
    Inserted.Start_Date,
    Inserted.Expired_Date
VALUES 
(
    '2018 Winter Promotion',
    0.2,
    '20181201',
    '20190101'
);
```

### Example of `INSERT` with Explicit Identity

- Typically, we leave SQL Server to handle the Identity column (Primary Key)
  - However, in some situations, we want to manage this column explicitly ourselves
  - To insert explicitly into this column, we have to first switch `IDENTITY_INSERT` to `ON`
  - Without doing this, SQL Server will throw an error when trying to insert into the Identity column

```sql
SET IDENTITY_INSERT Schema_Name.Table_Name ON;
```

We can also turn it off

```sql
SET IDENTITY_INSERT Schema_Name.Table_Name OFF;
```

So we can execute the following snippet

```sql
-- Turn on explicit identity insert
SET IDENTITY_INSERT Sales.Promotions ON;

INSERT INTO Sales.Promotions 
(
    Promotion_Id,
    Promotion_Name,
    Discount,
    Start_Date,
    Expired_Date
)
VALUES 
(
    4,
    '2019 Spring Promotion',
    0.25,
    '20190201',
    '20190301'
);

-- Turn off explicit identity insert
SET IDENTITY_INSERT Sales.Promotions OFF;
```

## Inserting Multiple Rows

- Previously, we looked at inserting one row at a time
- To insert multiple rows at once, we use multiple comma-separated lists of values

```sql
INSERT INTO Schema_Name.Table_Name (Column_List)
VALUES
    (Value_List_1),
    (Value_List_2),
    ...
    (Value_List_n);
```

- **This is only supported on SQL Server 2008 and later**
- But there is a limit of 1000 rows at a time
  - To insert more rows, use multiple `INSERT`
  - Or we can also use `BULK INSERT` or a derived table
- To insert multiple rows from a `SELECT`, we can use `INSERT INTO SELECT`

### Inserting Multiple Rows Example

```sql
INSERT INTO Sales.Promotions 
(
    Promotion_Name,
    Discount,
    Start_Date,
    Expired_Date
)
VALUES
    ('2019 Summer Promotion',0.15,'20190601','20190901'),
    ('2019 Fall Promotion',0.20,'20191001','20191101'),
    ('2019 Winter Promotion',0.25,'20191201','20200101');
```

Similar to previous, we can also use `OUTPUT` to return the inserted value

```sql
INSERT INTO Sales.Promotions 
( 
    Promotion_Name, 
    Discount, 
    Start_Date, 
    Expired_Date
)
OUTPUT Inserted.Promotion_Id
VALUES
	('2020 Summer Promotion',0.25,'20200601','20200901'),
	('2020 Fall Promotion',0.10,'20201001','20201101'),
	('2020 Winter Promotion', 0.25,'20201201','20210101');
```

- We can also specify multiple columns that we want to show

```sql
INSERT INTO Sales.Promotions 
(
    Promotion_Name,
    Discount,
    Start_Date,
    Expired_Date
) 
OUTPUT 
    Inserted.Promotion_Id,
    Inserted.Promotion_Name,
    Inserted.Discount,
    Inserted.Start_Date,
    Inserted.Expired_Date
VALUES
	('2020 Summer Promotion',0.25,'20200601','20200901'),
	('2020 Fall Promotion',0.10,'20201001','20201101'),
	('2020 Winter Promotion', 0.25,'20201201','20210101');
```

**Note: To delete all entries in a tables, we can use the following:**

```sql
TRUNCATE TABLE Schema_Name.Table_Name;
```