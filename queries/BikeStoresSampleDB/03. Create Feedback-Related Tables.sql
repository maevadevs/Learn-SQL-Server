USE BikeStores;

GO

/**
 * Create or Restore BikeStores Database
 * - Create and load data for feedback-related Tables
 */

-- CREATE TABLES --
-------------------

CREATE TABLE Sales.Feedbacks (
    Feedback_Id INT IDENTITY(1, 1) PRIMARY KEY,
        Comment VARCHAR(255) NOT NULL
);

GO
