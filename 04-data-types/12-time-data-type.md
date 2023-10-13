# `TIME` Data Type

---

- [Overview](#overview)
- [Examples](#examples)

---

## Overview

- Store time data in a table
- A time of a day based on 24-hour clock

```sql
TIME[(fractional_second_scale)]
```

- `fractional_second_scale`
  - Specifies the number of digits for the fractional part of the seconds
  - Ranges from 0 to 7
  - Default is 7 if unspecified
- `DATE` data type has only the date component
- Range: 0001-01-01 to 9999-12-31
- It takes 3 bytes to store a `DATE` value
- Default string format: `hh:mm:ss[.nnnnnnn]`
- **A time value with the default of 100ms fractional second precision requires 5 bytes storage**
- **NOTE: TIME data type is not the time zone-awareness**

## Examples

```sql
CREATE TABLE Sales.Visits_With_Time (
                Visit_Id INT PRIMARY KEY IDENTITY,
           Customer_Name VARCHAR (50) NOT NULL,
                   Phone VARCHAR (25),
                Store_Id INT NOT NULL,
                Visit_On DATE NOT NULL,
                Start_At TIME (0) NOT NULL,
                  End_At TIME (0) NOT NULL,
                 FOREIGN KEY (Store_Id) REFERENCES Sales.Stores (Store_Id)
       );

GO

INSERT INTO Sales.Visits_With_Time (
           Customer_Name,
           Phone,
           Store_Id,
           Visit_On,
           Start_At,
           End_At
       )
VALUES (
          'John Doe',
          '(408)-993-3853',
          1,
          '2018-06-23',
          '09:10:00',
          '09:30:00'
       );

GO

SELECT *
  FROM Sales.Visits_With_Time;

GO
```
