/****** Object:  StoredProcedure [dbo].[uspAddUniversityByName]    Script Date: 2024/02/22 04:47:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[uspAddUniversityByName]
  @universityName VARCHAR(100)
AS
INSERT INTO University
  (UniversityName)
VALUES
  (@universityName)
