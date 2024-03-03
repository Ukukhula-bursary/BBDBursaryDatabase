CREATE PROCEDURE [dbo].[uspAddUniversityStaff]
	@FirstName VARCHAR(50),
	@LastName VARCHAR(50),
	@PhoneNumber CHAR(10),
	@Email VARCHAR(100),
	@UniversityID INT,
	@DepartmentID INT,
	@RoleID INT,
	@NewUniversityStaffID INT OUTPUT,
	@NewUserID INT OUTPUT

AS
BEGIN
    SET NOCOUNT ON;

	BEGIN TRY
        BEGIN TRANSACTION;

		DECLARE @UserID INT, @UniversityStaffID INT;

		EXECUTE AddUser @FirstName = @FirstName,
		@LastName = @LastName,
		@PhoneNumber = @PhoneNumber,
		@Email = @Email,
		@IsActiveUser = 1,
		@RoleID = @RoleID, 
		@NewUserID = @UserID OUTPUT

		INSERT INTO [dbo].[UniversityStaff] (UserID, UniversityID, DepartmentID)
			VALUES (@UserID, @UniversityID, @DepartmentID)

		SET @UniversityStaffID =  SCOPE_IDENTITY();

		COMMIT;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK;

        THROW
    END CATCH;

	SELECT @NewUniversityStaffID = @UniversityStaffID
END;

	