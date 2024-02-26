CREATE PROCEDURE UpdateUser
    @UserID INT,
    @FirstName VARCHAR(50),
    @LastName VARCHAR(50),
    @PhoneNumber VARCHAR(20),
    @Email VARCHAR(100),
    @IsActive INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Update Users table
    UPDATE Users
    SET FirstName = @FirstName,
        LastName = @LastName,
        IsActiveID = @IsActive
    WHERE UserID = @UserID;

    -- Update Contacts table
    UPDATE Contacts
    SET PhoneNumber = @PhoneNumber,
        Email = @Email
    WHERE ContactID = (SELECT ContactID FROM Users WHERE UserID = @UserID);

END;
