-- Demo - Commenting your code

-- Put your text here, explaining hints, usually single line

/*

	The other way is to use /* ... */
	Often used for multi-line

*/

SELECT	[TransactionID],
		[ProductID],
		[Quantity],
		[ActualCost],
		'Batch 1' AS [BatchID],
		([Quantity] * [ActualCost]) AS [TotalCost]
FROM [Production].[TransactionHistory];