# `CHAR` Data Type

---

- [Overview](#overview)
- [Example](#example)

---

## Overview

- Allows to store the fixed-length, non-Unicode character strings
- Use only when the sizes of values in the column are fixed

```sql
CHAR(n)
```

- String length `n` ranges from 1 to 8000
  - Default value for `n` is 1
- If the length of the string value is less than the length specified in the column, SQL Server will add trailing spaces to the string value to the length declared in the column
  - When running `SELECT`, SQL Server removes the trailing spaces before returning it
- If inserting a value whose length exceeds the column length, SQL Server issues an error message
- ISO synonym for `CHAR` is `CHARACTER`
  - Can use them interchangeably

## Example

```sql
-- Create a test table for CHAR
CREATE TABLE Test.Sql_Server_Char (
           Val CHAR(3)
       );

GO

-- Insert a fixed-length character string into the CHAR column
INSERT INTO Test.Sql_Server_Char (Val)
VALUES ('ABC');

GO

-- Insert a new character string whose length exceeds the column length
INSERT INTO Test.Sql_Server_Char (Val)
VALUES ('XYZ1');
-- Error: String or binary data would be truncated in table 'BikeStores.Test.Sql_Server_Char', column 'Val'. Truncated value: 'XYZ'

GO

-- Insert a single character
INSERT INTO Test.Sql_Server_Char (Val)
VALUES ('A');

GO
```

- `LEN()` - Returns the number of characters in a specified column that excludes the trailing blanks
- `DATALENGTH()` - Returns the number of bytes

```sql
SELECT Val,
       LEN(Val) length,
       DATALENGTH(Val) Data_Length
  FROM Test.Sql_Server_Char;
```

- Even though the character `A` is only one character, the number of bytes of the column is fixed which is 3
