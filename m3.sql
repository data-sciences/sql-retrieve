-- file: Module 3 - SELECT clause.sql
-- Demo: SELECT clause

USE AdventureWorks2008;

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


-- file: Module 3 - Column Aliases.sql
-- Demo: Column Aliases

SELECT	[Name] AS [DepartmentName], -- Recommended approach
		[Name] [DepartmentName], -- Not Recommended
		[GroupName] AS [GN]
FROM [HumanResources].[Department];

-- file: Module 3 - Regular versus Delimited Identifiers.sql
-- Demo: Regular versus Delimited Identifiers

-- Regular versus Delimited
SELECT	Name, 
		[Name] 
FROM [HumanResources].[Department];

-- Create a temporary table
CREATE TABLE #Department
	([Department ID] int NOT NULL);
GO

/*
-- Will this work?
SELECT Department ID
FROM #Department;
*/

-- How about this?
SELECT [Department ID]
FROM #Department;

-- file: Module 3 - Demo FROM clause.sql
-- Demo: FROM Clause

-- FROM Clause (table)
SELECT	[Name] 
FROM [HumanResources].[Department];

-- Check which views are in the database
SELECT SCHEMA_NAME(schema_id) AS [Schema], 
		[name]
FROM sys.views;

-- FROM Clause (table)
SELECT	[BusinessEntityID],
		[Name]
FROM [Sales].[vStoreWithAddresses];

-- Table variable
DECLARE @Orders TABLE
	(OrderID int NOT NULL PRIMARY KEY,
	 OrderDT datetime NOT NULL);

INSERT @Orders
VALUES (1, GETDATE());
GO

-- weaves @TODO
SELECT [OrderID], [OrderDT]
FROM @Orders;

-- file: Module 3 - Table Aliases.sql
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

-- file: Module 3 - WHERE clause.sql
-- Demo: WHERE Clause

-- One predicate
SELECT	[sod].[SalesOrderID],
		[sod].[SalesOrderDetailID],
		[sod].[CarrierTrackingNumber]
FROM [Sales].[SalesOrderDetail] AS [sod]
WHERE [sod].[CarrierTrackingNumber] = '4911-403C-98';

-- Two predicates with AND
SELECT	[sod].[SalesOrderID],
		[sod].[SalesOrderDetailID],
		[sod].[SpecialOfferID],
		[sod].[CarrierTrackingNumber]
FROM [Sales].[SalesOrderDetail] AS [sod]
WHERE [sod].[CarrierTrackingNumber] = '4911-403C-98' AND
	  [sod].[SpecialOfferID] = 1;

-- Two predicates with OR
SELECT	[sod].[SalesOrderID],
		[sod].[SalesOrderDetailID],
		[sod].[SpecialOfferID],
		[sod].[CarrierTrackingNumber]
FROM [Sales].[SalesOrderDetail] AS [sod]
WHERE [sod].[CarrierTrackingNumber] = '4911-403C-98' OR
	  [sod].[SpecialOfferID] = 1;

-- Three predicates AND and OR
SELECT	[sod].[SalesOrderID],
		[sod].[SalesOrderDetailID],
		[sod].[ProductID]
FROM [Sales].[SalesOrderDetail] AS [sod]
WHERE ([sod].[CarrierTrackingNumber] = '4911-403C-98' AND
	  [sod].[SpecialOfferID] = 1) OR
	  [sod].[ProductID] = 711;
	  

-- Negating a boolean expression
SELECT	[sod].[SalesOrderID],
		[sod].[SalesOrderDetailID],
		[sod].[ProductID]
FROM [Sales].[SalesOrderDetail] AS [sod]
WHERE  NOT [sod].[ProductID] = 711;
-- file: Module 3 - DISTINCT.sql
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
-- file: Module 3 - Demo TOP.sql
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
-- file: Module 3 - GROUP BY clause.sql
-- Demo: GROUP BY clause

-- GROUP BY, single column (notice it isn't ordered)
SELECT	[sod].[ProductID],
		SUM([sod].OrderQty) AS [OrderQtyByProductID]
FROM [Sales].[SalesOrderDetail] AS [sod]
GROUP BY [sod].[ProductID];

-- GROUP BY, single column, with ordering
SELECT	[sod].[ProductID],
		SUM([sod].OrderQty) AS [OrderQtyByProductID]
FROM [Sales].[SalesOrderDetail] AS [sod]
GROUP BY [sod].[ProductID]
ORDER BY [sod].[ProductID];

-- GROUP BY, multi-column, with ordering
SELECT	[sod].[ProductID],
		[sod].[SpecialOfferID],
		SUM([sod].OrderQty) AS [OrderQtyByProductID]
FROM [Sales].[SalesOrderDetail] AS [sod]
GROUP BY [sod].[ProductID],
		[sod].[SpecialOfferID]
ORDER BY [sod].[ProductID],
		[sod].[SpecialOfferID];

-- GROUPING SETS
SELECT	[sod].[ProductID],
		[sod].[SpecialOfferID],
		SUM([sod].OrderQty) AS [OrderQtyTotal]
FROM [Sales].[SalesOrderDetail] AS [sod]
GROUP BY GROUPING SETS
		(([sod].[ProductID],
		[sod].[SpecialOfferID]),
		([sod].[SpecialOfferID]))
ORDER BY [sod].[ProductID],
		[sod].[SpecialOfferID];
-- file: Module 3 - HAVING clause.sql
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
		
-- file: Module 3 - Order BY Clause.sql
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

/*
-- file: Module 3 - Demo Query Paging.sql
-- Demo: Query Paging
-- weaves @TODO

-- Returning the first 25 row

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
*/	

-- file: Module 3 - Binding Order.sql
-- Demo: Binding Order

/* 
-- Can I reference TotalCost?
SELECT	[TransactionID],
		[ProductID],
		[Quantity],
		[ActualCost],
		([Quantity] * [ActualCost]) AS [TotalCost]
FROM [Production].[TransactionHistory]
WHERE [TotalCost] >= 1000;
*/

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

-- file: Module 3 - Commenting.sql
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
