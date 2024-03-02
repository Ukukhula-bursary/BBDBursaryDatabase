CREATE PROCEDURE [dbo].[uspEvenlyDistributeYearlyAllocation]
	@Year INT,
	@AmountPerUniversity MONEY OUTPUT
AS
BEGIN
	SET NOCOUNT ON;

	BEGIN TRY
		BEGIN TRANSACTION;

		DECLARE @BursaryDetailsID INT, @YearlyAllocation MONEY;

		SET @BursaryDetailsID = (
			SELECT [BursaryDetailsID]
			FROM BursaryDetails
			WHERE [Year] = @Year);

		EXECUTE @AmountPerUniversity = [dbo].[udfCalculateEvenBursaryDistributionActiveUniversities] 
			@BursaryDetailsID = @BursaryDetailsID;


		DECLARE
			@UniversityID INT,
			@UniversityName VARCHAR(100),
			@IsActiveRecipient BIT
		DECLARE cursor_universities 
			CURSOR FOR
			SELECT * FROM [dbo].[Universities]
			WHERE [IsActiveRecipient] = 1

		OPEN cursor_universities
		FETCH NEXT FROM cursor_universities 
			INTO @UniversityID, @UniversityName, @IsActiveRecipient
	
		WHILE @@FETCH_STATUS=0
			BEGIN
				INSERT INTO [dbo].[UniversityAllocation]( 
					[UniversityID],
					[Amount],
					[BursaryDetailsID]
				)
				VALUES(
					@UniversityID, 
					@AmountPerUniversity, 
					@BursaryDetailsID
				)

				FETCH NEXT FROM cursor_universities 
					INTO @UniversityID, @UniversityName, @IsActiveRecipient
			END
		CLOSE cursor_universities
		DEALLOCATE cursor_universities

		COMMIT;
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK;
		THROW
	END CATCH;

	SELECT @AmountPerUniversity = @AmountPerUniversity
END;
