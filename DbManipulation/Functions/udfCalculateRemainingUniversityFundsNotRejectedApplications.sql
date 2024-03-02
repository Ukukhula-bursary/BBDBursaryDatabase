CREATE FUNCTION [dbo].[udfCalculateRemainingUniversityFundsNotRejectedApplications](
	@Year INT,
	@UniversityID INT
)
RETURNS MONEY 
AS
BEGIN
	DECLARE @BursaryDetailsID INT, @ReturnValue MONEY, @UniversityAllocation MONEY, @TotalAllocated MONEY;

		-- Get bursary details ID
		SET @BursaryDetailsID = (
			SELECT [BursaryDetailsID]
			FROM BursaryDetails
			WHERE [Year] = @Year);

		-- Get bursary allocated to university
		SET @UniversityAllocation = 
			(SELECT Amount 
			FROM [dbo].[UniversityAllocation]
			WHERE [UniversityID] = @UniversityID
				AND [BursaryDetailsID] = @BursaryDetailsID
			);

		-- Get total that university has allocated
		SET @TotalAllocated =
			(SELECT SUM([BursaryAmount])
			FROM [dbo].[StudentApplications]
				INNER JOIN [dbo].[Students]
				ON [dbo].[StudentApplications].[StudentID] = [dbo].[Students].[StudentID]
			WHERE NOT [StatusID] = 4
				AND [BursaryDetailsID] = @BursaryDetailsID
				AND [UniversityID] = @UniversityID);


		SET @ReturnValue = @UniversityAllocation - @TotalAllocated;
			   		 

	RETURN @ReturnValue
END;
GO
