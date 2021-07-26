# `AND`

Combine two Boolean expressions and return `TRUE` *if and only if* **all** expressions are `TRUE`, otherwise return `FALSE`

- If any expression is `FALSE`, always return `FALSE`
  - `FALSE AND UNKNOWN -> FALSE`
  - `TRUE AND UNKNOWN -> UNKNOWN`
  - `UNKNOWN AND UNKNOWN -> UNKNOWN`

```sql
boolean_expression AND boolean_expression
```

## Examples `AND`

```sql
SELECT *
FROM Production.Products
WHERE Category_Id = 1
    AND List_Price > 400
ORDER BY List_Price DESC;
```

We can use multiple conditions with `AND`

```sql
SELECT *
FROM Production.Products
WHERE Category_Id = 1
    AND List_Price > 400
    AND Brand_Id = 1
ORDER BY List_Price DESC;
```

- We can also combine with other logical operators
  - **`AND` takes precedence over `OR`**
  - If we want to be explicit on the order of priority, we can wrap the conditions inside parentheses

```sql
SELECT *
FROM Production.Products
WHERE (
    Brand_Id = 1 
    OR Brand_Id = 2
)
    AND List_Price > 1000
ORDER BY Brand_Id DESC;
```
