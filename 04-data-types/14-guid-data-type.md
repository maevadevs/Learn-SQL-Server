# `GUID` Data Type

---

- [Overview](#overview)
- [Using GUID as Primary Key](#using-guid-as-primary-key)
- [Examples](#examples)

---

## Overview

- A Globally Unique IDentifier or GUID is a broader version of ID numbers
  - Guaranteed to be unique across tables, databases, and even servers
- In SQL Server, GUID is 16-byte binary data type
- Use the `NEWID()` function to generate GUID values
  - Generates a unique and different value every time

```sql
SELECT NEWID() AS GUID;
```

- **The `UNIQUEIDENTIFIER` data type holds GUID values**

```sql
DECLARE @id UNIQUEIDENTIFIER;

SET @id = NEWID();

SELECT @id AS GUID;
```

## Using GUID as Primary Key

- Sometimes, it is prefered to use GUID values for the primary key column of a table than using integers
  - Globally unique across tables, databases, and even servers
  - Allows to merge data from different servers with ease
  - Do not expose information so safer to use in public interface
    - E.g. `https://www.example.com/customer/100/` vs `https://www.example.com/customer/F4AB02B7-9D55-483D-9081-CC4E3851E851/`
- There are some disadvantages as well
  - GUID values (16 bytes) takes more storage than `INT` (4 bytes) or even `BIGINT` (8 bytes)
  - Difficult to troubleshoot and debug

## Examples

```sql
CREATE SCHEMA Marketing2;

GO

CREATE TABLE Marketing2.Customers (
           Customer_Id UNIQUEIDENTIFIER DEFAULT NEWID(),
            First_Name NVARCHAR(100) NOT NULL,
             Last_Name NVARCHAR(100) NOT NULL,
                 Email VARCHAR(200) NOT NULL
       );

GO

INSERT INTO Marketing2.Customers (
           First_Name,
           Last_Name,
           Email
       )
VALUES ('John','Doe','john.doe@example.com'),
       ('Jane','Doe','jane.doe@example.com');

GO

SELECT Customer_Id,
       First_Name,
       Last_Name,
       Email
  FROM Marketing2.Customers;

GO
```
