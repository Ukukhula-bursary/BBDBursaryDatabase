CREATE PROCEDURE AddUser
    @FirstName VARCHAR(50),
    @LastName VARCHAR(50),
    @PhoneNumber VARCHAR(20),
    @Email VARCHAR(100),
    @IsActiveUser BIT,
    @UserRole INT
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;

        DECLARE @ContactID INT;
        DECLARE @UserID INT;

        -- Insert into Contacts table
        INSERT INTO Contacts (PhoneNumber, Email)
        VALUES (@PhoneNumber, @Email);

        -- Get the ID of the newly inserted contact
        SET @ContactID = SCOPE_IDENTITY();

        -- Insert into Users table with the obtained ContactID
        INSERT INTO Users (FirstName, LastName, ContactID, IsActiveUser)
        VALUES (@FirstName, @LastName, @ContactID, @IsActiveUser);

        SET @UserID = SCOPE_IDENTITY();

        -- Insert into UserRoles table
        INSERT INTO UserRoles(UserID, RoleID)
        VALUES(@UserID, @UserRole);

        COMMIT;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK;

        THROW
    END CATCH;
END;

--DROP PROC AddUser
--GO