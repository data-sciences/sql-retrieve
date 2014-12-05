-- Demo: Using Sub-queries

USE AdventureWorks2012;

-- Joining to a sub-query
SELECT sod.SalesOrderDetailID, sod.SalesOrderID,
       soh.SalesPersonID
FROM [Sales].[SalesOrderDetail] AS sod
INNER JOIN (SELECT SalesOrderID, SalesPersonID
            FROM [Sales].[SalesOrderHeader]
			WHERE AccountNumber = '10-4020-000510') AS soh 
	ON sod.SalesOrderID = soh.SalesOrderID;

-- This could be re-written as follows
SELECT sod.SalesOrderDetailID, sod.SalesOrderID,
       soh.SalesPersonID
FROM [Sales].[SalesOrderDetail] AS sod
INNER JOIN [Sales].[SalesOrderHeader] AS soh 
	ON sod.SalesOrderID = soh.SalesOrderID
WHERE AccountNumber = '10-4020-000510';

-- Non-correlated sub-query in a predicate
SELECT sod.SalesOrderDetailID, sod.SalesOrderID
FROM [Sales].[SalesOrderDetail] AS sod
WHERE sod.SalesOrderID IN 
	(SELECT SalesOrderID 
	 FROM [Sales].[SalesOrderHeader]
	 WHERE AccountNumber = '10-4020-000510');

-- Correlated sub-query join
SELECT soh.SalesOrderID
FROM [Sales].[SalesOrderHeader] AS soh
WHERE soh.SalesOrderID IN
	(SELECT SalesOrderID
	 FROM [Sales].[SalesOrderDetail] AS sod
	 WHERE soh.SalesOrderID = sod.SalesOrderID AND
	       sod.OrderQty > 2);


