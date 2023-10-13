# `DATE` Data Type

---

- [Overview](#overview)
- [Examples](#examples)

---

## Overview

- Store date data in a table

```sql
DATE
```

- `DATE` data type has only the date component
- Range: 0001-01-01 to 9999-12-31
- It takes 3 bytes to store a `DATE` value
- Default string format: `YYYY-MM-DD`

## Examples

```sql
SELECT Order_Id,
       Customer_Id,
       Order_Status,
       Order_Date
  FROM Sales.Orders
 WHERE Order_Date < '2016-01-05'
 ORDER BY Order_Date DESC;

GO

CREATE TABLE Sales.List_Prices (
           Product_Id INT NOT NULL,
           Valid_From DATE NOT NULL,
             Valid_To DATE NOT NULL,
               Amount DEC (10, 2) NOT NULL,
              PRIMARY KEY (
                          Product_Id,
                          Valid_From,
                            Valid_To
                      ),
              FOREIGN KEY (Product_Id) REFERENCES Production.Products (Product_Id)
       );

GO

INSERT INTO Sales.List_Prices (
           Product_Id,
           Valid_From,
           Valid_To,
           Amount
       )
VALUES (
           1,
           '2019-01-01',
           '2019-12-31',
           400
       );

GO

SELECT *
  FROM Sales.List_Prices;

GO
```
