CREATE FUNCTION [dbo].[udfCalculateRemainingUniversityFundsNotRejectedApplications](
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

	-- Get bursary allocated to university
	SET @UniversityAllocation = 
		(SELECT Amount 
		FROM [dbo].[UniversityAllocation]
		WHERE [UniversityID] = @UniversityID
			AND [BursaryDetailsID] = @BursaryDetailsID
		);

	IF @UniversityAllocation IS NOT NULL
	BEGIN
		SET @ReturnValue = @UniversityAllocation;



		-- Get total that university has allocated
		SET @TotalAllocated =
			(SELECT SUM([BursaryAmount])
			FROM [dbo].[StudentApplications]
				INNER JOIN [dbo].[Students]
				ON [dbo].[StudentApplications].[StudentID] = [dbo].[Students].[StudentID]
			WHERE NOT [StatusID] = 4
				AND [BursaryDetailsID] = @BursaryDetailsID
				AND [UniversityID] = @UniversityID);

		IF @TotalAllocated IS NOT NULL
		BEGIN

			SET @ReturnValue = @UniversityAllocation - @TotalAllocated;
		END
			   		 
	END
	RETURN @ReturnValue
END;
GO
