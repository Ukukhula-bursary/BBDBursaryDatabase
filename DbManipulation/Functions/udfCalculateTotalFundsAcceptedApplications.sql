CREATE FUNCTION [dbo].[udfCalculateTotalFundsAcceptedApplications](
	@Year INT,
	@UniversityID INT
)
RETURNS MONEY 
AS
BEGIN
	DECLARE @BursaryDetailsID INT, @ReturnValue MONEY, @UniversityAllocation MONEY, @TotalAllocated MONEY;

	SET @ReturnValue = 0;

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

	IF @TotalAllocated IS NOT NULL
	BEGIN
		SET @ReturnValue = @TotalAllocated;
	END
			   		 

	RETURN @ReturnValue
END;
GO
