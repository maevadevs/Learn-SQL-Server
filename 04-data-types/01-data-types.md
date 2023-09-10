# T-SQL Data Types

- SQL Server supplies a set of system data types that define all the types of data that can be used with SQL Server.
- Alias data types are based on the system-supplied data types
- Organized in as follows:
  - Exact numerics
  - Approximate numerics
  - Date and time
  - Character strings
  - Unicode character strings
  - Binary strings
  - Other data types

## Exact Numeric Types

|Type|From|To|Storage
|----|----|--|-------
|`tinyint`|`0`|`255`|1 Byte/8 bits
|`smallint`|`-32,768`|`32,767`|2 Bytes/16 bits
|`int`|`-2,147,483,648`|`2,147,483,647`|4 Bytes/32 bits
|`bigint`|`-9,223,372,036,854,775,808`|	`9,223,372,036,854,775,807`|8 Bytes/64 bits
|`bit`|`0`|`1`|1 bit
|`decimal`|`-10^38 +1`|`10^38 –1`
|`numeric`|`-10^38 +1`|`10^38 –1`
|`smallmoney`|`-214,748.3648`|`+214,748.3647`|4 Bytes/32 bits
|`money`|`-922,337,203,685,477.5808`|`+922,337,203,685,477.5807`|8 Bytes/64 bits
---

- `int` is the primary/default integer data type
- `bigint` is for use when values might exceed the range supported by `int`
- `bigint` fits between `smallmoney` and `int` in the data type precedence chart
- Functions return `bigint` only if the parameter expression is a `bigint`
- SQL Server does not automatically promote other integer data types (`tinyint`, `smallint`, and `int`) to `bigint`
- Integer constants greater than `2,147,483,647` are converted to `decimal`, not `bigint`
- `bit` can have `1`, `0`, or `NULL`
  - The SQL Server Database Engine optimizes storage of bit columns
  - If there are 8 or fewer bit columns in a table, the columns are stored as 1 byte
  - If there are from 9 up to 16 bit columns, the columns are stored as 2 bytes, and so on
  - The string values `TRUE` and `FALSE` can be converted to bit values
  - Converting to bit promotes any nonzero value to `1`
- `decimal` and `numeric` are synonyms and can be used interchangeably
  - Have a fixed `precision` and a `scale`
  - When maximum precision is used, valid values are from `-10^38 +1` through `10^38 -1`
  - The ISO synonyms for `decimal` are `dec` and `dec(p, s)`
  - `precision` - The maximum total number of decimal digits to be stored, includes both the left and the right sides of the decimal point. Must be a value from 1 through the maximum precision of 38. Default: 18.
  - **Note: Informatica only supports 16 significant digits, regardless of the precision and scale specified**
  - `scale` - The number of decimal digits that are stored to the right of the decimal point. Subtracted from `p` to determine the maximum number of digits to the left of the decimal point. Must be a value from `0` through `p`. Can only be specified if precision is specified. The default scale is `0` and so `0 <= s <= p`
  - SQL Server considers each combination of precision and scale as a different data type (`decimal(5,5) != decimal(5,0)`)
  - A constant with a decimal point is automatically converted into a numeric data value, using the minimum precision and scale necessary: `12.345` is converted into a `numeric(5,3)`
  - Converting from `decimal` or `numeric` to `float` or `real` can cause some loss of precision
  - Converting from `int`, `smallint`, `tinyint`, `float`, `real`, `money`, or `smallmoney` to either `decimal` or `numeric` can cause overflow
  - By default, SQL Server uses rounding when converting a number to a decimal or numeric value with a lower precision and scale
  - If the `SET ARITHABORT` option is ON, SQL Server raises an error when overflow occurs
  - *Prior to SQL Server 2016 (13.x), conversion of `float` values to `decimal` or `numeric` is restricted to values of precision 17 digits only. Any float value less than `5E-18` rounds down to 0*
- `money` and `smallmoney` are data types that represent monetary or currency values
  - Accurate to a ten-thousandth of the monetary units that they represent
  - **For Informatica, the money and smallmoney data types are accurate to a one-hundredth of the monetary units that they represent**
  - Currency or monetary data does not need to be enclosed in single quotation marks
  - While you can specify monetary values preceded by a currency symbol, SQL Server does not store any currency information associated with the symbol, it only stores the numeric value

Precision|Storage bytes
---------|-------------
1 - 9|5
10-19|9
20-28|13
29-38|17

---

## Approximate Numeric Types

|Type|From|To
|----|----|--
|`Float`|`-1.79E+308`|`1.79E+308`
|`Real`|`-3.40E+38`|`3.40E+38`
---

## Date and Time Types

