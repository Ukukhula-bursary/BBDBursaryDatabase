/****** Object:  StoredProcedure [dbo].[uspGetUniversityById]    Script Date: 2024/02/22 04:43:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[uspGetUniversityById]
  @UniversityID int
AS
SELECT University.ID, University.UniversityName
FROM University
WHERE ID = @UniversityID
