# `DATETIME2` Data Type

---

- [Overview](#overview)
- [Example](#example)

---

## Overview

- Store both date and time data in a table

```sql
DATETIME2(fractional_seconds_precision)
```

- `fractional_seconds_precision` is optional
  - Ranges from 0 to 7

```sql
CREATE TABLE Table_Name (
           ...
           Column_Name DATETIME2(3),
           ...
       );
```

- `DATETIME2` has 2 components: *Date* and *Time*
  - *Date range* - January 01, 01 (0001-01-01) to December 31, 9999 (9999-12-31)
  - *Time range* - 00:00:00 to 23:59:59.9999999
- Storage size depends on the `fractional_seconds_precision`
  - 6 bytes if precision is less than 3
  - 7 bytes if precision is between 3 and 4 (inclusive)
  - 8 bytes for all other precisions
- Default string literal: `YYYY-MM-DD hh:mm:ss[.fractional_seconds]`
  - `YYYY` - [0001...9999]
  - `MM` - [01...12]
  - `DD` - [01...31]
  - `hh` - [00...23]
  - `mm` - [00...59]
  - `ss` - [00...59]
  - `fractional_seconds` - [0...9999999]

## Example

```sql
CREATE TABLE Production.Product_Colors (
             Color_Id INT PRIMARY KEY IDENTITY,
           Color_Name VARCHAR (50) NOT NULL,
           Created_At DATETIME2
       );

GO

INSERT INTO Production.Product_Colors (
           Color_Name,
           Created_At
       )
VALUES ('Red', GETDATE());

GO

SELECT *
  FROM  Production.Product_Colors;

GO
```

- `GETDATE()` gets the current date
  - Same as `CURRENT_TIMESTAMP()`
  - Similar to `NOW()` and `CURRENT_DATE()` in other RDBMS
- We can also insert *literal values* as string

```sql
INSERT INTO Production.Product_Colors (
           Color_Name,
           Created_At
       )
VALUES ('Green', '2018-06-23 07:30:20');

GO

SELECT *
  FROM  Production.Product_Colors;

GO
```

- We can change the default value of the column using `ALTER TABLE ADD CONSTRAINT`

```sql
INSERT INTO Production.Product_Colors (Color_Name)
VALUES ('Blue');

GO

SELECT *
  FROM  Production.Product_Colors;

GO
```