|Type|From|To
|----|----|--
`datetime` (3.33 milliseconds accuracy)|`Jan 1, 1753`|`Dec 31, 9999`
`smalldatetime` (1 minute accuracy)|`Jan 1, 1900`|`Jun 6, 2079`
`date` (1 day accuracy. Introduced in SQL Server 2008)|`Jan 1, 0001`|`Dec 31, 9999`
`datetimeoffset` (100 nanoseconds accuracy. Introduced in SQL Server 2008)|`Jan 1, 0001`|`Dec 31, 9999`
`datetime2` (100 nanoseconds accuracy. Introduced in SQL Server 2008)|`Jan 1, 0001`|`Dec 31, 9999`
`time` (100 nanoseconds accuracy. Introduced in SQL Server 2008)|`00:00:00.0000000`|`23:59:59.9999999`
---

## Character Strings

Sr. No|Type|Description
------|----|-----------
1|`char`|Fixed-length non-Unicode character data with a maximum length of 8,000 characters.
2|`varchar`|Variable-length non-Unicode data with a maximum of 8,000 characters.
3|`Varchar(max)`|Variable-length non-Unicode data with a maximum length of 231 characters (Introduced in SQL Server 2005).
4|`text`|Variable-length non-Unicode data with a maximum length of 2,147,483,647 characters
---

## Unicode Character Strings

Sr. No|Type|Description
------|----|-----------
1|`nchar`|Fixed-length Unicode data with a maximum length of 4,000 characters.
2|`nvarchar`|Variable-length Unicode data with a maximum length of 4,000 characters.
3|`Nvarchar(max)`|Variable-length Unicode data with a maximum length of 230 characters (Introduced in SQL Server 2005).
4|`ntext`|Variable-length Unicode data with a maximum length of 1,073,741,823 characters.
---

## Binary Strings

Sr. No|Type|Description
------|----|-----------
1|`binary`|Fixed-length binary data with a maximum length of 8,000 bytes.
2|`varbinary`|Variable-length binary data with a maximum length of 8,000 bytes.
3|`varbinary(max)`|Variable-length binary data with a maximum length of 231 bytes (Introduced in SQL Server 2005).
4|`image`|Variable-length binary data with a maximum length of 2,147,483,647 bytes.
---

## Other Data Types

Type|Description
----|-----------
`sql_variant`|Stores values of various SQL Server-supported data types, except text, ntext, and timestamp.
`timestamp`|Stores a database-wide unique number that gets updated every time a row gets updated.
`uniqueidentifier`|Stores a globally unique identifier (GUID).
`xml`|Stores XML data. You can store XML instances in a column or a variable (Introduced in SQL Server 2005).
`cursor`|A reference to a cursor.
`table`|Stores a result set for later processing.
`hierarchyid`|A variable length, system data type used to represent position in a hierarchy (Introduced in SQL Server 2008).
---

## Notes

Based on their storage characteristics, some data types are designated as belonging to the following groups:

- **Large value data types**: `varchar(max)`, and `nvarchar(max)`
- **Large object data types**: `text`, `ntext`, `image`, `varbinary(max)`, and `xml`

`sp_help` returns `-1` as the *length* for the *large-value* and `xml` data types.

## User-Defined Types

- You can also define your own data types in Transact-SQL or the Microsoft .NET Framework using `CREATE TYPE`
- User-defined types obtain their characteristics from the methods and operators of a class that you create by using one of the programming languages support by the .NET Framework.

## Types Combination Rule

When two expressions that have different data types, collations, precision, scale, or length are combined by an operator, the characteristics of result are determined by the following:

- **T-SQL Data Type Precedence**: The data type of the result is determined by applying the rules of data type precedence to the data types of the input expressions.
- **T-SQL Collation Precedence**: The collation of the result is determined by the rules of collation precedence when the result data type is `char`, `varchar`, `text`, `nchar`, `nvarchar`, or `ntext`.
- **T-SQL Precision, Scale, and Length**: The precision, scale, and length of the result depend on the precision, scale, and length of the input expressions.

## Data Types Synonyms

Data type synonyms are included in SQL Server for ISO compatibility

Synonym | SQL Server system data type
--------|----------------------------
Binary varying|`varbinary`
char varying|`varchar`
character|`char`
character|`char(1)`
character(n)|`char(n)`
character varying(n)|`varchar(n)`
Dec|`decimal`
Double precision|`float`
float[(n)] for n = 1-7|`real`
float[(n)] for n = 8-15|`float`
integer|`int`
national character(n)|`nchar(n)`
national char(n)|`nchar(n)`
national character varying(n)|`nvarchar(n)`
national char varying(n)|`nvarchar(n)`
national text|`ntext`
timestamp|`rowversion`

- Data type synonyms can be used instead of the corresponding base data type name in data definition language (DDL) statements: `CREATE TABLE`, `CREATE PROCEDURE`, and `DECLARE @variable`.
- After the object is created, the synonyms have no visibility
- When the object is created, the object is assigned the base data type that is associated with the synonym
- There's no record that the synonym was specified in the statement that created the object
- Objects that are derived from the original object, such as result set columns or expressions, are assigned the base data type
- Any metadata functions that use the original object or any derived objects will report the base data type, not the synonym

## Example of Use

```sql
CREATE TABLE ExampleTable (
  ThePrimKey int PRIMARY KEY,
  VarCharCol national character varying(10)
)
```
