# `GROUP BY`

- Arrange rows in groups by one or more columns
- Groups are determined by the columns that are specified in the `GROUP BY` clause
- `GROUP BY` produces a group for each combination of the values in the columns listed in the `GROUP BY` clause
- `GROUP BY` can also be used to get unique values, similar to `SELECT DISTINCT`

## Format

```sql
SELECT select_list
FROM table_name
GROUP BY
    column_name1,
    column_name2,
    ...;
```

## Example of `GROUP BY`

```sql
SELECT
    O.Customer_Id,
	C.First_Name,
	C.Last_Name,
    YEAR(O.Order_Date) AS Order_Year,
    COUNT(O.Order_Id) AS Order_Count
FROM Sales.Orders AS O 
JOIN Sales.Customers AS C 
    ON O.Customer_Id = C.Customer_Id
WHERE O.Customer_Id IN (1, 2)
GROUP BY 
    O.Customer_Id,
	C.First_Name,
	C.Last_Name,
    YEAR(O.Order_Date)
ORDER BY O.Customer_Id;
```

We can get the same result set using `SELECT DISTINCT`, minus the aggregation (aggregation requires the use of `GROUP BY`)

```sql
SELECT DISTINCT
    O.Customer_Id,
	C.First_Name,
	C.Last_Name,
    YEAR(O.Order_Date) AS Order_Year
FROM Sales.Orders AS O 
JOIN Sales.Customers AS C 
    ON O.Customer_Id = C.Customer_Id
WHERE O.Customer_Id IN (1, 2)
ORDER BY O.Customer_Id;
```

## Using Aggregate Functions

- `GROUP BY` clause is often used with aggregate functions for generating summary reports
  - Arranges rows into groups
  - **If you want to refer to any column or expression that is not listed in the `GROUP BY` clause, you must use that column as the input of an aggregate function**
- ***Aggregate Functions* perform calculations on a group and returns a unique value per group**
  - Returns the summary for each group

### Using `GROUP BY` with `COUNT()` example

```sql
SELECT
    State,
    City,
    COUNT(Customer_Id) AS Customer_Count
FROM Sales.Customers
GROUP BY 
    State,
    City
ORDER BY 
    State,
    City;
```

### Using `GROUP BY` with `MIN()` and `MAX()` example

```sql
SELECT
    Brand_Name,
    MIN(List_Price) AS Min_Price,
    MAX(List_Price) AS Max_Price
FROM Production.Products AS P 
INNER JOIN Production.Brands AS B 
    ON B.Brand_Id =P.Brand_Id
WHERE Model_Year = 2018
GROUP BY Brand_Name
ORDER BY Brand_Name;
```

### Using `GROUP BY` with `AVG()` example

```sql
SELECT
    Brand_Name,
    AVG(List_Price) AS Avg_Price
FROM Production.Products AS P 
INNER JOIN Production.Brands AS B 
    ON B.Brand_Id =P.Brand_Id
WHERE Model_Year = 2018
GROUP BY Brand_Name
ORDER BY Brand_Name;
```

### Using `GROUP BY` with `SUM()` example

```sql
SELECT
    Order_Id,
    SUM(Quantity * List_Price * (1 - Discount)) AS Net_Value
FROM Sales.Order_Items
GROUP BY Order_Id;
```

### Example Using Multiple Aggregate Functions

```sql
SELECT
    Customer_Id,
    YEAR(Order_Date) AS Order_Year,
    COUNT(Order_Id) AS Count_Orders
FROM Sales.Orders
WHERE Customer_Id IN (1, 2)
GROUP BY
    Customer_Id,
    YEAR(Order_Date)
ORDER BY Customer_Id;
```

### List of T-SQL Aggregate Functions

Aggregate Function | Description
-------------------|------------
`APPROX_COUNT_DISTINCT`|Returns the approximate number of unique non-null values in a group
`AVG`|Calculates the average of non-NULL values in a set
`CHECKSUM_AGG`|Calculates a checksum value based on a group of rows
`COUNT`|Returns the number of rows in a group, including rows with `NULL` values
`COUNT_BIG`|Returns the number of rows (with `BIGINT` data type) in a group, including rows with `NULL` values
`GROUPING`|Indicates whether a specified column expression in a `GROUP BY` list is aggregated or not. Returns `1` for aggregated or `0` for not aggregated in the result set. `GROUPING` can be used only in the `SELECT <select>` list, `HAVING`, and `ORDER BY` clauses when `GROUP BY` is specified
`GROUPING_ID`|Computes the level of grouping. `GROUPING_ID` can be used only in the `SELECT <select>` list, `HAVING`, or `ORDER BY` clauses when `GROUP BY` is specified
`MAX`|Returns the highest value (maximum) in a set of non-NULL values
`MIN`|Returns the lowest value (minimum) in a set of non-NULL values
`STDEV`|Returns the statistical standard deviation of all values provided in the expression based on a **sample** of the data population
`STDEVP`|Returns the standard deviation for all values in the provided expression, but does so based on the entire data **population**
`STRING_AGG`|Concatenates the values of string expressions and places separator values between them. The separator is not added at the end of string
`SUM`|Returns the summation of all non-NULL values a set
`VAR`|Returns the statistical variance of values in an expression based on a **sample** of the specified population
`VARP`|Returns the statistical variance of values in an expression but does so based on the entire data **population**
