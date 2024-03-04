CREATE VIEW StudentAllocationView AS
SELECT
    sa.StudentApplicationID,
    u.UniversityName AS university,
    sa.BursaryAmount AS budget,
    st.Status AS status,
    sa.Motivation AS Motivation,
    CONVERT(VARCHAR(10), sa.Date, 120) AS Date,
    CONCAT(r.FirstName, ' ', r.LastName) AS reviewerName,
    sa.ReviewerComment AS ReviewerComment
FROM
    StudentApplications sa
INNER JOIN
    Students s ON sa.StudentID = s.StudentID
INNER JOIN
    Universities u ON s.UniversityID = u.UniversityID
LEFT JOIN
    Users r ON sa.Reviewer_UserID = r.UserID
INNER JOIN
    Statuses st ON sa.StatusID = st.StatusID;

