USE BikeStores;

GO

/**
 * Create or Restore BikeStores Database
 * - Load data for Sales.Promotions
 *
 * This is used in 11-modifying-data/01-insert
 */
CREATE TABLE Sales.Promotions (
      Promotion_Id INT PRIMARY KEY IDENTITY (1, 1),
    Promotion_Name VARCHAR (255) NOT NULL,
          Discount NUMERIC (3, 2) DEFAULT 0,
      "Start_Date" DATE NOT NULL,
      Expired_Date DATE NOT NULL
);

GO

-- Turn on explicit identity insert
SET IDENTITY_INSERT Sales.Promotions ON;

INSERT INTO Sales.Promotions (
    Promotion_Id,
    Promotion_Name,
    Discount,
    Start_Date,
    Expired_Date
)
VALUES (
    4,
    '2019 Spring Promotion',
    0.25,
    '20190201',
    '20190301'
);

-- Turn off explicit identity insert
SET IDENTITY_INSERT Sales.Promotions OFF;

GO

-- Multiple inserts
INSERT INTO Sales.Promotions (
    Promotion_Name,
    Discount,
    Start_Date,
    Expired_Date
)
VALUES ('2019 Summer Promotion',0.15,'20190601','20190901'),
       ('2019 Fall Promotion',0.20,'20191001','20191101'),
       ('2019 Winter Promotion',0.25,'20191201','20200101');

GO
