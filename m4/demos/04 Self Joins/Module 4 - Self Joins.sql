-- Demo: Self Joins

USE AdventureWorks2012;

-- Adding a column for this demo
ALTER TABLE [HumanResources].[Employee]
ADD [ManagerID] int NULL;
GO

-- The CEO doesn't have a manager (except the shareholders)
UPDATE [HumanResources].[Employee]
SET  ManagerID  = 1
WHERE BusinessEntityID <> 1;

-- Show the Employee / Manager relationship
SELECT e.BusinessEntityID, e.HireDate,
	   e.ManagerID, m.HireDate
FROM [HumanResources].[Employee] AS e
LEFT OUTER JOIN [HumanResources].[Employee] AS m
 ON e.ManagerID = m.BusinessEntityID;

-- Demo cleanup
ALTER TABLE [HumanResources].[Employee]
DROP COLUMN [ManagerID];
GO
