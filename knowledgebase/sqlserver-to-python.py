# Import Libraries
# ****************

import pandas as pd
import sqlalchemy


# Import DB Settings
# ******************

from db_settings import get_db_credentials


# Setup SQL Alchemy Engine
# ************************
# mssql+pyodbc://Username:Password@ODBCDatasource
# Set the ODBCDataSource from Windows Menu (Search: odbc data Sources (64-bit) > System DSN)

protocol, username, password, odbc_datasource = get_db_credentials()
engine = sqlalchemy.create_engine(f"{protocol}://{username}:{password}@{odbc_datasource}")


# Query from SQL Server
# *********************

q = """
SELECT TOP 5 *
FROM sales.customers
WHERE state = 'CA'
ORDER BY last_name DESC;
"""


# Fetch and Print the result of the query
# ***************************************

df = pd.read_sql(q, engine)
print(df)
