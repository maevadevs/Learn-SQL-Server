# `ALTER TABLE DROP Column`

---

- [Examples](#examples)

---

- Although it says `ALTER TABLE`, it really is all about the columns of the table
- Allows to remove one or more columns from an existing table

```sql
ALTER TABLE Table_Name
 DROP COLUMN Column_Name;
```

- **NOTE**
  - **If the column to delete has a `CHECK` constraint, the constraint must be deleted first before removing the column**
  - **SQL Server does not allow to delete a column that has a `PRIMARY KEY` or a `FOREIGN KEY` constraint**
- To delete multiple columns, use the following syntax

```sql
ALTER TABLE Table_Name
 DROP COLUMN Column_Name_1,
             Column_Name_2,
             ...;
```

## Examples

- Let's create `Sales.Price_Lists` for the demonstration

```sql
CREATE TABLE Sales.Price_Lists (
           Product_Id INT,
           Valid_From DATE,
                Price DECIMAL(10,2) NOT NULL CONSTRAINT ck_positive_price CHECK (price >= 0),
             Discount DECIMAL(10,2) NOT NULL,
            Surcharge DECIMAL(10,2) NOT NULL,
                 Note VARCHAR(255),
              PRIMARY KEY (Product_Id, Valid_From)
       );
```

- Now drop the `Note` column from the table

```sql
ALTER TABLE Sales.Price_Lists
 DROP COLUMN Note;
```

- If we try to drop the `Price` column, we get an error because if has a `CHECK` constraint

```sql
ALTER TABLE Sales.Price_Lists
 DROP COLUMN Price;
-- Error: The object 'ck_positive_price' is dependent on column 'Price'.
```

- To drop the column, we have to delete the constraint first

```sql
ALTER TABLE Sales.Price_Lists
 DROP CONSTRAINT ck_positive_price;

GO

ALTER TABLE Sales.Price_Lists
 DROP COLUMN Price;
```

- We can also delete multiple columns at once

```sql
ALTER TABLE Sales.Price_Lists
 DROP COLUMN Discount,
             Surcharge;
```
