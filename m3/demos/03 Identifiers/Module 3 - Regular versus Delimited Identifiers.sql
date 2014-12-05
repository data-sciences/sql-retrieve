-- Demo: Regular versus Delimited Identifiers

-- Regular versus Delimited
SELECT	Name, 
		[Name] 
FROM [HumanResources].[Department];

-- Create a temporary table
CREATE TABLE #Department
	([Department ID] int NOT NULL);
GO

-- Will this work?
SELECT Department ID
FROM #Department;

-- How about this?
SELECT [Department ID]
FROM #Department;