# `UPDATE JOIN`

Allows to update values in a table based on values from another table using `JOIN` clauses. I.e. a cross-table update.

- We use joins to query data from related tables
- We can also use joins to perform cross-table updates

```sql
UPDATE Schema_Name.Table_Name_1
SET 
    Table_Name_1.Column_1 = Table_Name_2.Column_2,
    Table_Name_1.Column_2 = expression,
    ...   
FROM Table_Name_1 
[INNER | LEFT] JOIN Table_Name_2 
    ON join_predicate
WHERE condition_predicate;
```

## Examples of `UPDATE JOIN`

Let's create a new table for demonstration

```sql
--If exist, drop before re-create
DROP TABLE IF EXISTS Sales.Targets;

--Create/Re-create the table
CREATE TABLE Sales.Targets
(
    Target_Id INT PRIMARY KEY, 
    Percentage DECIMAL(4, 2) NOT NULL DEFAULT 0
);

--Insert values into the table
INSERT INTO Sales.Targets(
    Target_Id, 
    Percentage
)
VALUES
    (1,0.2),
    (2,0.3),
    (3,0.5),
    (4,0.6),
    (5,0.8);
```

```sql
--Create the Commissions table
CREATE TABLE Sales.Commissions
(
    Staff_Id INT PRIMARY KEY, 
    Target_Id INT, 
    Base_Amount DECIMAL(10, 2) NOT NULL DEFAULT 0, 
    Commission DECIMAL(10, 2) NOT NULL DEFAULT 0, 
    FOREIGN KEY(Target_Id) REFERENCES Sales.Targets(Target_Id), 
    FOREIGN KEY(Staff_Id) REFERENCES Sales.Staffs(Staff_Id),
);

--Insert values into Commissions
INSERT INTO Sales.Commissions(
    Staff_Id, 
    Base_Amount, 
    Target_Id
)
VALUES
    (1,100000,2),
    (2,120000,1),
    (3,80000,3),
    (4,900000,4),
    (5,950000,5);
```

### `UPDATE INNER JOIN`

```sql
--Update the values of the Commission column in Sales.Commissions
UPDATE Sales.Commissions
SET Sales.Commissions.Commission = C.Base_Amount * T.Percentage
FROM Sales.Commissions AS C
INNER JOIN Sales.Targets AS T
    ON C.Target_Id = T.Target_Id;
```

### `UPDATE LEFT JOIN`

We have two more new sales staffs that have just joined and they do not have any target yet

```sql
INSERT INTO Sales.Commissions
(
    Staff_Id, 
    Base_Amount, 
    Target_Id
)
VALUES
    (6,100000,NULL),
    (7,120000,NULL);
```

We assume that the commission for the new sales staffs is 0.1 or 10%
- We can use `COALESCE()` to return `0.1` if the percentage is `NULL`

```sql
UPDATE Sales.Commissions
SET  
    Sales.Commissions.Commission = C.Base_Amount * COALESCE(T.Percentage, 0.1)
FROM Sales.Commissions AS C
LEFT JOIN Sales.Targets AS T 
    ON C.Target_Id = T.Target_Id;
```