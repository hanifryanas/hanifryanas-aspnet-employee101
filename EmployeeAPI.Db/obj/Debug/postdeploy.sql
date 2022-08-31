/*
Post-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.		
 Use SQLCMD syntax to include a file in the post-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the post-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/
IF NOT EXISTS (SELECT 1 FROM dbo.Employees)
BEGIN
	INSERT INTO dbo.Employees (Name, Address, Phone) 
	VALUES 
	('John Doe', '123 Main St', '555-555-5555'),
	('Jane Doe', '456 Main St', '555-555-5556'),
	('Joe Doe', '789 Main St', '555-555-5557'),
	('Jill Doe', '321 Main St', '555-555-5558')
END
GO
