-- Demo: ORDER BY Clause

-- Order by descending and ascending
SELECT	[sod].[ProductID],
		[sod].[SpecialOfferID]
FROM [Sales].[SalesOrderDetail] AS [sod]
ORDER BY [sod].[ProductID] DESC,
		[sod].[SpecialOfferID] ASC;

-- Not recommended!
SELECT	[sod].[ProductID],
		[sod].[SpecialOfferID]
FROM [Sales].[SalesOrderDetail] AS [sod]
ORDER BY 1, 2;

SELECT	[sod].[SpecialOfferID],
		[sod].[ProductID]
FROM [Sales].[SalesOrderDetail] AS [sod]
ORDER BY 1, 2;
