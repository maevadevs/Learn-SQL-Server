USE BikeStores;

GO

/**
 * Create or Restore BikeStores Database
 * - Load data for Feedback-related Tables
 */
-- Values for Feedback
INSERT INTO Sales.Feedbacks (Comment)
VALUES ('Can you give me 30% discount?'),
       ('May I get me 30USD off?'),
       ('Is this having 20% discount today?');
