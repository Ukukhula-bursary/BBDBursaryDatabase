/****** Object:  StoredProcedure [dbo].[InsertNewAllocation]    Script Date: 2024/02/22 04:46:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[InsertNewAllocation] 
    @universityID int, 
    @amount money
AS 
BEGIN 
    DECLARE @detailsID int 
    SELECT @detailsID = ID FROM BursaryDetails WHERE [Year] = YEAR(GETDATE());
    
    INSERT INTO UniversityAllocation (UniversityID, BursaryDetailsID, Amount)
    VALUES (@universityID, @detailsID, @amount);
END
