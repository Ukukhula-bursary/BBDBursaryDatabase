/****** Object:  StoredProcedure [dbo].[uspGetTotalSpentPerYear]    Script Date: 2024/02/22 04:48:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[uspGetTotalSpentPerYear]
@BudgetID INT
AS
SELECT SUM(Amount)
	From UniversityAllocation
	WHERE BursaryDetailsID = @BudgetID;