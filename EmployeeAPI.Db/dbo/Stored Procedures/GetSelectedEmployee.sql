CREATE PROCEDURE [dbo].[GetSelectedEmployee]

	@Id INT

AS

BEGIN
	SELECT * FROM [dbo].[Employees] WHERE [Id] = @Id
END

