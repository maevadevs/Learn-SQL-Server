# `WHERE`

- Filter rows in the output of a query based on one or more Search Conditions
- Only returns the rows that causes the Search Condition to evaluate to `TRUE`

```sql
SELECT 
    Col_1, 
    Col_2, 
    Col_3
FROM Table_Name
WHERE Search_Condition;
```

- `search_condition` is a logical expression or a combination of multiple logical expressions, often called a **Predicate**
- **SQL Server uses 3-valued predicate logic:**
  - `TRUE`
  - `FALSE`
  - `UNKNOWN`
- `WHERE` will not return any row that causes the predicate to evaluate to `FALSE` or `UNKNOWN`

## Examples `WHERE`

We can use a simple equality

```sql
SELECT 
    Product_Id, 
    Product_Name, 
    Category_Id, 
    Model_Year, 
    List_Price
FROM Production.Products
WHERE Category_Id = 1
ORDER BY List_Price DESC;
```

We can use mutliple conditions, which can be *must be true* or *either be true*

```sql
SELECT 
    Product_Id, 
    Product_Name, 
    Category_Id, 
    Model_Year, 
    List_Price
FROM Production.Products
WHERE Category_Id = 1
    AND Model_Year = 2018
ORDER BY List_Price DESC;
```

```sql
SELECT 
    Product_Id, 
    Product_Name, 
    Category_Id, 
    Model_Year, 
    List_Price
FROM Production.Products
WHERE Category_Id = 1
    OR Model_Year = 2018
ORDER BY List_Price DESC;
```

We can use comparison operators

```sql
SELECT 
    Product_Id, 
    Product_Name, 
    Category_Id, 
    Model_Year, 
    List_Price
FROM Production.Products
WHERE List_Price >= 300 
    AND Model_Year <= 2018
ORDER BY List_Price DESC;
```

- We can use `BETWEEN` for a range of value
- **The values used with `BETWEEN` are inclusive on both end**

```sql
SELECT 
    Product_Id, 
    Product_Name, 
    Category_Id, 
    Model_Year, 
    List_Price
FROM Production.Products
WHERE List_Price BETWEEN 1899.00 AND 1999.99
ORDER BY List_Price DESC;
```

This is equivalent to the following

```sql
SELECT 
    Product_Id, 
    Product_Name, 
    Category_Id, 
    Model_Year, 
    List_Price
FROM Production.Products
WHERE List_Price >= 1899.00 
    AND List_Price <= 1999.99
ORDER BY List_Price DESC;
```

- We can use the `IN` operator for values within a specific list or subquery
- This is equivalent to using multiple `AND` operators

```sql
SELECT 
    Product_Id, 
    Product_Name, 
    Category_Id, 
    Model_Year, 
    List_Price
FROM Production.Products
WHERE List_Price IN (
    299.99, 
    369.99, 
    489.99
)
ORDER BY List_Price DESC;
```

- We can use the `LIKE` operator for finding specific strings
- This can be used for partial RegEx functionalities
- **SQL Server does not have built-in support for RegEx**
<!---->
- `%` - A string of zero or more characters
- `_` - A single characters
- `[charRange]` - Any single character within a specified range. The characters within the square brackets are used for the matching process
- `[^charRange]` - None of the single characters within the specified range
- `[char-char]` - A specific range of characters

```sql
SELECT 
    Product_Id, 
    Product_Name, 
    Category_Id, 
    Model_Year, 
    List_Price
FROM Production.Products
WHERE Product_Name LIKE '%Cruiser%'
ORDER BY List_Price;
```
