-- Demo: TOP

-- No TOP
SELECT	[FirstName],
		[LastName],
		[StartDate],
		[EndDate]
FROM [HumanResources].[vEmployeeDepartmentHistory] AS [edh]
ORDER BY [edh].[StartDate];

-- TOP rows
SELECT	TOP (10)
		[FirstName],
		[LastName],
		[StartDate],
		[EndDate]
FROM [HumanResources].[vEmployeeDepartmentHistory] AS [edh]
ORDER BY [edh].[StartDate];

-- TOP percentage
SELECT	TOP (50) PERCENT
		[FirstName],
		[LastName],
		[StartDate],
		[EndDate]
FROM [HumanResources].[vEmployeeDepartmentHistory] AS [edh]
ORDER BY [edh].[StartDate];

-- TOP WITH TIES
SELECT	TOP (5) WITH TIES
		[FirstName],
		[LastName],
		[StartDate],
		[EndDate]
FROM [HumanResources].[vEmployeeDepartmentHistory] AS [edh]
WHERE [edh].[StartDate] = '2005-07-01'
ORDER BY [edh].[StartDate];

-- Without TIES
SELECT	TOP (5) 
		[FirstName],
		[LastName],
		[StartDate],
		[EndDate]
FROM [HumanResources].[vEmployeeDepartmentHistory] AS [edh]
WHERE [edh].[StartDate] = '2005-07-01'
ORDER BY [edh].[StartDate];
