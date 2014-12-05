-- Demo: Binding Order

-- Can I reference TotalCost?
SELECT	[TransactionID],
		[ProductID],
		[Quantity],
		[ActualCost],
		([Quantity] * [ActualCost]) AS [TotalCost]
FROM [Production].[TransactionHistory]
WHERE [TotalCost] >= 1000;

-- Can I reference TotalCost?
SELECT	[TransactionID],
		[ProductID],
		[Quantity],
		[ActualCost],
		([Quantity] * [ActualCost]) AS [TotalCost]
FROM [Production].[TransactionHistory]
ORDER BY [TotalCost];

/*
	FROM
	ON
	JOIN
	WHERE 
	GROUP BY 
	HAVING
	SELECT
	DISTINCT
	ORDER BY 
	TOP
*/

