-- Demo: Outer Joins

USE AdventureWorks2012;

SELECT p.Name, od.ProductID, 
       od.SalesOrderDetailID, od.OrderQty
FROM [Production].[Product] AS p
INNER JOIN [Sales].[SalesOrderDetail] AS od
 ON p.ProductID = od.ProductID
ORDER BY p.Name, od.SalesOrderDetailID;

-- Contrast with LEFT OUTER JOIN
SELECT p.Name, od.ProductID, 
       od.SalesOrderDetailID, od.OrderQty
FROM [Production].[Product] AS p
LEFT OUTER JOIN [Sales].[SalesOrderDetail] AS od
 ON p.ProductID = od.ProductID
ORDER BY p.Name, od.SalesOrderDetailID;

-- What's the difference?
SELECT p.Name, od.ProductID, 
       od.SalesOrderDetailID, od.OrderQty
FROM [Production].[Product] AS p
LEFT OUTER JOIN [Sales].[SalesOrderDetail] AS od
 ON p.ProductID = od.ProductID
WHERE od.ProductID IS NULL
ORDER BY p.Name, od.SalesOrderDetailID;

-- Predicate placement in ON
SELECT p.Name, od.ProductID, 
       od.SalesOrderDetailID, od.OrderQty
FROM [Production].[Product] AS p
LEFT OUTER JOIN [Sales].[SalesOrderDetail] AS od
 ON p.ProductID = od.ProductID AND
	od.OrderQty > 2
ORDER BY p.Name, od.SalesOrderDetailID;

-- Predicate placement in WHERE
SELECT p.Name, od.ProductID, 
       od.SalesOrderDetailID, od.OrderQty
FROM [Production].[Product] AS p
LEFT OUTER JOIN [Sales].[SalesOrderDetail] AS od
 ON p.ProductID = od.ProductID 
WHERE od.OrderQty > 2
ORDER BY p.Name, od.SalesOrderDetailID;