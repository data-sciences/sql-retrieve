-- Demo: Inner Join

USE AdventureWorks2012;

SELECT p.Name, od.ProductID, 
       od.SalesOrderDetailID, od.OrderQty
FROM [Production].[Product] AS p
INNER JOIN [Sales].[SalesOrderDetail] AS od
 ON p.ProductID = od.ProductID
ORDER BY p.Name, od.SalesOrderDetailID;

-- INNER was optional, but can help for readability
SELECT p.Name, od.ProductID, 
       od.SalesOrderDetailID, od.OrderQty
FROM [Production].[Product] AS p
 JOIN [Sales].[SalesOrderDetail] AS od
 ON p.ProductID = od.ProductID
ORDER BY p.Name, od.SalesOrderDetailID;

-- ANSI SQL-89 syntax
SELECT p.Name, od.ProductID, 
       od.SalesOrderDetailID, od.OrderQty
FROM [Production].[Product] AS p,
     [Sales].[SalesOrderDetail] AS od
WHERE p.ProductID = od.ProductID
ORDER BY p.Name, od.SalesOrderDetailID;