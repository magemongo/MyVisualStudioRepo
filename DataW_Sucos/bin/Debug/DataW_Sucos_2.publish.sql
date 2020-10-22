﻿/*
Deployment script for DW_SUCOS

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "DW_SUCOS"
:setvar DefaultFilePrefix "DW_SUCOS"
:setvar DefaultDataPath "C:\Users\antonio.namur\SQL_2019\MSSQL15.MSSQLSERVER\MSSQL\DATA\"
:setvar DefaultLogPath "C:\Users\antonio.namur\SQL_2019\MSSQL15.MSSQLSERVER\MSSQL\DATA\"

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
PRINT N'Rename refactoring operation with key 00c7a66c-a8a8-4bc9-ac8c-66126216cf7a is skipped, element [dbo].[Dim_Categoria].[Id] (SqlSimpleColumn) will not be renamed to Cod_Categoria';


GO
PRINT N'Rename refactoring operation with key 488db83a-fb0b-4319-876d-c6bfc997cfe1 is skipped, element [dbo].[Dim_Marca].[Id] (SqlSimpleColumn) will not be renamed to Cod_Marca';


GO
PRINT N'Rename refactoring operation with key 8736efed-2d03-4c3c-8a72-5a4f568f3f5d is skipped, element [dbo].[Dim_Produto].[Id] (SqlSimpleColumn) will not be renamed to Cod_Produto';


GO
PRINT N'Rename refactoring operation with key c79c8e0c-9a6e-4d03-9261-ac205c5d09d7 is skipped, element [dbo].[Dim_Produto].[Sabor] (SqlSimpleColumn) will not be renamed to Atr_Tamanho';


GO
PRINT N'Creating [dbo].[Dim_Categoria]...';


GO
CREATE TABLE [dbo].[Dim_Categoria] (
    [Cod_Categoria]  NVARCHAR (50)  NOT NULL,
    [Desc_Categoria] NVARCHAR (200) NULL,
    PRIMARY KEY CLUSTERED ([Cod_Categoria] ASC)
);


GO
PRINT N'Creating [dbo].[Dim_Marca]...';


GO
CREATE TABLE [dbo].[Dim_Marca] (
    [Cod_Marca]     NVARCHAR (50)  NOT NULL,
    [Desc_Marca]    NVARCHAR (200) NULL,
    [Cod_Categoria] NVARCHAR (50)  NULL,
    PRIMARY KEY CLUSTERED ([Cod_Marca] ASC)
);


GO
PRINT N'Creating [dbo].[Dim_Produto]...';


GO
CREATE TABLE [dbo].[Dim_Produto] (
    [Cod_Produto] NVARCHAR (50)  NOT NULL,
    [Desc_]       NVARCHAR (200) NULL,
    [Atr_Tamanho] NVARCHAR (200) NULL,
    [Atr_Sabor]   NVARCHAR (200) NULL,
    [Cod_Marca]   NVARCHAR (50)  NULL,
    PRIMARY KEY CLUSTERED ([Cod_Produto] ASC)
);


GO
PRINT N'Creating [dbo].[FK_Dim_Marca_Dim_Categoria]...';


GO
ALTER TABLE [dbo].[Dim_Marca] WITH NOCHECK
    ADD CONSTRAINT [FK_Dim_Marca_Dim_Categoria] FOREIGN KEY ([Cod_Categoria]) REFERENCES [dbo].[Dim_Categoria] ([Cod_Categoria]);


GO
PRINT N'Creating [dbo].[FK_Dim_Produto_Dim_Marca]...';


GO
ALTER TABLE [dbo].[Dim_Produto] WITH NOCHECK
    ADD CONSTRAINT [FK_Dim_Produto_Dim_Marca] FOREIGN KEY ([Cod_Marca]) REFERENCES [dbo].[Dim_Marca] ([Cod_Marca]);


GO
-- Refactoring step to update target server with deployed transaction logs
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '00c7a66c-a8a8-4bc9-ac8c-66126216cf7a')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('00c7a66c-a8a8-4bc9-ac8c-66126216cf7a')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '488db83a-fb0b-4319-876d-c6bfc997cfe1')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('488db83a-fb0b-4319-876d-c6bfc997cfe1')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '8736efed-2d03-4c3c-8a72-5a4f568f3f5d')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('8736efed-2d03-4c3c-8a72-5a4f568f3f5d')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'c79c8e0c-9a6e-4d03-9261-ac205c5d09d7')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('c79c8e0c-9a6e-4d03-9261-ac205c5d09d7')

GO

GO
PRINT N'Checking existing data against newly created constraints';


GO
USE [$(DatabaseName)];


GO
ALTER TABLE [dbo].[Dim_Marca] WITH CHECK CHECK CONSTRAINT [FK_Dim_Marca_Dim_Categoria];

ALTER TABLE [dbo].[Dim_Produto] WITH CHECK CHECK CONSTRAINT [FK_Dim_Produto_Dim_Marca];


GO
PRINT N'Update complete.';


GO
