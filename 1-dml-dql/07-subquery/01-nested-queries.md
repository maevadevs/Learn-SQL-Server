# Subquery

- A Subquery is a query nested within another statement such as `SELECT`, `INSERT`, `UPDATE` or `DELETE`
- Also known as an *inner query* or *inner select*
- **Always enclose the `SELECT` query of a subquery in parentheses**
- The query automatically adjusts whenever the data changes

## Example

Find the sales orders of the customers who are located in New York

```sql
SELECT
	customer_id,
    order_id,
    order_date
FROM sales.orders
WHERE customer_id IN (
    -- This is a subquery
    SELECT customer_id
    FROM sales.customers
    WHERE city = 'New York'
)
ORDER BY order_date DESC;
```

## Order of Execution

- **The inner-most subquery is executed first**
  - Substitute the result of the subquery where the subquery is
- Execute outer-level query until all parent queries are executed

## Nesting Query

- A subquery can be nested within another subquery
- **SQL Server supports up to 32 levels of nesting**
- However, with each level, there is a performance hit

```sql
-- This is executed 3rd
SELECT
    product_name,
    list_price
FROM production.products
WHERE list_price > (
    -- This is executed 2nd
    SELECT AVG (list_price)
    FROM production.products
    WHERE brand_id IN (
        -- This is executed 1st
        SELECT brand_id
        FROM production.brands
        WHERE brand_name = 'Strider'
            OR brand_name = 'Trek'
    )
)
ORDER BY list_price DESC;
```

## SQL Server Subquery Use-Cases

- In place of an expression
- With `IN` or `NOT IN`
- With `ANY` or `ALL`
- With `EXISTS` or `NOT EXISTS`
- In `UPDATE`, `DELETE`, `INSERT`
- In `FROM` 

### Use In Place of an Expression

- If a subquery returns a single value, it can be used anywhere an expression is used

```sql
SELECT
    order_id,
    order_date,
    (
        SELECT MAX (list_price)
        FROM sales.order_items i
        WHERE i.order_id = o.order_id
    ) 
    AS max_list_price
FROM sales.orders o
ORDER BY order_date DESC;
```

### Use With `IN` or `NOT IN`

- Returns a set of zero or more values
- After the subquery returns values, the outer query makes use of them

Find the names of all mountain bikes and road bikes products that the Bike Stores sell

```sql
SELECT
    product_id,
    product_name
FROM production.products
WHERE category_id IN (
    SELECT category_id
    FROM production.categories
    WHERE category_name = 'Mountain Bikes'
        OR category_name = 'Road Bikes'
);
```

### Use With `ANY` or `ALL`

Follows the syntax

```sql
scalar_expression comparison_operator ANY|ALL (subquery)
```

- Assuming that the subquery returns a list of value `v1`, `v2`,... `vn`
  - `ANY` returns `TRUE` if just one of a comparison pair evaluates to `TRUE`
    - `FALSE` otherwise
  - `ALL` returns `TRUE` only if all comparison pairs evaluate to `TRUE`
    - `FALSE` otherwise

Find the products whose list prices are greater than or equal to the average list price of any product brand

```sql
SELECT
    product_name,
    list_price
FROM production.products
WHERE list_price >= ANY (
    SELECT AVG (list_price)
    FROM production.products
    GROUP BY brand_id
);
```

Finds the products whose list price is greater than or equal to the average list price returned by the subquery

```sql
SELECT
    product_name,
    list_price
FROM production.products
WHERE list_price >= ALL (
    SELECT AVG (list_price)
    FROM production.products
    GROUP BY brand_id
);
```

### Use With `EXISTS` or `NOT EXISTS`

Follows the syntax

```sql
WHERE [NOT] EXISTS (subquery)
```

- **The condition evaluates to `TRUE` right away if the subquery returns any result**
  - Otherwise, the condition evaluates to `FALSE`
  - Using `NOT` flips this

Finds the customers who bought products in 2017

```sql
SELECT
    customer_id,
    first_name,
    last_name,
    city
FROM sales.customers c
WHERE EXISTS (
    SELECT customer_id
    FROM sales.orders o
    WHERE o.customer_id = c.customer_id
    AND YEAR (order_date) = 2017
)
ORDER BY
    first_name,
    last_name;
```

Find the customers who did not buy any products in 2017

```sql
SELECT
    customer_id,
    first_name,
    last_name,
    city
FROM sales.customers c
WHERE NOT EXISTS (
    SELECT customer_id
    FROM sales.orders o
    WHERE o.customer_id = c.customer_id
    AND YEAR (order_date) = 2017
)
ORDER BY
    first_name,
    last_name;
```

### Use with `FROM`

This is useful to use the result set as a temporary table

- The query in the `FROM` clause **must have a table alias**

```sql
SELECT columns
FROM subquery;
```

```sql
SELECT AVG(temp_table.order_count) AS avg_order_count_by_staff
FROM
(
    SELECT 
        staff_id, 
        COUNT(order_id) AS order_count
    FROM sales.orders
    GROUP BY staff_id
) 
AS temp_table;
```
