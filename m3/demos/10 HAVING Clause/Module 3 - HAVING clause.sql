-- Demo: HAVING clause

-- Applying a predicate to a group
SELECT	[sod].[ProductID],
		[sod].[SpecialOfferID],
		SUM([sod].[OrderQty]) AS [OrderQtyByProductID]
FROM [Sales].[SalesOrderDetail] AS [sod]
GROUP BY [sod].[ProductID],
		[sod].[SpecialOfferID]
HAVING SUM([sod].[OrderQty]) >= 100
ORDER BY [sod].[ProductID],
		[sod].[SpecialOfferID];

-- Does HAVING or WHERE matter for performance?
SELECT	[sod].[ProductID],
		[sod].[SpecialOfferID],
		SUM([sod].[OrderQty]) AS [OrderQtyByProductID]
FROM [Sales].[SalesOrderDetail] AS [sod]
GROUP BY [sod].[ProductID],
		[sod].[SpecialOfferID]
HAVING [sod].[SpecialOfferID] IN (1,2,3)
ORDER BY [sod].[ProductID],
		[sod].[SpecialOfferID];