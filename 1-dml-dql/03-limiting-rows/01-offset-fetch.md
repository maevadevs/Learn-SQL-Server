# `OFFSET` & `FETCH`

- Limit the number of rows returned by a `SELECT` query
  - **These are options for `ORDER BY` only**
  - **You must use `OFFSET` and `FETCH` with `ORDER BY`**
- **Use Case: `OFFSET` and `FETCH` are preferable for implementing the query paging solution than the `TOP` clause as they are more generalized**
- `OFFSET` and `FETCH` have been available since SQL Server 2012 and in Azure SQL Database

```sql
SELECT
    Col_1,
    Col_2,
    Col_3
FROM Schema_Name.Table_Name
ORDER BY
    Col_1 [ASC|DESC],
    Col_2 [ASC|DESC]
OFFSET n [ROW|ROWS]
FETCH [FIRST|NEXT] m [ROW|ROWS] ONLY;
```

- `OFFSET` - The number of rows to skip before starting to return rows from the query
  - `n` - Can be constant, variable, or parameter >= 0
- `FETCH` - The number of rows to return after the `OFFSET` clause has been processed
  - `m` - Can be constant, variable, or parameter >= 0
- **`OFFSET` clause is mandatory**
- **`FETCH` clause is optional. If ommited, return all**
- `FIRST|NEXT` - Aliases
- `ROW|ROWS` - Aliases

<img src="../../figures/offset-fetch.png" width=50%>

## Examples `OFFSET` & `FETCH`

Let's say we start with the following basic `ORDER BY` query for `Products`

```sql
SELECT 
    Product_Name, 
    List_Price
FROM Production.Products
ORDER BY 
    List_Price DESC, 
    Product_Name;
```

We can skip the first 10 products and return the rest

```sql
SELECT 
    Product_Name, 
    List_Price
FROM Production.Products
ORDER BY 
    List_Price DESC, 
    Product_Name
OFFSET 10 ROWS;
```

We can skip the first 10 products and select the next 20 products only

```sql
SELECT 
    Product_Name, 
    List_Price
FROM Production.Products
ORDER BY 
    List_Price DESC, 
    Product_Name
OFFSET 10 ROWS
FETCH NEXT 20 ROWS ONLY;
```

We can get the top 10 most expensive products

```sql
SELECT 
    Product_Name, 
    List_Price
FROM Production.Products
ORDER BY 
    List_Price DESC, 
    Product_Name
OFFSET 0 ROWS
FETCH FIRST 10 ROWS ONLY;
```

This is the same as using `SELECT TOP`

```sql
SELECT TOP 10
    Product_Name, 
    List_Price
FROM Production.Products
ORDER BY 
    List_Price DESC, 
    Product_Name;
```
