CREATE TABLE [dbo].[BursaryDetails]
(
  [ID] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
  [Year] INT NOT NULL,
  [TotalAmount] MONEY NOT NULL,
);
GO