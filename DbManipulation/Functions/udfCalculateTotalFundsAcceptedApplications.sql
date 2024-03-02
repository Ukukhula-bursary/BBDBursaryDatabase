CREATE FUNCTION [dbo].[udfCalculateTotalFundsAcceptedApplications](
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

		-- Get total that university has allocated
		SET @TotalAllocated =
			(SELECT SUM([BursaryAmount])
			FROM [dbo].[StudentApplications]
				INNER JOIN [dbo].[Students]
				ON [dbo].[StudentApplications].[StudentID] = [dbo].[Students].[StudentID]
			WHERE [StatusID] = 3
				AND [BursaryDetailsID] = @BursaryDetailsID
				AND [UniversityID] = @UniversityID);


		SET @ReturnValue = @TotalAllocated;
			   		 

	RETURN @ReturnValue
END;
GO
