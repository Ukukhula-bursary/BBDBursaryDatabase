CREATE PROCEDURE AddStudentApplication
    @FirstName VARCHAR(50),
    @LastName VARCHAR(50),
    @PhoneNumber CHAR(10),
    @Email VARCHAR(100),
    @Motivation NVARCHAR(MAX),
    @BursaryAmount FLOAT,
    @IDNumber CHAR(13),
    @EthnicityID INT,
    @HoDEmail INT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION; -- Start transaction
 DECLARE @ContactID INT;
 DECLARE @UserID INT;
 DECLARE @UniversityID INT;   
 DECLARE @StudentApplicationID INT;
 DECLARE @DepartmentID INT;
 DECLARE @UniversityStaffID VARCHAR;
        -- Insert into contacts table
        INSERT INTO Contacts(PhoneNumber, Email)
        VALUES(@PhoneNumber, @Email);

       
        SET @ContactID =  SCOPE_IDENTITY();

        -- Insert into Users table
        INSERT INTO Users (FirstName, LastName, ContactID, IsActiveID)
        VALUES (@FirstName, @LastName, @ContactID, 1);

        
        SET @UserID =  SCOPE_IDENTITY();

        -- Insert into UserRole table
        INSERT INTO [dbo].[UserRole] (UserID, RoleID) 
        VALUES (@UserID, 4);

        -- Get UniversityID based on HODID
       
		SET @UniversityStaffID = (SELECT us.UniversityStaffID
								  FROM UniversityStaff us
								  JOIN Users u ON us.UserID = u.UserID
								  JOIN Contacts c ON u.ContactID = c.ContactID
								  WHERE c.Email = @HoDEmail)
        SET @UniversityID = (SELECT UniversityID FROM UniversityStaff WHERE UniversityStaffID = @UniversityStaffID); --where the hod is
		 SET @DepartmentID = (SELECT DepartmentID FROM UniversityStaff WHERE UniversityStaffID =@UniversityStaffID); --
        -- Insert into Students table
        INSERT INTO Students (UserID,IDNumber, EthnicityID, UniversityID, DepartmentID)
        VALUES (@UserID,@IDNumber, @EthnicityID, @UniversityID, @DepartmentID);

        DECLARE @StudentID INT;
        SET @StudentID =  SCOPE_IDENTITY();

        -- Insert into StudentApplications table
        INSERT INTO StudentApplications (StudentID, Motivation, BursaryAmount, StatusID, Reviewer_UserID, ReviewerComment, [Date], UniversityStaffID, BursaryDetailsID)
        VALUES (@StudentID, @Motivation, @BursaryAmount, 2, 1, 'n/a', GETDATE(), @UniversityStaffID, 5);

    
        SET @StudentApplicationID =  SCOPE_IDENTITY();

        -- Insert into StudentApplicationDocument table
        INSERT INTO StudentApplicationDocuments (StudentApplicationID, CertifiedIdCopy, AcademicTranscript, CurriculumVitae)
        VALUES (@StudentApplicationID, 'linkupload', 'uploadlink', 'uploadlink');

        -- Commit transaction
        COMMIT;
        
       -- SELECT @StudentApplicationID AS NewApplicationID; -- Return the new application ID
    END TRY
    BEGIN CATCH
        -- Rollback transaction if an error occurs
        IF @@TRANCOUNT > 0
            ROLLBACK;
        
        -- Throw the error to the caller
        THROW;
    END CATCH;
END;

--DROP PROC AddStudentApplication
--GO