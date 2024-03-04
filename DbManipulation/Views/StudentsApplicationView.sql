CREATE VIEW StudentApplicationView AS
SELECT 
    u.UniversityID AS universityID,
    sa.StudentApplicationID AS applicationID,
    s.StudentID AS studentId,
    u.UniversityName AS university,
    (SELECT CONCAT(FirstName, ' ', LastName) FROM Users WHERE UserID = s.UserID) AS studentName,
    e.Ethnicity AS ethnicity,
    st.Status AS status,
    sa.Motivation AS motivation,
    sa.BursaryAmount AS bursaryAmount,
    CONVERT(VARCHAR(10), sa.Date, 120) AS date, -- Assuming the date column is of type DATETIME
    CONCAT(r.FirstName, ' ', r.LastName) AS reviewer,
    sa.ReviewerComment AS reviewerComment
FROM 
    StudentApplications sa
JOIN 
    Students s ON sa.StudentID = s.StudentID
JOIN 
    Universities u ON s.UniversityID = u.UniversityID
JOIN 
    Users u ON s.UserID = u.UserID
JOIN 
    Ethnicities e ON s.EthnicityID = e.EthnicityID
JOIN 
    Statuses st ON sa.StatusID = st.StatusID
LEFT JOIN 
    Users r ON sa.Reviewer_UserID = r.UserID;
