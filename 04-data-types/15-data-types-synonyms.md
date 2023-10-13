
# Data Types Synonyms

---

- [Overview](#overview)
- [Example of Use](#example-of-use)

---

## Overview

- Data type synonyms are included in SQL Server for ISO compatibility

Synonym | SQL Server system data type
:------:|:--------------------------:
BINARY VARYING|`VARBINARY`
CHAR VARYING|`VARCHAR`
CHARACTER|`CHAR`
CHARACTER|`CHAR(1)`
CHARACTER(n)|`CHAR(n)`
CHARACTER VARYING(n)|`VARCHAR(n)`
DEC|`DECIMAL`
DOUBLE PRECISION|`FLOAT`
FLOAT[(n)] for n = 1-7|`REAL`
FLOAT[(n)] for n = 8-15|`FLOAT`
INTEGER|`INT`
NATIONAL CHARACTER(n)|`NCHAR(n)`
NATIONAL CHAR(n)|`NCHAR(n)`
NATIONAL CHARACTER VARYING(n)|`NVARCHAR(n)`
NATIONAL CHAR VARYING(n)|`NVARCHAR(n)`
NATIONAL TEXT|`NTEXT`
TIMESTAMP|`ROWVERSION`

- Data type synonyms can be used instead of the corresponding base data type name in data definition language (DDL) statements: `CREATE TABLE`, `CREATE PROCEDURE`, and `DECLARE @variable`.
- After the object is created, the synonyms have no visibility
- When the object is created, the object is assigned the base data type that is associated with the synonym
- There's no record that the synonym was specified in the statement that created the object
- Objects that are derived from the original object, such as result set columns or expressions, are assigned the base data type
- Any metadata functions that use the original object or any derived objects will report the base data type, not the synonym

## Example of Use

```sql
CREATE TABLE ExampleTable (
           ThePrimKey INT PRIMARY KEY,
           VarCharCol NATIONAL CHARACTER VARYING(10)
       );
```
