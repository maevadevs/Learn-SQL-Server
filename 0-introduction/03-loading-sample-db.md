# Loading Sample Database

Here is the sample `BikeStores` database that we will load into our SQL Server instance. 

**Restoration steps are available in [`queries/bikestores-sample-db`](../queries/BikeStoresSampleDB/)**

- 2 schemas
- 9 tables

<img src="../figures/bikestore-db-model.png" width=60%>

## DB Tables

### `Sales.Stores`

Contains the store information

- **A store employs staff (1-to-many)**
  - A store can employ many staff
  - A staff can only works for one store
- **A store takes orders (1-to-many)**
  - A store can take many orders
  - An order can only be taken by one store
- **A store have stock inventory (1-to-1)**
  - A store can have one or no stock inventory
  - A stock inventory can only be assigned to one store

```sql
CREATE TABLE    Sales.Stores 
(
   Store_Id     INT                   IDENTITY  (1,1)
                                      PRIMARY KEY
  ,Store_Name   VARCHAR (255)         NOT NULL
  ,Phone        VARCHAR (25)
  ,Email        VARCHAR (255)
  ,Street       VARCHAR (255)
  ,City         VARCHAR (255)
  ,State        VARCHAR (10)
  ,Zip_Code     VARCHAR (5)
);
```

### `Sales.Customers`

Contains customer's information

- **A customer makes an order (1-to-many)**
  - A customer can create many order
  - An order can only be assigned to one customer

```sql
CREATE TABLE    Sales.Customers 
(
   Customer_Id  INT                   IDENTITY (1, 1)
                                      PRIMARY KEY
  ,First_Name   VARCHAR (255)         NOT NULL
  ,Last_Name    VARCHAR (255)         NOT NULL
  ,Phone        VARCHAR (25)
  ,Email        VARCHAR (255)         NOT NULL
  ,Street       VARCHAR (255)
  ,City         VARCHAR (50)
  ,State        VARCHAR (25)
  ,Zip_Code     VARCHAR (5)
);
```

### `Sales.Staffs`

Contains staff information

- **A staff works at a store (1-to-many)**
  - A staff can only works for one store
  - A store can employ many staff
- **A staff reports to a store manager (1-to-many)**
  - A staff can only report to one manager
  - A manager can oversee many staff
  - If the value in the `manager_id` is null, then the staff is the top manager
  - If a staff no longer works for any stores, the value in the active column is set to zero
- **A staff creates an order (1-to-many)**
  - A staff can create many orders
  - An order can only be created by one staff

```sql
CREATE TABLE    Sales.Staffs 
(
   Staff_Id     INT                   IDENTITY (1, 1)
                                      PRIMARY KEY
  ,First_Name   VARCHAR (50)          NOT NULL
  ,Last_Name    VARCHAR (50)          NOT NULL
  ,Email        VARCHAR (255)         NOT NULL 
                                      UNIQUE
  ,Phone        VARCHAR (25)
  ,Active       TINYINT               NOT NULL
  ,Store_Id     INT                   NOT NULL
  ,Manager_Id   INT
  ,FOREIGN KEY (Store_Id)
                REFERENCES            Sales.Stores (Store_Id)
                ON DELETE             CASCADE 
                ON UPDATE             CASCADE
  ,FOREIGN KEY (Manager_Id) 
                REFERENCES            Sales.Staffs (Staff_Id)
                ON DELETE             NO ACTION 
                ON UPDATE             NO ACTION
);
```

### `Sales.Orders`

Contains sales order's header information

- **An order is created by a staff (1-to-many)**
  - An order can only be created by one staff
  - A staff can create many orders
- **An order is created by a customer (1-to-many)**
  - An order can only be assigned to one customer
  - A customer can create many order
- **An order is handled by a store (1-to-many)**
  - An order can only be taken by one store
  - A store can take many orders
- **An order has order items (1-to-1)**
  - An order may contains an order items
  - An order item can only be assigned one order

