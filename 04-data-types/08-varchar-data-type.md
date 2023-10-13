# `VARCHAR` Data Type

---

- [Overview](#overview)
- [Example](#example)

---

## Overview

- Store **variable-length**, **non-Unicode** string data

```sql
VARCHAR(n)
VARCHAR(max)
```

- String length `n` ranges from 1 to 8000
  - Default value is 1
- `max` defines the maximum storage size which is $2^{31}-1$ bytes (2 GB)
- The storage size of a `VARCHAR` value is the actual length of the data stored plus 2 bytes
- ISO synonym for `VARCHAR` is `CHARVARYING` and `CHARACTERVARYING`
  - Can use them interchangeably

## Example

```sql
CREATE TABLE Test.Sql_Server_Varchar (
           Val NCHAR(1) NOT NULL
       );

GO
```

- Because we did not specify the string length of the  column, it defaults to 1
- We can use `ALTER TABLE ALTER COLUMN` to fix it

```sql
ALTER TABLE Test.Sql_Server_Varchar
ALTER COLUMN Val VARCHAR(10) NOT NULL;

GO

INSERT INTO Test.Sql_Server_Varchar (Val)
VALUES ('SQL Server');

GO

SELECT *
  FROM Test.Sql_Server_Varchar;

GO
```

- **If character string length is greater than the length specified in the column definition, SQL Server issues an error and terminates the statement**

```sql
INSERT INTO Test.Sql_Server_Varchar (Val)
VALUES ('SQL Server VARCHAR');
-- Error: String or binary data would be truncated in table 'BikeStores.Test.Sql_Server_Varchar', column 'Val'. Truncated value: 'SQL Server'.
```

- `LEN(col)` - Get the number of characters in the column
- `DATALENGTH(col)` - Get the number of bytes of the values in the column

```sql
SELECT Val,
       LEN(Val)        AS "Length",
       DATALENGTH(Val) AS "Data_Length"
  FROM Test.Sql_Server_Varchar;
```
