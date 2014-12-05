-- Demo: String Functions (3)

USE AdventureWorks2012;

-- LEN vs. DATALENGTH
-- Name column is nvarchar(50) data type
SELECT p.Name,
       LEN(p.Name) AS Name_LEN,
	   DATALENGTH(p.Name) AS Name_DATALENGTH
FROM [Production].[Product] AS p
ORDER BY p.Name;
