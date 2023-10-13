# SQL Server and T-SQL References

---

This is a collection of references for Microsoft SQL Server and Transact-SQL

- RDBMS developed and marketed by Microsoft
- Store and retrieve data used by other applications

1. Introduction
2. DML / DQL
3. DDL
4. Data Types
5. Constraints

---

## 1. Introduction

- [SQL Server Structure](01-introduction/00-sqlserver-structure.md)
- [Installation](01-introduction/01-installation.md)
- [Using SSMS and Default System Databases](01-introduction/02-using-ssms-and-default-sys-dbs.md)
- [Loading a Sample Database](01-introduction/03-loading-sample-db.md)

---

## 2. Data Manipulation Language (DML) / Data Querying Language (DQL)

- [About DML/DQL](02-dml-dql/readme.md)

### Querying Data

- [`SELECT`](02-dml-dql/01-querying-data/01-select.md)

### Sorting Data

- [`ORDER BY`](02-dml-dql/02-sorting-data/01-order-by.md)

### Limiting Rows

- [`OFFSET FETCH`](02-dml-dql/03-limiting-rows/01-offset-fetch.md)
- [`SELECT TOP`](02-dml-dql/03-limiting-rows/02-select-top.md)

### Filtering Data

- [`SELECT DISTINCT`](02-dml-dql/04-filtering-data/01-select-distinct.md)
- [`WHERE`](02-dml-dql/04-filtering-data/02-where.md)
- [`NULL`](02-dml-dql/04-filtering-data/03-null.md)
- [`AND`](02-dml-dql/04-filtering-data/04-and.md)
- [`OR`](02-dml-dql/04-filtering-data/05-or.md)
- [`IN`](02-dml-dql/04-filtering-data/06-in.md)
- [`BETWEEN`](02-dml-dql/04-filtering-data/07-between.md)
- [`LIKE`](02-dml-dql/04-filtering-data/08-like.md)
- [`ALIASES`](02-dml-dql/04-filtering-data/09-aliases.md)

### Joining Tables

- [Joins Overview](02-dml-dql/05-joining-tables/01-joins-overview.md)
- [`INNER JOIN`](02-dml-dql/05-joining-tables/02-inner-join.md)
- [`LEFT JOIN`](02-dml-dql/05-joining-tables/03-left-join.md)
- [`RIGHT JOIN`](02-dml-dql/05-joining-tables/04-right-join.md)
- [`FULL JOIN`](02-dml-dql/05-joining-tables/05-full-join.md)
- [`SELF JOIN`](02-dml-dql/05-joining-tables/06-self-join.md)
- [`CROSS JOIN`](02-dml-dql/05-joining-tables/07-cross-join.md)

### Grouping Data

- [`GROUP BY`](02-dml-dql/06-grouping-data/01-group-by.md)
- [`HAVING`](02-dml-dql/06-grouping-data/02-having.md)
- [`UNION ALL` and `GROUPING SET`](02-dml-dql/06-grouping-data/03-union-all-and-grouping-sets.md)
- [`CUBE`](02-dml-dql/06-grouping-data/04-cube.md)
- [`ROLLUP`](02-dml-dql/06-grouping-data/05-rollup.md)

### Subquery

- [Nested Queries](02-dml-dql/07-subquery/01-nested-queries.md)
- [Correlated Subquery](02-dml-dql/07-subquery/02-correlated-subquery.md)
- [`EXISTS`](02-dml-dql/07-subquery/03-exists.md)
- [`ANY`/`SOME`](02-dml-dql/07-subquery/04-any-some.md)
- [`ALL`](02-dml-dql/07-subquery/05-all.md)

### Set

- [`UNION` and `UNION ALL`](02-dml-dql/08-set/01-union-union-all.md)
- [`INTERSECT`](02-dml-dql/08-set/02-intersect.md)
- [`EXCEPT`](02-dml-dql/08-set/03-except.md)

