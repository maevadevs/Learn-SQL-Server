# `DECIMAL`/`NUMERIC` Data Type

---

- [Overview](#overview)
- [Example](#example)

---

## Overview

- Used to stored numbers with fixed `precision` and `scale`
- Synonyms and can be used interchangeably

```sql
DECIMAL(precision, scale)
NUMERIC(precision, scale)
```

- `precision`
  - Maximum total number of decimal digits that will be stored, both to the left and to the right of the decimal point
  - Range from 1 to 38
  - Default precision is 38
- `scale`
  - The number of decimal digits that are stored to the right of the decimal point
  - Subtracted from `precision` to determine the maximum number of digits to the left of the decimal point
  - Range from 0 to `precision`
  - can be specified only if the precision is specified
  - Default scale is 0 so `0 <= s <= p`
- **When maximum precision is used, valid values are from $-10^{38}+1$ through $10^{38}-1$**
- ISO synonyms for `decimal`: `DEC` and `DEC(p, s)`
- Each combination of precision and scale is a different data type (`decimal(5,5) != decimal(5,0)`)
- A constant with a decimal point is automatically converted into a numeric data value, using the minimum precision and scale necessary
  - `12.345` is converted into a `numeric(5,3)`
  - Converting from `decimal` or `numeric` to `float` or `real` can cause some loss of precision
- Converting from `int`, `smallint`, `tinyint`, `float`, `real`, `money`, or `smallmoney` to either `decimal` or `numeric` can cause overflow
  - By default, SQL Server uses rounding when converting a number to a decimal or numeric value with a lower precision and scale
  - If the `SET ARITHABORT` option is ON, SQL Server raises an error when overflow occurs
  - *Prior to SQL Server 2016 (13.x), conversion of `float` values to `decimal` or `numeric` is restricted to values of precision 17 digits only: Any float value less than `5E-18` rounds down to 0*

Precision|Storage bytes
:-------:|:-----------:
1 - 9|5
10-19|9
20-28|13
29-38|17

## Example

```sql
CREATE TABLE Test.Sql_Server_Decimal (
           Dec_Col DECIMAL(4, 2),
           Num_Col NUMERIC(4, 2)
       );

GO

INSERT INTO Test.Sql_Server_Decimal (
           Dec_Col,
           Num_Col
       )
VALUES (10.05, 20.05);

GO

SELECT Dec_Col,
       Num_Col
  FROM Test.Sql_Server_Decimal;

GO
```

- Attempting to insert values that overflow the precision and scale will result in an error

```sql
INSERT INTO Test.Sql_Server_Decimal (
           Dec_Col,
           Num_Col
       )
VALUES (99.999, 12.345);
-- Error: Arithmetic overflow error converting numeric to data type numeric
```
