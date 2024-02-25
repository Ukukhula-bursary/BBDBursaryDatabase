CREATE VIEW [dbo].[vOpenUniversityApplications] AS
	SELECT 
		[ua].[UniversityApplicationID]
		, [u].[UniversityName]
		, [ua].[Motivation]
		, [ua].[Date]
	FROM UniversityApplications ua
		INNER JOIN
			Universities u
		ON [ua].[UniversityID] = [u].[UniversityID]
	WHERE [ua].[StatusID] = 1;

GO