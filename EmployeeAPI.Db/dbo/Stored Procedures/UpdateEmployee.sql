CREATE PROCEDURE [dbo].[UpdateEmployee]

	@Id INT,
	@Name NVARCHAR(50),
	@Address NVARCHAR(50),
	@Phone NVARCHAR(50)

AS

BEGIN
	UPDATE [dbo].[Employees]
	SET [Name] = @Name, [Address] = @Address, [Phone] = @Phone
	WHERE [Id] = @Id
END
