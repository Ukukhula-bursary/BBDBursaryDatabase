/****** Object:  StoredProcedure [dbo].[CalculateTotalAllocationForYear]    Script Date: 2024/02/22 04:46:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER   PROCEDURE [dbo].[CalculateTotalAllocationForYear]
    @Year INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        SUM(ua.Amount) AS TotalAllocation
    FROM 
        [dbo].[UniversityAllocation] ua
    INNER JOIN 
        [dbo].[BursaryDetails] bd ON ua.BursaryDetailsID = bd.ID
    WHERE 
        bd.[Year] = @Year;

END