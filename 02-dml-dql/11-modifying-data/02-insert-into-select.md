# `INSERT INTO SELECT`

---

- [Examples of `INSERT-INTO-SELECT`](#examples-of-insert-into-select)
  - [Insert All Rows From Another Table](#insert-all-rows-from-another-table)
  - [Insert Some Rows From Another Table](#insert-some-rows-from-another-table)
  - [Insert the TOP N Rows From A Table](#insert-the-top-n-rows-from-a-table)
  - [Insert the TOP Percent Rows From A Table](#insert-the-top-percent-rows-from-a-table)

---

- Allows to add data from other tables into a table
- The statement inserts rows returned by the `Select_Query` into the `Target_Table_Name`

```sql
INSERT [ TOP ( expression ) [ PERCENT ] ]
  INTO Schema_Name.Target_Table_Name (Column_List)
SELECT Select_Query ...;
```

- `Select_Query`
  - Any valid `SELECT` query that retrieves data from another table
  - Must return values corresponding to the columns specified in `Column_List`
- `TOP` clause is optional
  - Can be used to specify the number of rows returned by `Select_Query` to be inserted into the target table
  - Would be similar if we had the same `TOP` clause in the `Select_Query`

## Examples of `INSERT-INTO-SELECT`

- Let's create a new table for demonstration

```sql
CREATE TABLE Sales.Addresses (
           Address_Id INT IDENTITY PRIMARY KEY,
               Street VARCHAR (255) NOT NULL,
                 City VARCHAR (50),
              "State" VARCHAR (25),
             Zip_Code VARCHAR (5)
       );
```

### Insert All Rows From Another Table

```sql
INSERT INTO Sales.Addresses (
           Street,
           City,
           "State",
           Zip_Code
       )
SELECT Street,
       City,
       "State",
       Zip_Code
  FROM Sales.Customers
 ORDER BY First_Name,
          Last_Name;
```

### Insert Some Rows From Another Table

- We can limit the number of rows returned from the query by using conditions
- Would be similar if we had the same `TOP` clause in the `Select_Query`

```sql
INSERT INTO Sales.Addresses (
           Street,
           City,
           "State",
           Zip_Code
       )
SELECT Street,
       City,
       "State",
       Zip_Code
  FROM Sales.Stores
 WHERE City IN (
           'Santa Cruz',
           'Baldwin'
       );
```

### Insert the TOP N Rows From A Table

- We can limit the number of rows returned from the query by using conditions
- Would be similar if we had the same `TOP` clause in the `Select_Query`

```sql
INSERT TOP (10)
  INTO Sales.Addresses (
           Street,
           City,
           "State",
           Zip_Code
       )
SELECT Street,
       City,
       "State",
       Zip_Code
  FROM Sales.Customers
 ORDER BY First_Name,
          Last_Name;
```

### Insert the TOP Percent Rows From A Table

- We can limit the number of rows returned from the query by using conditions
- Would be similar if we had the same `TOP` clause in the `Select_Query`

```sql
INSERT TOP (10) PERCENT
  INTO Sales.Addresses (
           Street,
           City,
           "State",
           Zip_Code
       )
SELECT Street,
       City,
       "State",
       Zip_Code
  FROM Sales.Customers
 ORDER BY First_Name,
          Last_Name;
```

- **Note: To delete all entries in a tables, we can use the following:**

```sql
TRUNCATE TABLE Schema_Name.Table_Name;
```
