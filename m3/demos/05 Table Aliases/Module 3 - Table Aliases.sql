-- Demo: Table Aliases

-- Table alias
SELECT	[Name] 
FROM [HumanResources].[Department] AS [dept];

-- Compact table alias example
SELECT	[Name] 
FROM [HumanResources].[Department] AS [d];

-- Counter-intuitive table alias example
SELECT	[Name] 
FROM [HumanResources].[Department] AS [q];