/****** Object:  StoredProcedure [dbo].[UpdateAllUniversityAllocations]    Script Date: 2024/02/22 04:47:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[UpdateAllUniversityAllocations]
    @Amount DECIMAL
AS
BEGIN
    UPDATE UniversityAllocation 
    SET Amount = @Amount
    WHERE UniversityID IN (
        SELECT ua.UniversityID 
        FROM UniversityApplication ua 
        WHERE ua.Status = 'Approved'
    );
END;