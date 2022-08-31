CREATE PROCEDURE [dbo].[AddEmployee]
	
	@Name NVARCHAR(50),
	@Address NVARCHAR(50),
	@Phone NVARCHAR(50)
	
AS

BEGIN
	INSERT INTO [dbo].[Employees]
	([Name], [Address], [Phone])
	VALUES
	(@Name, @Address, @Phone)
	SELECT CAST(SCOPE_IDENTITY() AS int)
END
