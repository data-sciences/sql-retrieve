-- Demo: Column Aliases

SELECT	[Name] AS [DepartmentName], -- Recommended approach
		[Name] [DepartmentName], -- Not Recommended
		[GroupName] AS [GN]
FROM [HumanResources].[Department];