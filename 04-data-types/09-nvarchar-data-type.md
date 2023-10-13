# `NVARCHAR` Data Type

---

- [Overview](#overview)
- [`VARCHAR` vs `NVARCHAR`](#varchar-vs-nvarchar)
- [Example](#example)

---

## Overview

- Store **variable-length**, **Unicode** string data

```sql
NVARCHAR(n)
NVARCHAR(max)
```

- String length `n` ranges from 1 to 4000
  - Default value is 1
- `max` defines the maximum storage size which is $2^{31}-1$ bytes (2 GB)
- The storage size of a `NVARCHAR` value is 2 times the actual length of the data stored plus 2 bytes
- ISO synonym for `VARCHAR` is `NATIONAL CHAR VARYING` and `NATIONAL CHARACTER VARYING`
  - Can use them interchangeably

## `VARCHAR` vs `NVARCHAR`

`VARCHAR`|`NVARCHAR`
:-:|:-:
**Non-Unicode** characters only|**Unicode** characters
Store up to 8000 characters|Store up to 4000 characters
1 byte per character|2 bytes per Unicode/Non-Unicode character
Actual Length (in bytes)|2 times Actual Length (in bytes)
Used when data length is variable or variable length columns and if actual data is always way less than capacity|Due to storage only, used only if need Unicode support for Non-ANSI, International characters

## Example

```sql
CREATE TABLE Test.Sql_Server_Nvarchar (
           Val NVARCHAR(1) NOT NULL
       );

GO
```

- Because we did not specify the string length of the  column, it defaults to 1
- We can use `ALTER TABLE ALTER COLUMN` to fix it

```sql
ALTER TABLE Test.Sql_Server_Nvarchar
ALTER COLUMN Val NVARCHAR(10) NOT NULL;

GO

INSERT INTO Test.Sql_Server_Nvarchar (Val)
VALUES (N'こんにちは');

GO

SELECT *
  FROM Test.Sql_Server_Nvarchar;

GO
```

- **If character string length is greater than the length specified in the column definition, SQL Server issues an error and terminates the statement**

```sql
INSERT INTO Test.Sql_Server_Varchar (Val)
VALUES (N'ありがとうございました');
-- Error: String or binary data would be truncated in table 'BikeStores.Test.Sql_Server_Varchar', column 'Val'. Truncated value: '??????????'.
```

- `LEN(col)` - Get the number of characters in the column
- `DATALENGTH(col)` - Get the number of bytes of the values in the column

```sql
SELECT Val,
       LEN(Val)        AS "Length",
       DATALENGTH(Val) AS "Data_Length"
  FROM Test.Sql_Server_Nvarchar;
```
