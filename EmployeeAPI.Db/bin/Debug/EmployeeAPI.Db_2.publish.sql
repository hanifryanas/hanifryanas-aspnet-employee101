/*
Deployment script for Employees

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "Employees"
:setvar DefaultFilePrefix "Employees"
:setvar DefaultDataPath "C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\"
:setvar DefaultLogPath "C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\"

GO
:on error exit
GO
/*
Detect SQLCMD mode and disable script execution if SQLCMD mode is not supported.
To re-enable the script after enabling SQLCMD mode, execute the following:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'SQLCMD mode must be enabled to successfully execute this script.';
        SET NOEXEC ON;
    END


GO
USE [$(DatabaseName)];


GO
PRINT N'Starting rebuilding table [dbo].[Employees]...';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_Employees] (
    [Id]      INT           IDENTITY (1, 1) NOT NULL,
    [Name]    NVARCHAR (50) NOT NULL,
    [Address] NVARCHAR (50) NOT NULL,
    [Phone]   NVARCHAR (50) NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[Employees])
    BEGIN
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_Employees] ON;
        INSERT INTO [dbo].[tmp_ms_xx_Employees] ([Id], [Name], [Address], [Phone])
        SELECT   [Id],
                 [Name],
                 [Address],
                 [Phone]
        FROM     [dbo].[Employees]
        ORDER BY [Id] ASC;
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_Employees] OFF;
    END

DROP TABLE [dbo].[Employees];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_Employees]', N'Employees';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'Refreshing Procedure [dbo].[AddEmployee]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[AddEmployee]';


GO
PRINT N'Refreshing Procedure [dbo].[DeleteEmployee]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[DeleteEmployee]';


GO
PRINT N'Refreshing Procedure [dbo].[GetAllEmployees]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[GetAllEmployees]';


GO
PRINT N'Refreshing Procedure [dbo].[GetSelectedEmployee]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[GetSelectedEmployee]';


GO
PRINT N'Refreshing Procedure [dbo].[UpdateEmployee]...';


GO
EXECUTE sp_refreshsqlmodule N'[dbo].[UpdateEmployee]';


GO
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

BEGIN
	INSERT INTO dbo.Employees (Name, Address, Phone) 
	VALUES 
	('John Doe', '123 Main St', '555-555-5555'),
	('Jane Doe', '456 Main St', '555-555-5556'),
	('Joe Doe', '789 Main St', '555-555-5557'),
	('Jill Doe', '321 Main St', '555-555-5558')
END
GO

GO
PRINT N'Update complete.';


GO
