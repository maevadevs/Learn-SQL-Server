# `INSERT INTO SELECT`

- Allows to add data from other tables into a table
- The statement inserts rows returned by the `query` into the `Target_Table_Name`

```sql
INSERT [ TOP ( expression ) [ PERCENT ] ] 
INTO Schema_Name.Target_Table_Name (Column_List)
select_query ...;
```

- `select_query` - Any valid `SELECT` query that retrieves data from another table
  - Must return values corresponding to the columns specified in `Column_List`
- `TOP` clause is optional
  - Can be used to specify the number of rows returned by `select_query` to be inserted into the target table

## Examples of `INSERT-INTO-SELECT`

Let's create a new table for demonstration

```sql
CREATE TABLE Sales.Addresses 
(
    Address_Id INT IDENTITY PRIMARY KEY,
    Street VARCHAR (255) NOT NULL,
    City VARCHAR (50),
    State VARCHAR (25),
    Zip_Code VARCHAR (5)
);
```

### Insert All Rows From Another Table

```sql
INSERT INTO Sales.Addresses 
(
    Street, 
    City, 
    State, 
    Zip_Code
) 
SELECT
    Street,
    City,
    State,
    Zip_Code
FROM Sales.Customers
ORDER BY 
    First_Name,
    Last_Name;
```

### Insert Some Rows From Another Table

- We can limit the number of rows returned from the query by using conditions

```sql
INSERT INTO Sales.Addresses 
(
    Street, 
    City, 
    State, 
    Zip_Code
) 
SELECT
    Street,
    City,
    State,
    Zip_Code
FROM Sales.Stores
WHERE City IN ('Santa Cruz', 'Baldwin');
```

### Insert the TOP N Rows From A Table

```sql
INSERT TOP (10) 
INTO Sales.Addresses 
(
    Street, 
    City, 
    State, 
    Zip_Code
) 
SELECT
    Street, 
    City, 
    State, 
    Zip_Code
FROM Sales.Customers
ORDER BY 
    First_Name,
    Last_Name;
```

### Insert the TOP Percent Rows From A Table

```sql
INSERT TOP (10) PERCENT
INTO Sales.Addresses 
(
    Street, 
    City, 
    State, 
    Zip_Code
) 
SELECT
    Street, 
    City, 
    State, 
    Zip_Code
FROM Sales.Customers
ORDER BY 
    First_Name,
    Last_Name;
```

**Note: To delete all entries in a tables, we can use the following:**

```sql
TRUNCATE TABLE Schema_Name.Table_Name;
```