### CTE

- [Common Table Expressions](02-dml-dql/09-cte/01-common-table-expressions.md)
- [Recursive CTE](02-dml-dql/09-cte/02-recursive-cte.md)

### Pivot

- [`PIVOT`](02-dml-dql/10-pivot/01-pivot.md)

### Modifying Data

- [`INSERT`](02-dml-dql/11-modifying-data/01-insert.md)
- [`INSERT INTO SELECT`](02-dml-dql/11-modifying-data/02-insert-into-select.md)
- [`UPDATE`](02-dml-dql/11-modifying-data/03-update.md)
- [`UPDATE JOIN`](02-dml-dql/11-modifying-data/04-update-join.md)
- [`DELETE`](02-dml-dql/11-modifying-data/05-delete.md)
- [`MERGE`](02-dml-dql/11-modifying-data/06-merge.md)
- [Transaction](02-dml-dql/11-modifying-data/07-transaction.md)

---

## 3. Data Definition Language (DDL)

- [About DDL](03-ddl/about.md)

### For Databases

- [`CREATE DATABASE`](03-ddl/01-database/01-create-database.md)
- [`DROP DATABASE`](03-ddl/01-database/02-drop-database.md)

### For Schemas

- [`CREATE SCHEMA`](03-ddl/02-schema/01-create-schema.md)
- [`ALTER SCHEMA`](03-ddl/02-schema/02-alter-schema.md)
- [`DROP SCHEMA`](03-ddl/02-schema/03-drop-schema.md)

### For Tables

- [`CREATE TABLE`](03-ddl/03-table/01-create-table.md)
- [`DROP TABLE`](03-ddl/03-table/02-drop-table.md)
- [`TRUNCATE TABLE`](03-ddl/03-table/03-truncate-table.md)
- [`RENAME TABLE`](03-ddl/03-table/04-rename-table.md)
- [`SELECT INTO`](03-ddl/03-table/05-select-into.md)
- [Temporary Table](03-ddl/03-table/06-temporary-table.md)

### For Columns

- [`IDENTITY`](03-ddl/04-column/01-identity-column.md)
- [`ALTER TABLE ADD Column`](03-ddl/04-column/02-alter-table-add-column.md)
- [`ALTER TABLE ALTER Column`](03-ddl/04-column/03-alter-table-alter-column.md)
- [`ALTER TABLE DROP Column`](03-ddl/04-column/04-alter-table-drop-column.md)
- [Computed Column](03-ddl/04-column/05-computed-column.md)

### For Sequences

- [`SEQUENCE`](03-ddl/05-sequence/01-sequence-object.md)
- [`CREATE SEQUENCE`](03-ddl/05-sequence/02-create-sequence.md)

### For Synonyms

- [`CREATE SYNONYM`](03-ddl/06-synonym/01-create-synonym.md)
- [`DROP SYNONYM`](03-ddl/06-synonym/02-drop-synonym.md)

---

## 4. Data Types

- [T-SQL Data Types](./04-data-types/01-tsql-data-types.md)
- [`BIT` Data Type](./04-data-types/02-bit-data-type.md)
- [Integers Data Types](./04-data-types/03-integer-data-types.md)
- [`DECIMAL`/`NUMERIC` Data Types](./04-data-types/04-decimal-numeric-data-type.md)
- [`MONEY`/`SMALLMONEY` Data Types](./04-data-types/05-money-smallmoney-data-types.md)
- [`CHAR` Data Type](./04-data-types/06-char-data-type.md)
- [`NCHAR` Data Type](./04-data-types/07-nchar-data-type.md)
- [`VARCHAR` Data Type](./04-data-types/08-varchar-data-type.md)
- [`NVARCHAR` Data Type](./04-data-types/09-nvarchar-data-type.md)
- [`DATETIME2` Data Type](./04-data-types/10-datetime2-data-type.md)
