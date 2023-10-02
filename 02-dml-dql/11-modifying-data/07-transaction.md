# Transactions

---

- [Examples of Transactions](#examples-of-transactions)

---

- A *Transaction* is a single unit of work that typically contains multiple T-SQL statements
  - If a transaction is successful, the changes are committed to the database
  - If a transaction has an error, the changes have to be rolled back
- Single statement such as `INSERT`, `UPDATE`, and `DELETE` uses an autocommit transaction
  - Each statement is a transaction
- We can also start a transaction *explicitly*
  - We use the `BEGIN TRANSACTION` or `BEGIN TRAN` keywords
  - We execute one or more statements including `INSERT`, `UPDATE`, and `DELETE`
  - Commit the transaction using the `COMMIT` statement
  - Roll back the transaction using the `ROLLBACK` statement
- **Transaction ensures that a group of query all complete successfully together before saying that the query is a success**
  - **If it fails midway, we rollback any applied changes**

```sql
-- Start a transaction
BEGIN TRANSACTION;
-- Other statements here
-- Commit the transaction
COMMIT;
```

## Examples of Transactions

- Let's create some tables for demonstration

```sql
-- Stores the header of the invoice
CREATE TABLE Invoices (
                    Id INT IDENTITY PRIMARY KEY,
           Customer_Id INT NOT NULL,
                 Total DECIMAL(10, 2) NOT NULL DEFAULT 0 CHECK (total >= 0)
       );

-- Stores the line items
CREATE TABLE Invoice_Items (
                   Id INT,
           Invoice_Id INT NOT NULL,
            Item_Name VARCHAR(100) NOT NULL,
               Amount DECIMAL(10, 2) NOT NULL CHECK (Amount >= 0),
                  Tax DECIMAL(4, 2) NOT NULL CHECK (Tax >= 0),
              PRIMARY KEY (Id, Invoice_Id),
              FOREIGN KEY (Invoice_Id) REFERENCES Invoices (Id)
                      ON UPDATE CASCADE
                      ON DELETE CASCADE
       );
```

- Now we can create transactions on those tables to manipulate their data

```sql
BEGIN TRANSACTION;

-- 1. Insert a row into the Invoices table and return the Invoice_Id

DECLARE @invoice TABLE (
            Id int
        );
DECLARE @invoice_id int;

INSERT INTO Invoices (
           Customer_Id,
           Total
       )
OUTPUT INSERTED.Id INTO @invoice
VALUES (100, 0);

SELECT @invoice_id = Id
  FROM @invoice;

-- 2. Insert two rows into the Invoice_Items table

INSERT INTO Invoice_Items (
           Id,
           Invoice_Id,
           Item_Name,
           Amount,
           Tax
       )
VALUES (10, @invoice_id, 'Keyboard', 70, 0.08),
       (20, @invoice_id, 'Mouse', 50, 0.08);

-- 3. Calculate the total using the Invoice_Items table and update it to the Invoices table

UPDATE Invoices
   SET total = (
           SELECT SUM(Amount * (1 + Tax))
             FROM Invoice_Items
            WHERE Invoice_Id = @invoice_id
       );

COMMIT;
```
