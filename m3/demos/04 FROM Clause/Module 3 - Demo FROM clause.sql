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

SELECT [OrderID], [OrderDT]
FROM @Orders;