```sql
CREATE TABLE      Sales.Orders 
(
   Order_Id       INT                     IDENTITY (1, 1) 
                                          PRIMARY KEY
  ,Customer_Id    INT
  ,Order_Status   TINYINT                 NOT NULL
  -- Order status: 
  --  1 = Pending; 
  --  2 = Processing; 
  --  3 = Rejected; 
  --  4 = Completed
  ,Order_Date     DATE                    NOT NULL
  ,Required_Date  DATE                    NOT NULL
  ,Shipped_Date   DATE
  ,Store_Id       INT                     NOT NULL
  ,Staff_Id       INT                     NOT NULL
  ,FOREIGN KEY (Customer_Id)
                  REFERENCES              Sales.Customers (Customer_Id)
                  ON DELETE               CASCADE 
                  ON UPDATE               CASCADE
  ,FOREIGN KEY (Store_Id)
                  REFERENCES              Sales.Stores (Store_Id)
                  ON DELETE               CASCADE 
                  ON UPDATE               CASCADE
  ,FOREIGN KEY (Staff_Id)
                  REFERENCES              Sales.Staffs (Staff_Id)
                  ON DELETE               NO ACTION 
                  ON UPDATE               NO ACTION
);
```

### `Sales.Order_Items`

Contains the line items of a sales order

- **An order item is assigned to an order (1-to-1)**
  - An order item can only be assigned one order
  - An order may contains an order items
- **An order item can contain products (1-to-many)**
  - An order item can only contain one product
  - A product could be assigned to many order items

```sql
CREATE TABLE      Sales.Order_Items
(
   Order_Id       INT
  ,Item_Id        INT
  ,Product_Id     INT                     NOT NULL
  ,Quantity       INT                     NOT NULL
  ,List_Price     DECIMAL (10, 2)         NOT NULL
  ,Discount       DECIMAL (4, 2)          NOT NULL DEFAULT 0
  ,PRIMARY KEY (Order_Id, Item_Id)
  ,FOREIGN KEY (Order_Id)
                  REFERENCES              Sales.Orders (Order_Id)
                  ON DELETE               CASCADE 
                  ON UPDATE               CASCADE
  ,FOREIGN KEY (Product_Id)
                  REFERENCES              Production.Products (Product_Id)
                  ON DELETE               CASCADE 
                  ON UPDATE               CASCADE
);
```

### `Production.Categories`

Contains the bike's categories

```sql
CREATE TABLE      Production.Categories 
(
   Category_Id    INT                     IDENTITY (1, 1) 
                                          PRIMARY KEY
  ,Category_Name  VARCHAR (255)           NOT NULL
);
```

### `Production.Products`

Contains the product's information

```sql
CREATE TABLE      Production.Products 
(
   Product_Id     INT                     IDENTITY (1, 1) 
                                          PRIMARY KEY
  ,Product_Name   VARCHAR (255)           NOT NULL
  ,Brand_Id       INT                     NOT NULL
  ,Category_Id    INT                     NOT NULL
  ,Model_Year     SMALLINT                NOT NULL
  ,List_Price     DECIMAL (10, 2)         NOT NULL
  ,FOREIGN KEY (Category_Id)
                  REFERENCES              Production.Categories (Category_Id)
                  ON DELETE               CASCADE 
                  ON UPDATE               CASCADE
  ,FOREIGN KEY (Brand_Id)
                  REFERENCES              Sales.Brands (Brand_Id)
                  ON DELETE               CASCADE 
                  ON UPDATE               CASCADE
);
```

### `Production.Stocks`

Contains the inventory information

```sql
CREATE TABLE      Production.Stocks 
(
   Store_Id       INT
  ,Product_Id     INT
  ,Quantity       INT
  ,PRIMARY KEY (Store_Id, Product_Id)
  ,FOREIGN KEY (Store_Id)
                  REFERENCES                Sales.Stores (Store_Id)
                  ON DELETE                 CASCADE 
                  ON UPDATE                 CASCADE
  ,FOREIGN KEY (Product_Id)
                  REFERENCES                Production.Products (Product_Id)
                  ON DELETE                 CASCADE 
                  ON UPDATE                 CASCADE
);
```

### `Production.Brands`

Contains the brand’s information of bikes

```sql
CREATE TABLE      Production.Brands 
(
   Brand_Id       INT                       IDENTITY (1, 1) 
                                            PRIMARY KEY
  ,Brand_Name     VARCHAR (255)             NOT NULL
);
```
