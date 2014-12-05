-- Demo: Cross Joins

USE AdventureWorks2012;

-- How many rows?
SELECT COUNT(*)
FROM [HumanResources].[Employee];

-- How many rows?
SELECT COUNT(*)
FROM [HumanResources].[EmployeeDepartmentHistory];

-- What gets returned?
SELECT e.BusinessEntityID, edh.DepartmentID
FROM [HumanResources].[Employee] AS e
CROSS JOIN [HumanResources].[EmployeeDepartmentHistory] AS edh;

-- The math
SELECT 290 * 296;

-- Practical usage - numbers result set
SELECT TOP 100000
		ROW_NUMBER() OVER (ORDER BY sv1.number) AS num
FROM [master].[dbo].[spt_values] sv1
CROSS JOIN [master].[dbo].[spt_values] sv2;


