# `GROUP BY`

- Arrange rows in groups by one or more columns
- Groups are determined by the columns that specified in the `GROUP BY` clause
- `GROUP BY` produce a group for each combination of the values in the columns listed in the `GROUP BY` clause
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
    o.customer_id,
	  c.first_name,
	  c.last_name,
    YEAR (o.order_date) AS order_year,
    COUNT (o.order_id) AS order_count
FROM sales.orders AS o JOIN sales.customers AS c 
	  ON o.customer_id = c.customer_id
WHERE o.customer_id IN (1, 2)
GROUP BY 
    o.customer_id,
	  c.first_name,
	  c.last_name,
    YEAR (o.order_date)
ORDER BY o.customer_id;
```

We can get the same result set using `SELECT DISTINCT`, minus the aggregation (aggregation requires the use of `GROUP BY`)

```sql
SELECT DISTINCT
    o.customer_id,
    c.first_name,
    c.last_name,
    YEAR (o.order_date) AS order_year
FROM sales.orders o JOIN sales.customers c 
	  ON o.customer_id = c.customer_id
WHERE o.customer_id IN (1, 2)
ORDER BY o.customer_id;
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
    state,
    city,
    COUNT (customer_id) AS customer_count
FROM sales.customers
GROUP BY 
    state,
    city
ORDER BY 
    state, 
    city;
```

### Using `GROUP BY` with `MIN()` and `MAX()` example

```sql
SELECT
    brand_name,
    MIN (list_price) AS min_price,
    MAX (list_price) AS max_price
FROM production.products p INNER JOIN production.brands b 
    ON b.brand_id = p.brand_id
WHERE model_year = 2018
GROUP BY brand_name
ORDER BY brand_name;
```

### Using `GROUP BY` with `AVG()` example

```sql
SELECT
    brand_name,
    AVG (list_price) AS avg_price
FROM production.products p INNER JOIN production.brands b 
    ON b.brand_id = p.brand_id
WHERE model_year = 2018
GROUP BY brand_name
ORDER BY brand_name;
```

### Using `GROUP BY` with `SUM()` example

```sql
SELECT
    order_id,
    SUM (quantity * list_price * (1 - discount)) AS net_value
FROM sales.order_items
GROUP BY order_id;
```

### Example Using Multiple Aggregate Functions

```sql
SELECT
    customer_id,
    YEAR (order_date) AS order_year,
    COUNT (order_id) AS order_placed,
FROM sales.orders
WHERE customer_id IN (1, 2)
GROUP BY
    customer_id,
    YEAR (order_date)
ORDER BY customer_id;
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
