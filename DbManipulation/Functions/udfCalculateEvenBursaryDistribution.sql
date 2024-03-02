CREATE FUNCTION [dbo].[udfCalculateEvenBursaryDistributionActiveUniversities](
	@BursaryDetailsID INT	
)
RETURNS MONEY 
AS
BEGIN
	DECLARE @ReturnValue MONEY, @NumberOfApprovedUniversities INT, @YearlyAllocation MONEY;

		-- Get all active universities
		SET @NumberOfApprovedUniversities = 
			(SELECT COUNT([UniversityID])
			FROM [dbo].[Universities]
			WHERE IsActiveRecipient = 1);

		-- Get yearly allocation
		SET @YearlyAllocation = 
			(SELECT [TotalAmount] 
			FROM [dbo].[BursaryDetails]
			WHERE [BursaryDetailsID] = @BursaryDetailsID);

		-- Get UniversityDistribution
		SET @ReturnValue = @YearlyAllocation / @NumberOfApprovedUniversities;

		SET @ReturnValue = ROUND(@ReturnValue, 2, 1);




	RETURN @ReturnValue
END;
GO
