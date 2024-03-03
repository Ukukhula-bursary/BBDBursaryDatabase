CREATE PROCEDURE [dbo].[uspAddStudentApplication_NewStudent]
	-- User table
	@FirstName VARCHAR(50),
	@LastName VARCHAR(50),
	-- Contacts table
	@PhoneNumber CHAR(10),
	@Email VARCHAR(100),
	-- UserRole table
	@RoleID INT,
	-- Students table
	@IDNumber CHAR(13),
	@EthnicityID INT,
	@UniversityID INT,
	@DepartmentID INT,
	-- Student Applications table
	@Motivation TEXT,
	@BursaryAmount MONEY,
	@StatusID INT,
	@Reviewer_UserID INT,
	@ReviewerComment TEXT,
	@Date DATE,
	@UniversityStaffID INT,
	@BursaryDetailsID INT,

	@NewStudentApplicationID INT OUTPUT

AS
BEGIN
    SET NOCOUNT ON;

	BEGIN TRY
        BEGIN TRANSACTION;

		DECLARE @StudentID INT, @StudentApplicationID INT;

		EXECUTE [dbo].[uspAddStudent]
			@FirstName = @FirstName,
			@LastName = @LastName,
			@PhoneNumber = @PhoneNumber,
			@Email = @Email,
			@RoleID = @RoleID,
			@IDNumber = @IDNumber,
			@EthnicityID = @EthnicityID,
			@UniversityID = @UniversityID,
			@DepartmentID = @DepartmentID,
			@NewStudentID = @StudentID OUTPUT;



		INSERT INTO [dbo].[StudentApplications] (
			[StudentID]
           ,[Motivation]
           ,[BursaryAmount]
           ,[StatusID]
           ,[Reviewer_UserID]
           ,[ReviewerComment]
           ,[Date]
           ,[UniversityStaffID]
           ,[BursaryDetailsID]
		)
		VALUES (
			@StudentID
           ,@Motivation
           ,@BursaryAmount
           ,@StatusID
           ,@Reviewer_UserID
           ,@ReviewerComment
           ,@Date
           ,@UniversityStaffID
           ,@BursaryDetailsID
		)

		SET @StudentApplicationID =  SCOPE_IDENTITY();
		
		COMMIT;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK;

        THROW
    END CATCH;

	SELECT @NewStudentApplicationID = @StudentApplicationID

END;

	