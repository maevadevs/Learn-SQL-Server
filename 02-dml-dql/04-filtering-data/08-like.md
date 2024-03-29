# `LIKE`

---

- [Wildcard Characters](#wildcard-characters)
- [Escape Characters](#escape-characters)
- [Example `LIKE`](#example-like)

---

- A logical operator that determines if a character string matches a specified pattern
- To filter rows with `WHERE` based on pattern matching
- **SQL Server does not support RegEx but we can use `LIKE` for partial support instead**
- More flexible than the string comparison equal `=` and not equal `!=` operators
- Returns `TRUE` if the column or expression matches the specified pattern
- We can negate using `NOT LIKE`

```sql
column|expression LIKE pattern [ESCAPE escape_character]
```

## Wildcard Characters

Placeholder|Description
:-|:-
`%`|A string of zero or more characters
`_`|A single characters
`[charRange]`|Any single character within a specified range. The characters within the square brackets are used for the matching process
`[^charRange]`|None of the single characters within the specified range
`[char-char]`|A specific range of characters

## Escape Characters

- To treat the wildcard characters as regular characters
- We can only escape one character at a time
- **We use the `ESCAPE` clause for this**
  - We specify which character to use as the escape character

```sql
LIKE '%30\%%' ESCAPE '\' -- Specifying wildcards around "30%"
```

## Example `LIKE`

- Using the `%` wildcard

```sql
SELECT Customer_Id,
       First_Name,
       Last_Name
  FROM Sales.Customers
 WHERE Last_Name LIKE 't%s'
 ORDER BY First_Name;
```

- Using the `_` wildcard

```sql
SELECT Customer_Id,
       First_Name,
       Last_Name
  FROM Sales.Customers
 WHERE Last_Name LIKE '_u%'
 ORDER BY First_Name;
```

- Using a list of characters

```sql
SELECT Customer_Id,
       First_Name,
       Last_Name
  FROM Sales.Customers
 WHERE Last_Name LIKE '[YZ]%' -- Last name starts with Y or Z
 ORDER BY Last_Name;
```

- Using a range of characters

```sql
SELECT Customer_Id,
       First_Name,
       Last_Name
  FROM Sales.Customers
 WHERE Last_Name LIKE '[A-C]%' -- Last name starts with A, B, or C
 ORDER BY First_Name;
```

- Using the NOT wildcard (`^`)

```sql
SELECT Customer_Id,
       First_Name,
       Last_Name
  FROM Sales.Customers
 WHERE Last_Name LIKE '[^A-X]%' -- Last name not starting with A-X
 ORDER BY Last_Name;
```

- Using the `NOT LIKE` operator for getting the equivalent set

```sql
SELECT Customer_Id,
       First_Name,
       Last_Name
  FROM Sales.Customers
 WHERE Last_Name NOT LIKE '[A-X]%' -- Last name not starting with A
 ORDER BY Last_Name;
```

- Using escape characters

```sql
SELECT Feedback_Id,
       Comment
  FROM Sales.Feedbacks
 WHERE Comment LIKE '%30\%%' ESCAPE '\';
```

- Specified that the character `\` is the escape character
  - This can be any other character as well
  - Treat the next `%` character as a literal string instead of a wildcard
