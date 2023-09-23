# Self Join

---

- [Format](#format)
- [Example of Self Join](#example-of-self-join)
  - [Querying Hierarchical Data](#querying-hierarchical-data)
  - [Comparing Rows Within Table](#comparing-rows-within-table)

---

- Allows to join a table to itself
- Useful to query hierarchical data and compare rows within the same table
- Uses any of the 4 main join clauses
- Table alias is used to assign different names to the same table within the query
  - **Referencing the same table name more than once in a query without using table aliases will result in an error**
- Just think of the second alias as a different, separate table

## Format

```sql
SELECT select_list
  FROM T AS t1
  [INNER|LEFT|RIGHT|FULL] JOIN T AS t2
        ON join_predicate;
```

## Example of Self Join

### Querying Hierarchical Data

- We can query on an `Employees` table that has `Manager` column that contains the Employees_Id of the employee's manager

```sql
SELECT Emp.Last_Name + ', ' + Emp.First_Name AS Employee,
       Mgr.Last_name + ', ' + Mgr.First_Name AS Manager
  FROM Sales.Staffs AS Emp
       JOIN Sales.Staffs AS Mgr
         ON Emp.Manager_Id = Mgr.Staff_Id
 ORDER BY Manager;
```

- We can use either:
  - `INNER JOIN`,
  - `LEFT JOIN`,
  - `RIGHT JOIN`,
  - `FULL JOIN`

```sql
SELECT Emp.Last_Name + ', ' + Emp.First_Name AS Employee,
       Mgr.Last_name + ', ' + Mgr.First_Name AS Manager
  FROM Sales.Staffs AS Emp
  FULL JOIN Sales.Staffs AS Mgr
         ON Emp.Manager_Id = Mgr.Staff_Id
 ORDER BY Manager;
```

### Comparing Rows Within Table

- Find the customers who live in the same city

```sql
SELECT C1.City,
       C1.State,
       C1.Zip_Code,
       C1.First_Name + ' ' + C1.Last_Name AS Customer_1,
       C2.First_Name + ' ' + C2.Last_Name AS Customer_2
  FROM Sales.Customers AS C1
       JOIN Sales.Customers AS C2
         ON C1.Customer_Id <> C2.Customer_Id -- Don't compare the same customer: Or use > for less duplicates
        AND C1.City = C2.City
        AND C1.State = C2.State
        AND C1.Zip_Code = C2.Zip_Code
 ORDER BY City,
          Customer_1,
          Customer_2;
```
