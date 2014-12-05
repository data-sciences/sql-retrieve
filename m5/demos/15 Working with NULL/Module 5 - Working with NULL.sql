-- Demo: Working with NULLs

USE AdventureWorks2012;

-- COALESCE ( expression [ ,...n ] ) 
DECLARE @val1 int = NULL;
DECLARE @val2 int = NULL;
DECLARE @val3 int = 2;
DECLARE @val4 int = 5;

SELECT COALESCE(@val1, @val2, @val3, @val4) 
   AS FirstNonNull;

-- ISNULL
SELECT p.Name,
       ISNULL(p.Color, 'Unknown') AS Color
FROM [Production].[Product] AS p
ORDER BY p.Name;

-- CONCAT_NULL_YIELDS_NULL behavior

SET CONCAT_NULL_YIELDS_NULL ON;
GO

DECLARE @ReportName varchar(20) = NULL;
SELECT 'Report Date:' + @ReportName
   AS ReportHeader;
GO


SET CONCAT_NULL_YIELDS_NULL OFF;
GO

DECLARE @ReportName varchar(20) = NULL;
SELECT 'Report Date:' + @ReportName
   AS ReportHeader;
GO

-- In a future version of SQL Server CONCAT_NULL_YIELDS_NULL will always be ON 
