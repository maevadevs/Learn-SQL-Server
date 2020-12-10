# Aliases

- Use column aliases to change the heading of the query output and table alias
- Improve readability of queries
- We can use basic column transformations and assign the result to aliases
- A temporary name during the query execution
- We use `AS` to assign aliases. But it is optional so we can do without it
- If the column alias contains spaces, you need to enclose it in quotation marks

```sql
column_name|expression AS column_alias
column_name|expression column_alias

```

## Example Column Alias

Using column alias with column transformations

```sql
SELECT first_name + ' ' + last_name AS full_name
FROM sales.customers
ORDER BY full_name;
```

```sql
SELECT category_name 'Product Category'
FROM production.categories;
```

- We can use column aliases in `ORDER BY`
- We cannot use column aliases in `GROUP BY`, `WHERE`, and `HAVING` because of the logical order of processing
  - SQL Server processes the clauses in the following sequence: `FROM -> ON -> OUTER -> WHERE -> GROUP BY -> HAVING -> SELECT -> DISTINCT -> ORDER BY -> TOP`
  - Aliases are defined at the `SELECT` clause
  - `ORDER BY` is after `SELECT`
- Aliases cannot be used by other expressions within the same `SELECT` list
  - This is because the logical order in which the expressions are evaluated does not matter and is not guaranteed

```sql
-- This might not work well and is not supported
SELECT col1 + 10 AS res, res + 20 AS final
```

## Table Aliases

- Also known as *Correlation Name* or *Range Variable*
- Works the same way as column aliases
- Very helpful when working with joins
- **When you assign an alias to a table, you must use the alias to refer to the table column**
  - Otherwise, SQL Server will issue an error

```sql
table_name AS table_alias
table_name table_alias
```

## Examples Tables Aliases

```sql
-- Join without Aliases
SELECT sales.customers.customer_id, first_name, last_name, order_id
FROM sales.customers INNER JOIN sales.orders
ON sales.orders.customer_id = sales.customers.customer_id;
```

We can re-write in the following way

```sql
SELECT c.customer_id, first_name, last_name, order_id
FROM sales.customers c INNER JOIN sales.orders o
ON o.customer_id = c.customer_id;
```

- **NOTE**: `FROM` is executed before `SELECT` so we can use the table aliases in `SELECT`