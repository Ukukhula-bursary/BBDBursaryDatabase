CREATE PROCEDURE UpdateStudentApplication
    @StudentApplicationID INT,
    @FirstName VARCHAR(50) = NULL,
    @LastName VARCHAR(50) = NULL,
    @PhoneNumber CHAR(10) = NULL,
    @Email VARCHAR(100) = NULL,
    @Motivation NVARCHAR(MAX) = NULL,
    @BursaryAmount FLOAT = NULL,
    @StudentID INT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION; -- Start transaction

        -- Update Contacts table if necessary
        IF @PhoneNumber IS NOT NULL OR @Email IS NOT NULL
        BEGIN
            UPDATE Contacts
            SET PhoneNumber = COALESCE(@PhoneNumber, PhoneNumber),
                Email = COALESCE(@Email, Email)
            WHERE ContactID = (SELECT TOP 1 c.ContactID
                               FROM Contacts c
                               JOIN Users u ON c.ContactID=u.ContactID
                               JOIN Students uSt ON u.UserID = uSt.UserID 
                               JOIN StudentApplications st on uSt.StudentID=@StudentID);  
            
        END

        -- Update Users table if necessary
        IF @FirstName IS NOT NULL OR @LastName IS NOT NULL
        BEGIN
            UPDATE Users
            SET FirstName = COALESCE(@FirstName, FirstName),
                LastName = COALESCE(@LastName, LastName)
            WHERE UserID = (SELECT TOP 1 u.UserID
                            FROM Students u
                            WHERE u.StudentID=@StudentID);
        END

        -- Update BursaryAmount and Motivation in StudentApplications table if necessary
        IF @Motivation IS NOT NULL OR @BursaryAmount IS NOT NULL
        BEGIN
            UPDATE StudentApplications
            SET Motivation = COALESCE(@Motivation, Motivation),
                BursaryAmount = COALESCE(@BursaryAmount, BursaryAmount)
            WHERE StudentApplicationID = @StudentApplicationID;
        END

        -- Commit transaction
        COMMIT;
    END TRY
    BEGIN CATCH
        -- Rollback transaction if an error occurs
        IF @@TRANCOUNT > 0
            ROLLBACK;
        
        -- Throw the error to the caller
        THROW;
    END CATCH;
END;

DROP PROC UpdateStudentApplication
GO