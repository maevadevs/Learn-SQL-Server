# `WHERE`

- Filter rows in the output of a query based on one or more Search Conditions
- Only returns the rows that cause the Search Condition to evaluate to `TRUE`

```sql
SELECT col1, col2, col3
FROM table_name
WHERE search_condition;
```

- Search Condition is a logical expression or a combination of multiple logical expressions, often called a *Predicate*
- SQL Server uses 3-valued predicate logic:
  - `TRUE`
  - `FALSE`
  - `UNKNOWN`
- `WHERE` will not return any row that causes the predicate evaluates to `FALSE` or `UNKNOWN`

## Examples `WHERE`

We can use a simple equality

```sql
SELECT product_id, product_name, category_id, model_year, list_price
FROM production.products
WHERE category_id = 1
ORDER BY list_price DESC;
```

We can use mutliple conditions, either *must be true* or *either be true*

```sql
SELECT product_id, product_name, category_id, model_year, list_price
FROM production.products
WHERE category_id = 1 AND model_year = 2018
ORDER BY list_price DESC;
```

```sql
SELECT product_id, product_name, category_id, model_year, list_price
FROM production.products
WHERE list_price > 3000 OR model_year = 2018
ORDER BY list_price DESC;
```

We can use comparison operators

```sql
SELECT product_id, product_name, category_id, model_year, list_price
FROM production.products
WHERE list_price >= 300 AND model_year <= 2018
ORDER BY list_price DESC;
```

We can use `BETWEEN` for a range of value. The values used with `BETWEEN` are inclusive on both end

```sql
SELECT product_id, product_name, category_id, model_year, list_price
FROM production.products
WHERE list_price BETWEEN 1899.00 AND 1999.99
ORDER BY list_price DESC;
```

This is equivalent to

```sql
SELECT product_id, product_name, category_id, model_year, list_price
FROM production.products
WHERE list_price >= 1899.00 
AND list_price <= 1999.99
ORDER BY list_price DESC;
```


We can use the `IN` operator for values withing a specific list or subquery

```sql
SELECT product_id, product_name, category_id, model_year, list_price
FROM production.products
WHERE list_price IN (299.99, 369.99, 489.99)
ORDER BY list_price DESC;
```

We can use the `LIKE` operator for finding specific strings. This can be used for partial RegEx functionalities

- `%` - A string of zero or more characters
- `_` - A single characters
- `[charRange]` - Any single character within a specified range. The characters within the square brackets are used for the matching process
- `[^charRange]` - None of the single characters within the specified range
- `[char-char]` - A range of characters

```sql
SELECT product_id, product_name, category_id, model_year, list_price
FROM production.products
WHERE product_name LIKE '%Cruiser%'
ORDER BY list_price;
```
