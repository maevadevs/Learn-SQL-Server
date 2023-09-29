# Recursive CTE

---

- [Format](#format)
- [Execution Order](#execution-order)
  - [Figure Explanations](#figure-explanations)
- [Examples of Recursive CTE](#examples-of-recursive-cte)

---

- CTE that references itself
- The CTE repeatedly executes, returns subsets of data, until it returns the complete result set
- Used for querying hierarchical data

## Format

- In general, it has 3 parts

Part|Description
:-|:-
*Initial Query/Anchor Member*|Returns the base result set of the CTE
*Recursive Query/Recursive Member*|References the CTE. The Recursive Member is union-ed with the Anchor Member using the `UNION ALL` operator
*Termination Condition*|Specified in the recursive member that terminates the execution of the recursive member

```sql
  WITH expression_name (column_list) AS (
           -- Anchor member
           initial_query
           UNION ALL
           -- Recursive member that references expression_name
           recursive_query
       )
-- References expression name
SELECT *
  FROM expression_name;
```

## Execution Order

1. Execute the *Anchor Member* to form the base result set $R_0$
   - Use this result for the next iteration
2. Execute the *Recursive Member* with the input result set from the previous iteration $R_{i-1}$
   - Return a sub-result set $R_i$ until the termination condition is met
3. Combine all result sets $R_0$, $R_1$,... $R_n$ using `UNION ALL` operator to produce the final result set

### Figure Explanations

<img src="../../figures/recursive-cte.png" width=60%>

## Examples of Recursive CTE

- Returns weekdays from Monday to Saturday

```sql
  WITH Cte_Numbers (n, weekday) AS (
           SELECT 0,
                  DATENAME(DW, 0)
            UNION ALL
           SELECT n + 1,
                  DATENAME(DW, n + 1)
             FROM Cte_Numbers
            WHERE n < 6
       )
SELECT weekday
  FROM Cte_Numbers;
```

- Get all subordinates of the top manager who does not have a manager (or the value in the `Manager_Id` column is `NULL`)

```sql
  WITH Cte_Org (
           Staff_Id,
           First_Name,
           Manager_Id,
           "Level"
       ) AS (
           SELECT Staff_Id,
                  First_Name,
                  Manager_Id,
                  0 AS "Level"
             FROM Sales.Staffs
            WHERE Manager_Id IS NULL
            UNION ALL
           SELECT E.Staff_Id,
                  E.First_Name,
                  E.Manager_Id,
                  ("Level" + 1) AS "Level"
             FROM Sales.Staffs AS E
            INNER JOIN Cte_Org AS O
                    ON E.Manager_Id = O.Staff_Id
       )
SELECT *
  FROM Cte_Org
 ORDER BY "Level",
          Manager_Id;
```
