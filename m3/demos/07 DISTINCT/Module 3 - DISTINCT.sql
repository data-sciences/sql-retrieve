-- Demo: DISTINCT

-- No DISTINCT
SELECT	[sod].[SalesOrderID]
FROM [Sales].[SalesOrderDetail] AS [sod]
WHERE [sod].[CarrierTrackingNumber] = '4911-403C-98';

-- With DISTINCT
SELECT	DISTINCT [sod].[SalesOrderID]
FROM [Sales].[SalesOrderDetail] AS [sod]
WHERE [sod].[CarrierTrackingNumber] = '4911-403C-98';

-- NULL handling
SELECT DISTINCT [CarrierTrackingNumber]
FROM [Sales].[SalesOrderDetail]  AS [sod]
ORDER BY [CarrierTrackingNumber];

-- Count of rows with NULL
SELECT COUNT(*) 
FROM [Sales].[SalesOrderDetail]  AS [sod]
WHERE [CarrierTrackingNumber] IS NULL;
