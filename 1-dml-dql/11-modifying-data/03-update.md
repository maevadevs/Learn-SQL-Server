# `UPDATE`

Allows to modify/change/update existing data in tables

1. Specify the name of the table from which the data is to be updated
1. Specify a list of columns and their new values to be updated
1. Specify the conditions in the `WHERE` clause for selecting the rows that are to be updated

**Note: The `WHERE` clause is optional. However, if the `WHERE` clause is skipped, all rows in the table are updated and overwritten**

```sql
UPDATE Schema.Name.Table_Name
SET 
    Column_1 = Value_1, 
    Column_2 = Value_2, 
    ... 
    Column_N = Value_N
[WHERE condition];
```

## Examples of `UPDATE`

Let's create a new table for demonstration

```sql
CREATE TABLE Sales.Taxes (
	Tax_Id INT PRIMARY KEY IDENTITY (1, 1),
	State VARCHAR (50) NOT NULL UNIQUE,
	State_Tax_Rate DEC (3, 2),
	Avg_Local_Tax_Rate DEC (3, 2),
	Combined_Rate AS State_Tax_Rate + Avg_Local_Tax_Rate,
	Max_Local_Tax_Rate DEC (3, 2),
	Updated_At datetime
);
```

And populate the table with some data

```sql
INSERT INTO Sales.Taxes(State,State_Tax_Rate,Avg_Local_Tax_Rate,Max_Local_Tax_Rate) VALUES('Alabama',0.04,0.05,0.07);
INSERT INTO Sales.Taxes(State,State_Tax_Rate,Avg_Local_Tax_Rate,Max_Local_Tax_Rate) VALUES('Alaska',0,0.01,0.07);
INSERT INTO Sales.Taxes(State,State_Tax_Rate,Avg_Local_Tax_Rate,Max_Local_Tax_Rate) VALUES('Arizona',0.05,0.02,0.05);
INSERT INTO Sales.Taxes(State,State_Tax_Rate,Avg_Local_Tax_Rate,Max_Local_Tax_Rate) VALUES('Arkansas',0.06,0.02,0.05);
INSERT INTO Sales.Taxes(State,State_Tax_Rate,Avg_Local_Tax_Rate,Max_Local_Tax_Rate) VALUES('California',0.07,0.01,0.02);
INSERT INTO Sales.Taxes(State,State_Tax_Rate,Avg_Local_Tax_Rate,Max_Local_Tax_Rate) VALUES('Colorado',0.02,0.04,0.08);
INSERT INTO Sales.Taxes(State,State_Tax_Rate,Avg_Local_Tax_Rate,Max_Local_Tax_Rate) VALUES('Connecticut',0.06,0,0);
INSERT INTO Sales.Taxes(State,State_Tax_Rate,Avg_Local_Tax_Rate,Max_Local_Tax_Rate) VALUES('Delaware',0,0,0);
INSERT INTO Sales.Taxes(State,State_Tax_Rate,Avg_Local_Tax_Rate,Max_Local_Tax_Rate) VALUES('Florida',0.06,0,0.02);
INSERT INTO Sales.Taxes(State,State_Tax_Rate,Avg_Local_Tax_Rate,Max_Local_Tax_Rate) VALUES('Georgia',0.04,0.03,0.04);
INSERT INTO Sales.Taxes(State,State_Tax_Rate,Avg_Local_Tax_Rate,Max_Local_Tax_Rate) VALUES('Hawaii',0.04,0,0);
INSERT INTO Sales.Taxes(State,State_Tax_Rate,Avg_Local_Tax_Rate,Max_Local_Tax_Rate) VALUES('Idaho',0.06,0,0.03);
INSERT INTO Sales.Taxes(State,State_Tax_Rate,Avg_Local_Tax_Rate,Max_Local_Tax_Rate) VALUES('Illinois',0.06,0.02,0.04);
INSERT INTO Sales.Taxes(State,State_Tax_Rate,Avg_Local_Tax_Rate,Max_Local_Tax_Rate) VALUES('Indiana',0.07,0,0);
INSERT INTO Sales.Taxes(State,State_Tax_Rate,Avg_Local_Tax_Rate,Max_Local_Tax_Rate) VALUES('Iowa',0.06,0,0.01);
INSERT INTO Sales.Taxes(State,State_Tax_Rate,Avg_Local_Tax_Rate,Max_Local_Tax_Rate) VALUES('Kansas',0.06,0.02,0.04);
INSERT INTO Sales.Taxes(State,State_Tax_Rate,Avg_Local_Tax_Rate,Max_Local_Tax_Rate) VALUES('Kentucky',0.06,0,0);
INSERT INTO Sales.Taxes(State,State_Tax_Rate,Avg_Local_Tax_Rate,Max_Local_Tax_Rate) VALUES('Louisiana',0.05,0.04,0.07);
INSERT INTO Sales.Taxes(State,State_Tax_Rate,Avg_Local_Tax_Rate,Max_Local_Tax_Rate) VALUES('Maine',0.05,0,0);
INSERT INTO Sales.Taxes(State,State_Tax_Rate,Avg_Local_Tax_Rate,Max_Local_Tax_Rate) VALUES('Maryland',0.06,0,0);
INSERT INTO Sales.Taxes(State,State_Tax_Rate,Avg_Local_Tax_Rate,Max_Local_Tax_Rate) VALUES('Massachusetts',0.06,0,0);
INSERT INTO Sales.Taxes(State,State_Tax_Rate,Avg_Local_Tax_Rate,Max_Local_Tax_Rate) VALUES('Michigan',0.06,0,0);
INSERT INTO Sales.Taxes(State,State_Tax_Rate,Avg_Local_Tax_Rate,Max_Local_Tax_Rate) VALUES('Minnesota',0.06,0,0.01);
INSERT INTO Sales.Taxes(State,State_Tax_Rate,Avg_Local_Tax_Rate,Max_Local_Tax_Rate) VALUES('Mississippi',0.07,0,0.01);
INSERT INTO Sales.Taxes(State,State_Tax_Rate,Avg_Local_Tax_Rate,Max_Local_Tax_Rate) VALUES('Missouri',0.04,0.03,0.05);
INSERT INTO Sales.Taxes(State,State_Tax_Rate,Avg_Local_Tax_Rate,Max_Local_Tax_Rate) VALUES('Montana',0,0,0);
INSERT INTO Sales.Taxes(State,State_Tax_Rate,Avg_Local_Tax_Rate,Max_Local_Tax_Rate) VALUES('Nebraska',0.05,0.01,0.02);
INSERT INTO Sales.Taxes(State,State_Tax_Rate,Avg_Local_Tax_Rate,Max_Local_Tax_Rate) VALUES('Nevada',0.06,0.01,0.01);
INSERT INTO Sales.Taxes(State,State_Tax_Rate,Avg_Local_Tax_Rate,Max_Local_Tax_Rate) VALUES('New Hampshire',0,0,0);
INSERT INTO Sales.Taxes(State,State_Tax_Rate,Avg_Local_Tax_Rate,Max_Local_Tax_Rate) VALUES('New Jersey',0.06,0,0);
INSERT INTO Sales.Taxes(State,State_Tax_Rate,Avg_Local_Tax_Rate,Max_Local_Tax_Rate) VALUES('New Mexico',0.05,0.02,0.03);
INSERT INTO Sales.Taxes(State,State_Tax_Rate,Avg_Local_Tax_Rate,Max_Local_Tax_Rate) VALUES('New York',0.04,0.04,0.04);
INSERT INTO Sales.Taxes(State,State_Tax_Rate,Avg_Local_Tax_Rate,Max_Local_Tax_Rate) VALUES('North Carolina',0.04,0.02,0.02);
INSERT INTO Sales.Taxes(State,State_Tax_Rate,Avg_Local_Tax_Rate,Max_Local_Tax_Rate) VALUES('North Dakota',0.05,0.01,0.03);
INSERT INTO Sales.Taxes(State,State_Tax_Rate,Avg_Local_Tax_Rate,Max_Local_Tax_Rate) VALUES('Ohio',0.05,0.01,0.02);
INSERT INTO Sales.Taxes(State,State_Tax_Rate,Avg_Local_Tax_Rate,Max_Local_Tax_Rate) VALUES('Oklahoma',0.04,0.04,0.06);
INSERT INTO Sales.Taxes(State,State_Tax_Rate,Avg_Local_Tax_Rate,Max_Local_Tax_Rate) VALUES('Oregon',0,0,0);
INSERT INTO Sales.Taxes(State,State_Tax_Rate,Avg_Local_Tax_Rate,Max_Local_Tax_Rate) VALUES('Pennsylvania',0.06,0,0.02);
INSERT INTO Sales.Taxes(State,State_Tax_Rate,Avg_Local_Tax_Rate,Max_Local_Tax_Rate) VALUES('Rhode Island',0.07,0,0);
INSERT INTO Sales.Taxes(State,State_Tax_Rate,Avg_Local_Tax_Rate,Max_Local_Tax_Rate) VALUES('South Carolina',0.06,0.01,0.02);
INSERT INTO Sales.Taxes(State,State_Tax_Rate,Avg_Local_Tax_Rate,Max_Local_Tax_Rate) VALUES('South Dakota',0.04,0.01,0.04);
INSERT INTO Sales.Taxes(State,State_Tax_Rate,Avg_Local_Tax_Rate,Max_Local_Tax_Rate) VALUES('Tennessee',0.07,0.02,0.02);
INSERT INTO Sales.Taxes(State,State_Tax_Rate,Avg_Local_Tax_Rate,Max_Local_Tax_Rate) VALUES('Texas',0.06,0.01,0.02);
INSERT INTO Sales.Taxes(State,State_Tax_Rate,Avg_Local_Tax_Rate,Max_Local_Tax_Rate) VALUES('Utah',0.05,0,0.02);
INSERT INTO Sales.Taxes(State,State_Tax_Rate,Avg_Local_Tax_Rate,Max_Local_Tax_Rate) VALUES('Vermont',0.06,0,0.01);
INSERT INTO Sales.Taxes(State,State_Tax_Rate,Avg_Local_Tax_Rate,Max_Local_Tax_Rate) VALUES('Virginia',0.05,0,0);
INSERT INTO Sales.Taxes(State,State_Tax_Rate,Avg_Local_Tax_Rate,Max_Local_Tax_Rate) VALUES('Washington',0.06,0.02,0.03);
INSERT INTO Sales.Taxes(State,State_Tax_Rate,Avg_Local_Tax_Rate,Max_Local_Tax_Rate) VALUES('West Virginia',0.06,0,0.01);
INSERT INTO Sales.Taxes(State,State_Tax_Rate,Avg_Local_Tax_Rate,Max_Local_Tax_Rate) VALUES('Wisconsin',0.05,0,0.01);
INSERT INTO Sales.Taxes(State,State_Tax_Rate,Avg_Local_Tax_Rate,Max_Local_Tax_Rate) VALUES('Wyoming',0.04,0.01,0.02);
INSERT INTO Sales.Taxes(State,State_Tax_Rate,Avg_Local_Tax_Rate,Max_Local_Tax_Rate) VALUES('D.C.',0.05,0,0);
```

### Update a Single Column For All Rows

When we do not apply `WHERE` conditions, the update applies to all the rows

```sql
UPDATE Sales.Taxes
SET updated_at = GETDATE();
```

### Update Multiple Columns

Increase the max local tax rate by 2% and the average local tax rate by 1% for states that have max local tax rate of 1%

```sql
UPDATE Sales.Taxes
SET 
	Max_Local_Tax_Rate += 0.02,
    Avg_Local_Tax_Rate += 0.01
WHERE
    Max_Local_Tax_Rate = 0.01;
```

