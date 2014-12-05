-- Demo: Query Paging

-- Returning the first 25 rows
SELECT	[e].[FirstName],
		[e].[LastName],
		[e].[AddressLine1]
FROM [HumanResources].[vEmployee] AS [e]
ORDER BY [e].[LastName], [e].[FirstName]
	OFFSET 0 ROWS 
	FETCH NEXT 25 ROWS ONLY;


-- Paging through the next 25 rows
SELECT	[e].[FirstName],
		[e].[LastName],
		[e].[AddressLine1]
FROM [HumanResources].[vEmployee] AS [e]
ORDER BY [e].[LastName], [e].[FirstName]
	OFFSET 25 ROWS 
	FETCH NEXT 25 ROWS ONLY;