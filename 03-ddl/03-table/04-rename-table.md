# `RENAME TABLE`

---

- [Renaming table with T-SQL](#renaming-table-with-t-sql)
- [Renaming table with SSMS](#renaming-table-with-ssms)

---

## Renaming table with T-SQL

- SQL Server does not have a `RENAME TABLE` keywords
- However, it has a stored procedure for this purpose: `sp_rename`

```sql
EXEC sp_rename 'Old_Table_Name', 'New_Table_Name'
```

- The names of the table must be enclosed in single quotes
- Let's see an example

```sql
CREATE TABLE Sales.Contr (
            Contract_No INT IDENTITY PRIMARY KEY,
             Start_Date DATE NOT NULL,
           Expired_Date DATE,
            Customer_Id INT,
                 Amount DECIMAL(10, 2)
       );

GO

EXEC sp_rename 'Sales.Contr', 'Contracts';

GO
```

- **When running `sp_rename`, we get a caution: `Caution: Changing any part of an object name could break scripts and stored procedures.`**
- However, it still renames the table successfully

## Renaming table with SSMS

- In *Object Explorer*, right-click the table to rename
- Select *Rename* in the menu
- Type the new name of the table
- Press *Enter*
