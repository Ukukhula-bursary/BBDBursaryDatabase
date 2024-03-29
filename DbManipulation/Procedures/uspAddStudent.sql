CREATE PROCEDURE [dbo].[uspAddStudent]
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

	@NewStudentID INT OUTPUT

AS
BEGIN
    SET NOCOUNT ON;

	BEGIN TRY
        BEGIN TRANSACTION;

		DECLARE @UserID INT, @StudentID INT;

		EXECUTE AddUser @FirstName = @FirstName,
		@LastName = @LastName,
		@PhoneNumber = @PhoneNumber,
		@Email = @Email,
		@IsActiveUser = 1,
		@RoleID = @RoleID, 
		@NewUserID = @UserID OUTPUT

		INSERT INTO [dbo].[Students] (
			[UserID]
			,[IDNumber]
			,[EthnicityID]
			,[UniversityID]
			,[DepartmentID]
		)
		VALUES (
			@UserID
			,@IDNumber
			,@EthnicityID
			,@UniversityID
			,@DepartmentID
		)

		SET @StudentID =  SCOPE_IDENTITY();
		
		COMMIT;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK;

        THROW
    END CATCH;

	SELECT @NewStudentID = @StudentID

END;

	