-- Demo: SELECT clause

USE AdventureWorks2012;

-- No data source access
SELECT	'1' AS [col01],
		'A' AS [col02];

-- Check available data source columns
EXEC sp_help 'Production.TransactionHistory';

-- One data source
SELECT	[TransactionID],
		[ProductID],
		[Quantity],
		[ActualCost],
		'Batch 1' AS [BatchID],
		([Quantity] * [ActualCost]) AS [TotalCost]
FROM [Production].[TransactionHistory];


