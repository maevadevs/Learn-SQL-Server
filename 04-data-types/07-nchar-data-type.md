# `NCHAR` Data Type

---

- [Overview](#overview)
- [`CHAR` vs `NCHAR`](#char-vs-nchar)
- [Example](#example)

---

## Overview

- Store fixed-length, Unicode character string data
- For storing fixed-length character string only
  - If the lengths of data values are variable, consider using `VARCHAR` or `NVARCHAR` instead

```sql
NCHAR(n)
```

- String length `n` ranges from 1 to 4000
- Storage size of is two times `n` bytes
- ISO synonym for `NATIONAL CHAR` is `NATIONAL CHARACTER`
  - Can use them interchangeably

## `CHAR` vs `NCHAR`

`CHAR`|`NCHAR`
:-:|:-:
**Non-Unicode** characters only|**Unicode** characters in the form of UNICODE UCS-2
1 byte to store a character|2 bytes to store a character
Storage size equals the size specified in the column definition or variable declaration|Storage size equals **double** the size specified in the column definition or variable declaration
Store up to 8000 characters|Store up to 4000 characters

## Example

```sql
CREATE TABLE Test.Sql_Server_Nchar (
           Val NCHAR(1) NOT NULL
       );

GO

INSERT INTO Test.Sql_Server_Nchar (Val)
VALUES (N'あ');

GO

SELECT *
  FROM Test.Sql_Server_Nchar;

GO
```

- Must prefix the Unicode character string constants with the letter `N`
  - Otherwise, SQL Server will convert the string to the default code page of the database (may not recognize some certain Unicode)
- **If character string length is greater than the length specified in the column definition, SQL Server issues an error and terminates the statement**

```sql
INSERT INTO Test.Sql_Server_Nchar (Val)
VALUES (N'いえ');
-- Error: String or binary data would be truncated in table 'BikeStores.Test.Sql_Server_Nchar', column 'Val'. Truncated value: 'い'.
```

- `LEN(col)` - Get the number of characters in the column
- `DATALENGTH(col)` - Get the number of bytes of the values in the column

```sql
SELECT Val,
       LEN(Val)        AS "Length",
       DATALENGTH(Val) AS "Data_Length"
  FROM Test.Sql_Server_Nchar;
```
