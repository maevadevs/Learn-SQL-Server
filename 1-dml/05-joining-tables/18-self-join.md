# Self Join

- Useful to query hierarchical data and compare rows within the same table
- Allows to join a table to itself
- Uses the `INNER JOIN` or `LEFT JOIN` clause
- Table alias is used to assign different names to the same table within the query
  - Referencing the same table name more than one in a query without using table aliases will result in an error

## Format

```sql
SELECT select_list
FROM T AS t1 [INNER | LEFT] JOIN T AS t2 
  ON join_predicate
```

## Example of Self Join

### Querying Hierarchical Data

We can query on an `Employees` table that has `reporting_to` column that contains employees ID

```sql
SELECT
  e.last_name + ', ' + e.first_name AS employee,
  m.Last_name + ', ' + m.first_name AS manager
FROM sales.staffs AS e INNER JOIN sales.staffs AS m 
  ON m.staff_id = e.manager_id
ORDER BY manager
```

We can use either `INNER JOIN`, `LEFT JOIN`, `RIGHT JOIN`, or `FULL JOIN`

```sql
SELECT
  e.last_name + ', ' + e.first_name AS employee,
  m.Last_name + ', ' + m.first_name AS manager
FROM sales.staffs AS e LEFT JOIN sales.staffs AS m 
  ON m.staff_id = e.manager_id
ORDER BY manager
```

### Comparing Rows Within Table

Find the customers who live in the same city

```sql
SELECT
  c1.city,
  c1.state,
  c1.zip_code,
  c1.first_name + ' ' + c1.last_name AS customer_1,
  c2.first_name + ' ' + c2.last_name AS customer_2
FROM sales.customers AS c1 INNER JOIN sales.customers AS c2 
  ON c1.customer_id <> c2.customer_id -- don't compare the same customer: Or use > for less duplicates
  AND c1.city = c2.city
  AND c1.state = c2.state
  AND c1.zip_code = c2.zip_code
ORDER BY
  city,
  customer_1,
  customer_2
```
