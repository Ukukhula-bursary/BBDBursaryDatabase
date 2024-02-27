CREATE FUNCTION dbo.udfGetTotalSpentByUniversityByYear(@targetYear INT, @universityID INT) RETURNS MONEY AS BEGIN DECLARE @totalAmount MONEY -- Calculate the total spent for the specified year and university
SELECT
  @totalAmount = COALESCE(SUM(StudentAllocationAlias.Amount), 0)
FROM
  StudentAllocation AS StudentAllocationAlias
  JOIN Student AS StudentAlias ON StudentAllocationAlias.StudentID = StudentAlias.ID
  JOIN StudentApplication AS StudentApplicationAlias ON StudentAlias.ID = StudentApplicationAlias.StudentID
WHERE
  StudentAllocationAlias.[Year] = YEAR(@targetYear)
  AND StudentAlias.UniversityID = @universityID
  AND StudentApplicationAlias.Status = 'APPROVED' RETURN @totalAmount
END;