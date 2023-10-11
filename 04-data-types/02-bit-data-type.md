# `BIT` Data Type

---

- [Overview](#overview)
- [Examples](#examples)

---

## Overview

- An integer type
- Can have `1`, `0`, or `NULL`
- Database Engine optimizes storage of bit columns
  - With 8 or fewer bit columns in a table, the columns are stored as 1 byte
  - With 9 up to 16 bit columns, the columns are stored as 2 bytes, and so on
- String values `TRUE` and `FALSE` can be converted to bit `1` and `0` values
- Converting to bit promotes any nonzero value to `1`

## Examples

```sql
CREATE SCHEMA Test;
GO

CREATE TABLE Test.Sql_Server_Bit (
           Bit_Col BIT
       );

GO

INSERT INTO Test.Sql_Server_Bit (Bit_Col)
OUTPUT inserted.Bit_Col
VALUES (1);

GO
```

- Inserting a string value `TRUE` would convert it to `1`
- Inserting a string value `FALSE` would convert it to `0`

```sql
INSERT INTO Test.Sql_Server_Bit (Bit_Col)
OUTPUT inserted.Bit_Col
VALUES ('FALSE');

GO
```

- Any numerical non-zero values are also converted to `1`

```sql
INSERT INTO Test.Sql_Server_Bit (Bit_Col)
OUTPUT inserted.Bit_Col
VALUES (3.14);

GO
```
