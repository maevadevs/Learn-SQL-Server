# Integers Data Type

---

- [`INT`](#int)
- [`BIGINT`](#bigint)
- [Examples](#examples)
- [Converting Integer Data](#converting-integer-data)

---

- There are 4 integer types in SQL Server
  - `TINYINT` - 1 BYTE
  - `SMALLINT` - 2 BYTES
  - `INT` - 4 BYTES
  - `BIGINT` - 8 BYTES
- *Use the smallest integer data type that can reliably contain all possible values*

## `INT`

- Primary/default integer data type

## `BIGINT`

- Use when values might exceed the range supported by `INT`
- Fits between `SMALLMONEY` and `INT`
- Functions return `BIGINT` only if the parameter expression is a `BIGINT`
- **SQL Server does not automatically promote other integer data types (`TINYINT`, `SMALLINT`, and `INT`) to `BIGINT`**
  - Integer constants greater than `2,147,483,647` are by default converted to `DECIMAL`, not `BIGINT`

## Examples

```sql
CREATE TABLE test.sql_server_integers (
             Bigint_Col BIGINT,
                Int_Col INT,
           Smallint_Col SMALLINT,
            Tinyint_Col TINYINT
       );

GO

-- Insert the maximum value for each data type
INSERT INTO test.sql_server_integers (
           Bigint_Col,
           Int_Col,
           Smallint_Col,
           Tinyint_Col
       )
OUTPUT inserted.Bigint_Col,
       inserted.Int_Col,
       inserted.Smallint_Col,
       inserted.Tinyint_Col
VALUES (
           9223372036854775807,
           2147483647,
           32767,
           255
       );

GO
```

## Converting Integer Data

- Integer constants greater than `2,147,483,647` are by default converted to `DECIMAL`, not `BIGINT`

```sql
SELECT 2147483647 / 3 AS r1,
       2147483649 / 3 AS r2;
```

- When the threshold value is exceeded, the data type of the result changed from `INT` to a `DECIMAL`
