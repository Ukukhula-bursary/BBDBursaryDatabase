CREATE FUNCTION [dbo].[udfCalculateAge](
	@birthdate DATE
	,@date_up_to DATE
)
RETURNS INT 
AS
BEGIN
	DECLARE @return_value INT, @year_diff INT, @month_diff INT, @day_diff INT;

	SET @return_value = 0;
	SET @year_diff = 0;
	SET @month_diff = 0;
	SET @month_diff = 0;

	IF (YEAR(@birthdate) > YEAR(@date_up_to)) RETURN @return_value
	SET @year_diff = YEAR(@date_up_to) - YEAR(@birthdate)

	IF @year_diff = 0 RETURN @return_value
	SET @month_diff = MONTH(@date_up_to) - MONTH(@birthdate)

	IF (@month_diff > 0)
	SET @year_diff = @year_diff - 1

	IF @month_diff = 0
	BEGIN

		IF (DAY(@birthdate) < DAY(@date_up_to))
		SET @year_diff = @year_diff - 1

	END

	RETURN @year_diff
END;
GO
