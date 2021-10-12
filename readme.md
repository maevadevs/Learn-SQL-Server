# SQL Server and T-SQL References

This is a collection of references for Microsoft SQL Server and Transact-SQL.

## Folder Organization

Here is the folder organization of this reference:

### Introduction

- [SQL Server Structure](0-introduction/00-sqlserver-structure.md)
- [Installation](0-introduction/01-installation.md)
- [Using SSMS and Default System Databases](0-introduction/02-using-ssms-and-default-sys-dbs.md)
- [Loading a Sample Database](0-introduction/03-loading-sample-db.md)

### Data Manipulation Language (DML) / Data Querying Language (DQL)

- [About DML/DQL](1-dml-dql/about.md)

#### Querying Data

- [`SELECT`](1-dml-dql/01-querying-data/01-select.md)
  
#### Sorting Data

- [`ORDER BY`](1-dml-dql/02-sorting-data/01-order-by.md)

#### Limiting Rows

- [`OFFSET FETCH`](1-dml-dql/03-limiting-rows/01-offset-fetch.md)
- [`SELECT TOP`](1-dml-dql/03-limiting-rows/02-select-top.md)

#### Filtering Data

- [`SELECT DISTINCT`](1-dml-dql/04-filtering-data/01-select-distinct.md)
- [`WHERE`](1-dml-dql/04-filtering-data/02-where.md)
- [`NULL`](1-dml-dql/04-filtering-data/03-null.md)
- [`AND`](1-dml-dql/04-filtering-data/04-and.md)
- [`OR`](1-dml-dql/04-filtering-data/05-or.md)
- [`IN`](1-dml-dql/04-filtering-data/06-in.md)
- [`BETWEEN`](1-dml-dql/04-filtering-data/07-between.md)
- [`LIKE`](1-dml-dql/04-filtering-data/08-like.md)
- [`ALIASES`](1-dml-dql/04-filtering-data/09-aliases.md)

#### Joining Tables

- [Joins Overview](1-dml-dql/05-joining-tables/01-joins-overview.md)
- [`INNER JOIN`](1-dml-dql/05-joining-tables/02-inner-join.md)
- [`LEFT JOIN`](1-dml-dql/05-joining-tables/03-left-join.md)
- [`RIGHT JOIN`](1-dml-dql/05-joining-tables/04-right-join.md)
- [`FULL JOIN`](1-dml-dql/05-joining-tables/05-full-join.md)
- [`SELF JOIN`](1-dml-dql/05-joining-tables/06-self-join.md)
- [`CROSS JOIN`](1-dml-dql/05-joining-tables/07-cross-join.md)

#### Grouping Data

- [`GROUP BY`](1-dml-dql/06-grouping-data/01-group-by.md)
- [`HAVING`](1-dml-dql/06-grouping-data/02-having.md)
- [`UNION ALL` and `GROUPING SET`](1-dml-dql/06-grouping-data/03-union-all-and-grouping-sets.md)
- [`CUBE`](1-dml-dql/06-grouping-data/04-cube.md)
- [`ROLLUP`](1-dml-dql/06-grouping-data/05-rollup.md)

#### Subquery

- [Nested Queries](1-dml-dql/07-subquery/01-nested-queries.md)
- [Correlated Subquery](1-dml-dql/07-subquery/02-correlated-subquery.md)
- [`EXISTS`](1-dml-dql/07-subquery/03-exists.md)
- [`ANY`/`SOME`](1-dml-dql/07-subquery/04-any-some.md)
- [`ALL`](1-dml-dql/07-subquery/05-all.md)

#### Set

- [`UNION` and `UNION ALL`](1-dml-dql/08-set/01-union-union-all.md)
- [`INTERSECT`](1-dml-dql/08-set/02-intersect.md)
- [`EXCEPT`](1-dml-dql/08-set/03-except.md)

#### CTE

- [Common Table Expressions](1-dml-dql/09-cte/01-common-table-expressions.md)
- [Recursive CTE](1-dml-dql/09-cte/02-recursive-cte.md)

#### Pivot

- [`PIVOT`](1-dml-dql/10-pivot/01-pivot.md)

#### Modifying Data

- [`INSERT`](1-dml-dql/11-modifying-data/01-insert.md)
- [`INSERT INTO SELECT`](1-dml-dql/11-modifying-data/02-insert-into-select.md)
- [`UPDATE`](1-dml-dql/11-modifying-data/03-update.md)
- [`UPDATE JOIN`](1-dml-dql/11-modifying-data/04-update-join.md)
- [`DELETE`](1-dml-dql/11-modifying-data/05-delete.md)
- [`MERGE`](1-dml-dql/11-modifying-data/06-merge.md)

### Data Definition Language (DDL)

- [`CREATE DATABASE`](02-ddl/01-create-database.md)
- [`DROP DATABASE`](02-ddl/02-drop-database.md)
- [`CREATE SCHEMA`](02-ddl/03-create-schema.md)