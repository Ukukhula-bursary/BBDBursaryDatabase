DECLARE @result MONEY

SET @result = dbo.udfGetTotalSpentByUniversityByYear(2024, 1)

PRINT 'Total Spent: ' + CAST(@result AS VARCHAR)