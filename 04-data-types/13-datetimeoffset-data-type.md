# `DATETIMEOFFSET` Data Type

---

- [Overview](#overview)
- [Timezone Offset](#timezone-offset)
- [Examples](#examples)

---

## Overview

- Allows to manipulate datetime with time zone
  - Allows to manipulate any single point in time, which is a datetime value
  - Has an offset that specifies how much that datetime differs from UTC

```sql
DATETIMEOFFSET [(fractional_seconds_precision)]

-- Literal Formal
YYYY-MM-DDThh:mm:ss[.nnnnnnn][{+|-}hh:mm]

-- ISO Literal Format
YYYY-MM-DDThh:mm:ss[.nnnnnnn]Z
```

- Date range from 0001-01-01 to 9999-12-31
- Time range from 00:00:00 to 23:59:59.9999999

## Timezone Offset

- Specifies the zone offset from UTC
- Represented as `[+|-] hh:mm`
  - `hh` range from 00 to 14, represents the number of hour in the time zone offset
  - `mm` range from 00 to 59, represents the number of additional minutes in the time zone offset
  - `+` or `-` specifies whether the time zone offset is added or subtracted from the UTC time to return the local time
- **The valid range of a time zone offset is -14:00 to +14:00**

## Examples

```sql
-- Literal Format
2020-12-12 11:30:30.12345

-- ISO Literal Format
2020-12-12 19:30:30.12345Z
```

```sql
CREATE TABLE Messages (
                   Id INT PRIMARY KEY IDENTITY,
            "Message" VARCHAR(255) NOT NULL,
           Created_At DATETIMEOFFSET NOT NULL
       );

GO

INSERT INTO Messages (
           "Message",
           Created_At
       )
VALUES (
           'DATETIMEOFFSET demo',
           CAST('2019-02-28 01:45:00.0000000 -08:00' AS DATETIMEOFFSET)
       );

GO

SELECT Id,
       "Message",
       Created_At AS 'Pacific Standard Time',
       Created_At AT TIME ZONE 'SE Asia Standard Time', AS 'SE Asia Standard Time'
  FROM Messages;

GO
```

- Use `AT TIME ZONE` to convert the stored `DATETIMEOFFSET` value to a different timezone
