CREATE PROCEDURE AddUser
    @FirstName VARCHAR(50),
    @LastName VARCHAR(50),
    @PhoneNumber VARCHAR(20),
    @Email VARCHAR(100),
    @IsActive INT,
    @userRole INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @ContactID INT;
    DECLARE @userID INT;

    -- Insert into Contacts table
    INSERT INTO Contacts (PhoneNumber, Email)
    VALUES (@PhoneNumber, @Email);

    -- Get the ID of the newly inserted contact
    SET @ContactID = SCOPE_IDENTITY();

    -- Insert into Users table with the obtained ContactID
    INSERT INTO Users (FirstName, LastName, ContactID, IsActiveID)
    VALUES (@FirstName, @LastName, @ContactID, @IsActive);

    SET @userID= SCOPE_IDENTITY();

    INSERT INTO UserRoles(UserID,RoleID)
    VALUES(@userID,userRole);

  
    SELECT @user AS NewUserID;
END;
