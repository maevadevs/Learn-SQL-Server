# Joins Overview

- In RDBMS, data are distributed across multiple logical tables
- For a complete set of data, we need to query multiple tables and join them together

## Inner Join Overview

- Join two tables on a column
- Only includes rows from the left table which have matching rows from the right table

```sql
SELECT t1.col1, t1.col2, t2.col1, t2.col2
FROM table1 AS t1 INNER JOIN table2 AS t2
ON t1.col1 = t2.col2;
```

### Inner Join Example

```sql
SELECT  
    c.id AS candidate_id, 
    c.fullname AS candidate_name,
    e.id AS employee_id,
    e.fullname AS employee_name
FROM hr.candidates c INNER JOIN hr.employees e 
ON e.fullname = c.fullname;
```

### Inner Join Example Venn Diagram

<img src="../../figures/venn-diagram-inner-join.png">

## Left Join / Left Outer Join Overview

- Join two tables on a column
- Include everything from the left table
- Only includes rows from the right table which have matching rows from the left table
- If a row in the left table does not have a matching row in the right table, the columns of the right table will have `NULL`

```sql
SELECT t1.col1, t1.col2, t2.col1, t2.col2
FROM table1 AS t1 LEFT JOIN table2 AS t2
ON t1.col1 = t2.col2;
```

### Left Join Example

```sql
SELECT  
    c.id AS candidate_id, 
    c.fullname AS candidate_name,
    e.id AS employee_id,
    e.fullname AS employee_name
FROM hr.candidates c LEFT JOIN hr.employees e 
ON e.fullname = c.fullname;
```

### Left Join Example Venn Diagram

<img src="../../figures/venn-diagram-left-join.png">

### Exclusive Left Join

- We can get row only in the left table but not in the right table by applying a `WHERE` condition with `NULL`

```sql
SELECT  
    c.id AS candidate_id, 
    c.fullname AS candidate_name,
    e.id AS employee_id,
    e.fullname AS employee_name
FROM hr.candidates c LEFT JOIN hr.employees e 
ON e.fullname = c.fullname
WHERE e.id IS NULL;
```

### Exclusive Left Join Example Venn Diagram

<img src="../../figures/venn-diagram-exclusive-left-join.png">

## Right Join / Right Outer Join Overview

- Join two tables on a column
- Include everything from the right table
- Only includes rows from the left table which have matching rows from the right table
- If a row in the right table does not have a matching row in the left table, the columns of the left table will have `NULL`
- **Right join is the same as left join with swapped table order**

```sql
SELECT t1.col1, t1.col2, t2.col1, t2.col2
FROM table1 AS t1 RIGHT JOIN table2 AS t2
ON t1.col1 = t2.col2;
```

### Right Join Example

```sql
SELECT  
    c.id AS candidate_id, 
    c.fullname AS candidate_name,
    e.id AS employee_id,
    e.fullname AS employee_name
FROM hr.candidates c RIGHT JOIN hr.employees e 
ON e.fullname = c.fullname;
```

### Right Join Example Venn Diagram

<img src="../../figures/venn-diagram-right-join.png">

### Exclusive Right Join

- We can get row only in the Right table but not in the left table by applying a `WHERE` condition with `NULL`

```sql
SELECT  
    c.id AS candidate_id, 
    c.fullname AS candidate_name,
    e.id AS employee_id,
    e.fullname AS employee_name
FROM hr.candidates c RIGHT JOIN hr.employees e 
ON e.fullname = c.fullname
WHERE c.id IS NULL;
```

### Exclusive Right Join Example Venn Diagram

<img src="../../figures/venn-diagram-exclusive-right-join.png">

## Full Join / Full Outer Join Overview

- Join two tables on a column
- Include everything from both table
- If a row in the right table does not have a matching row in the left table, the columns of the left table will have `NULL`
- If a row in the left table does not have a matching row in the right table, the columns of the right table will have `NULL`

```sql
SELECT t1.col1, t1.col2, t2.col1, t2.col2
FROM table1 AS t1 FULL JOIN table2 AS t2
ON t1.col1 = t2.col2;
```

### Full Join Example

```sql
SELECT  
    c.id AS candidate_id, 
    c.fullname AS candidate_name,
    e.id AS employee_id,
    e.fullname AS employee_name
FROM hr.candidates c FULL JOIN hr.employees e 
ON e.fullname = c.fullname;
```

### Full Join Example Venn Diagram

<img src="../../figures/venn-diagram-full-join.png">

### Exclusive Full Join

- We can get row only in either the Left or Right table but not in the intersection by applying a `WHERE` condition with `NULL`

```sql
SELECT  
    c.id AS candidate_id, 
    c.fullname AS candidate_name,
    e.id AS employee_id,
    e.fullname AS employee_name
FROM hr.candidates c FULL JOIN hr.employees e 
ON e.fullname = c.fullname
WHERE c.id IS NULL OR e.id IS NULL;
```

### Exclusive Full Join Example Venn Diagram

<img src="../../figures/venn-diagram-exclusive-full-join.png">
