# SQL Server References

This is a sumary of references for SQL Server from the [SQL Server Tutorial](https://www.sqlservertutorial.net/).

SQL commands are mainly categorized into 5 categories:

- DML
- DQL
- DDL
- DCL
- TCL

## DML - Data Manipulation Language

DML is made of the SQL commands that deals with the manipulation of data present in the database. This includes most of the SQL statements.

## DQL - Data Querying Language

To an extent, we could also include DQL as part of DML. DML statements are used for performing queries on the data within schema objects. The purpose of DQL Command is to get some schema relation based on the query passed to it.

## DDL - Data Definition Language

DDL consists of the SQL commands that can be used to define the database schema. It simply deals with descriptions of the database schema and is used to create and modify the structure of database objects in the database.

## DCL - Data Control Language

DCL includes commands which mainly deals with the rights, permissions, and other controls of the database system.

## TCL - Transaction Control Language

These commands are used for maintaining consistency of the database and for the management of transactions made by the DML commands.

A Transaction is a set of SQL statements that are executed on the data stored in DBMS. Whenever any transaction is made these transactions are temporarily happen in database. So to make the changes permanent, we use TCL commands.

## MS Transact-SQL

On top of those 5 categories, MS SQL Server uses Transact-SQL dialects which is a language extension by Microsoft. Transact-SQL makes SQL Server use a turing-complete programming language instead of the non-turing-complete ANSI/ISO SQL.

## Organization

- Introduction
  - SQL Server Structure
  - Installation
  - Using SSMS and Default System Databases
  - Loading a Sample Database
- DML
  - Querying Data
    - `SELECT`
  - Sorting Data
    - `ORDER BY`
  - Limiting Rows
    - `OFFSET FETCH`
    - `SELECT TOP`
  - Filtering Data
    - `SELECT DISTINCT`
    - `WHERE`
    - `NULL`
    - `AND`
    - `OR`
    - `IN`
    - `BETWEEN`
    - `LIKE`
    - `ALIASES`
  - Joining Tables
    - Joins Overview
    - `INNER JOIN`
    - `LEFT JOIN`
    - `RIGHT JOIN`
    - `FULL JOIN`
    - `SELF JOIN`
    - `CROSS JOIN`
  - Grouping Data
    - `GROUP BY`
    - `HAVING`
    - `UNION ALL` and `GROUPING SET`
    - `CUBE`
    - `ROLLUP`
  - Subquery
    - Nested Queries
    - Correlated Subquery
    - `EXISTS`
    - `ANY`/`SOME`
    - `ALL`
