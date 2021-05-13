# MSSQL vs Postgre SQL

||MSSQL|PostgreSQL
|--|:--|:--
**Price**|$3,586 to $13,748|Free
**License**|Standard, Enterprise|Free
**Source Code**|Closed Source|Open Source
**Developer**|Microsoft|The PostgreSQL Global Development Group
**Initial Release**|1989|1989
**LTS Support**|10-16 Years|5 Years
**Languages**|Transact-SQL|PL/pgSQL
**OS Support**|Windows, Linux, Mac|Windows, Linux, Mac
**64-bit integer**|`BIGINT`|`BIGINT`
**Fixed length byte string**|`BINARY(n)`|`BYTEA`
**1, 0 or NULL**|`BIT`|`BOOLEAN`
**Fixed length char string, 1 <= n <= 8000**|`CHAR(n)`|`CHAR(n)`
**Variable length char string, 1 <= n <= 8000**|`VARCHAR(n)`|`VARCHAR(n)`
**Variable length char string, <= 2GB**|`VARCHAR(max)`|`TEXT`
**Variable length byte string , 1 <= n <= 8000**|`VARBINARY(n)`|`BYTEA`
**Variable length byte string , <= 2GB**|`VARBINARY(max)`|`BYTEA`
**Variable length Unicode UCS-2 string**|`NVARCHAR(n)`|`VARCHAR(n)`
**Variable length Unicode UCS-2 data, <= 2GB**|`NVARCHAR(max)`|`TEXT`
**Variable length character data, <= 2GB**|`TEXT`|`TEXT`
**Variable length Unicode UCS-2 data, <= 2GB**|`NTEXT`|`TEXT`
**Double precision floating point number**|`DOUBLE PRECISION`|`DOUBLE PRECISION`
**Floating point number**|`FLOAT(p)`|`DOUBLE PRECISION`
**32 bit integer**|`INTEGER`|`INTEGER`
**Fixed point number**|`NUMERIC(p,s)`|`NUMERIC(p,s)`
**Date includes year, month, and day**|`DATE`|`DATE`
**Date and time with fractional seconds**|`DATETIME, DATETIME2(p)`|`TIMESTAMP(p)`
**Date and time with time zone**|`DATETIMEOFFSET(p)` |`TIMESTAMP(p) WITH TIME ZONE`
**Date and time**|`SMALLDATETIME`|`TIMESTAMP(0)`
**Unsigned integer, 0 to 255 (8 bit)**|`SMALLINT`|`TINYINT`
**UUID (16 byte)**|`UNIQUEIDENTIFIER`|`CHAR(16)`
**Automatically updated binary data**|`ROWVERSION`|`BYTEA`
**Currency amount (32 bit)**|`SMALLMONEY`|`MONEY`
**Variable length binary data, <= 2GB**|`IMAGE`|`BYTEA`
**Geometric types**|`GEOMETRY`|`POINT`, `LINE`, `LSEG`, `BOX`, `PATH`, `POLYGON`, `CIRCLE`
**Geospatial Data**|No Support|Support
