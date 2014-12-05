-- Demo: Aggregate Functions

USE AdventureWorks2012;

-- AVG quantity across location/shelf/bin
SELECT	p.Name AS ProductName,
		AVG(pin.Quantity) AS AvgQuantity
FROM [Production].[Product] AS p
INNER JOIN [Production].[ProductInventory] AS pin 
  ON p.ProductID = pin.ProductID
GROUP BY p.Name
ORDER BY p.Name;

SELECT pin.Bin, pin.LocationID, pin.Shelf, 
	   pin.Quantity
FROM [Production].[Product] AS p
INNER JOIN [Production].[ProductInventory] AS pin 
  ON p.ProductID = pin.ProductID
WHERE p.Name = 'Adjustable Race';

SELECT (408 + 324 + 353) / 3;

-- Using CHECKSUM to compute a hash value for each row based on all 
-- columns in the table... (warning - HashBytes may be better at detecting changes)
SELECT CHECKSUM(*) CheckSumVal, ProductID, Name, ProductNumber, MakeFlag, FinishedGoodsFlag, Color, SafetyStockLevel, ReorderPoint, StandardCost, ListPrice, Size, SizeUnitMeasureCode, WeightUnitMeasureCode, Weight, DaysToManufacture, ProductLine, Class, Style, ProductSubcategoryID, ProductModelID, SellStartDate, SellEndDate, DiscontinuedDate, rowguid, ModifiedDate
FROM [Production].[Product] AS p;

-- One row checksum
SELECT CHECKSUM(*) 
FROM [Production].[Product] AS p
WHERE p.ProductID = 1;

-- Will this remain -273937161? 
UPDATE [Production].[Product]
SET ProductNumber = 'AR-538999'
WHERE ProductID = 1;

-- Now it's 1337300156
SELECT CHECKSUM(*) 
FROM [Production].[Product] AS p
WHERE p.ProductID = 1;

-- Setting it back...
UPDATE [Production].[Product]
SET ProductNumber = 'AR-5381'
WHERE ProductID = 1;

-- Now it's -273937161 (what it was originally)
SELECT CHECKSUM(*) 
FROM [Production].[Product] AS p
WHERE p.ProductID = 1;

-- Use CHECKSUM_AGG to see if a table has changed
SELECT CHECKSUM_AGG(CHECKSUM(*)) TableCheckSum
FROM [Production].[Product] AS p;

-- Was 1117395237

-- Will this remain -273937161? 
UPDATE [Production].[Product]
SET ProductNumber = 'AR-538999'
WHERE ProductID = 1;

-- Use CHECKSUM_AGG to see if a table has changed
SELECT CHECKSUM_AGG(CHECKSUM(*)) TableCheckSum
FROM [Production].[Product] AS p;

-- Now its -494698130

-- Setting it back...
UPDATE [Production].[Product]
SET ProductNumber = 'AR-5381'
WHERE ProductID = 1;

-- Back to 1117395237
SELECT CHECKSUM_AGG(CHECKSUM(*)) TableCheckSum
FROM [Production].[Product] AS p;

-- COUNT
SELECT COUNT(*) RowCnt
FROM [Production].[Product] AS p;

SELECT DISTINCT Color
FROM [Production].[Product] AS p;

-- Notice the count doesn't include NULL value
SELECT COUNT(DISTINCT Color)
FROM [Production].[Product] AS p;

-- Count by group
SELECT	p.Name AS ProductName,
		COUNT(pin.Shelf) AS ShelfCount
FROM [Production].[Product] AS p
INNER JOIN [Production].[ProductInventory] AS pin 
  ON p.ProductID = pin.ProductID
GROUP BY p.Name
ORDER BY p.Name;

-- MIN and MAX
SELECT	p.Name AS ProductName,
		MIN(pin.Quantity) AS MinQty,
		MAX(pin.Quantity) AS MaxQty
FROM [Production].[Product] AS p
INNER JOIN [Production].[ProductInventory] AS pin 
  ON p.ProductID = pin.ProductID
GROUP BY p.Name
ORDER BY p.Name;