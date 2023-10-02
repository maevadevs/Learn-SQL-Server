# `DELETE`

---

- [`DROP` vs `DELETE` vs `TRUNCATE`](#drop-vs-delete-vs-truncate)
- [Examples of `DELETE`](#examples-of-delete)
  - [Delete A Number of Random Rows](#delete-a-number-of-random-rows)
  - [Delete A Percent of Random Rows](#delete-a-percent-of-random-rows)
  - [Delete Some Rows With Conditions](#delete-some-rows-with-conditions)
  - [Delete All Rows From A Table](#delete-all-rows-from-a-table)

---

- Allows to remove one or more rows from a table

```sql
DELETE [TOP (expression) [PERCENT]]
  FROM Schema_Name.Table_Name
[WHERE search_condition];
```

- **NOTE: The `WHERE` clause is optional. But if you skip it, all data in the table will be removed**

```sql
--Remove all data from the table
DELETE FROM Schema_Name.Table_Name;
```

- The following removes 10 random rows from the `Target_Table`

```sql
DELETE TOP 10
  FROM Target_Table;
```

- Because the table stores its rows in unspecified order, we do not know which rows will be deleted
- But we know for sure that the number of rows that will be deleted is 10
- The following removes 10% random rows from the `Target_Table`

```sql
DELETE TOP 10 PERCENT
  FROM Target_Table;
```

- Practically speaking, we will rarely remove all rows from a table but only one or several rows
  - We need to specify the `search_condition` in the `WHERE` clause to limit the number of rows that are deleted
  - The rows that cause the `search_condition` evaluates to `True` will be deleted

## `DROP` vs `DELETE` vs `TRUNCATE`

- **There is a difference between using `DROP TABLE`, `DELETE` without `WHERE`, and `TRUNCATE TABLE`**
  - `DROP TABLE` will delete the whole table structure and its properties along with its data
  - `DELETE` without `WHERE` will delete all the data but will keep the table structure and its properties in place (empty table)
- `DROP TABLE` is faster than `DELETE` without `WHERE`
  - `DROP TABLE` happens at the table-level
  - `DELETE` happens at the record-level and will apply like a foreach-loop for each entry in the table
- `TRUNCATE TABLE` is similar to `DELETE` without `WHERE` but is faster
  - `TRUNCATE TABLE` removes the data by deallocating the data pages used to store the table data and records only the page deallocations in the transaction log: One single transaction

## Examples of `DELETE`

- Let's create a new table for demonstration

```sql
--A data-copy of Production.Products
SELECT *
  INTO Production.Product_History
  FROM Production.Products;
```

### Delete A Number of Random Rows

- Delete 21 random rows from the table

```sql
DELETE TOP (21)
  FROM Production.Product_History;
```

### Delete A Percent of Random Rows

- Delete 5% of random rows from the table

```sql
DELETE TOP (5) PERCENT
  FROM Production.Product_History;
```

### Delete Some Rows With Conditions

- Delete all products whose model year is 2017

```sql
DELETE
  FROM Production.Product_History
 WHERE Model_Year = 2017;
```

### Delete All Rows From A Table

- This is similar to running `TRUNCATE TABLE` but slower

```sql
DELETE
  FROM Production.Product_History;
```
