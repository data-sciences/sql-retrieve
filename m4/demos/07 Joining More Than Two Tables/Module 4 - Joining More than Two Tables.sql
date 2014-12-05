-- Demo: Joining More than Two Tables

USE AdventureWorks2012;

-- INNER JOIN multi-table join example
-- Show actual execution plan (compare logical to physical)
SELECT p.Name AS [ProductName], 
	   pc.Name AS [CategoryName],
	   ps.Name AS [SubcategoryName]
FROM [Production].[Product] AS p
INNER JOIN [Production].[ProductSubcategory] AS ps
  ON p.ProductSubcategoryID = ps.ProductSubcategoryID
INNER JOIN [Production].[ProductCategory] AS pc
  ON ps.ProductCategoryID = pc.ProductCategoryID
ORDER BY [ProductName], [CategoryName], [SubcategoryName];

-- OUTER JOIN multi-table join example with logical issue
SELECT p.Name, sod.SalesOrderDetailID
FROM [Production].[Product] AS p
LEFT OUTER JOIN [Sales].[SalesOrderDetail] AS sod
  ON p.ProductID = sod.ProductID
INNER JOIN [Sales].[SpecialOffer] AS so
  ON sod.SpecialOfferID = so.SpecialOfferID
ORDER BY p.Name, sod.SalesOrderDetailID;

-- Fixing the logical issue
SELECT p.Name, sod.SalesOrderDetailID
FROM [Production].[Product] AS p
LEFT OUTER JOIN [Sales].[SalesOrderDetail] AS sod
  ON p.ProductID = sod.ProductID
LEFT OUTER JOIN [Sales].[SpecialOffer] AS so
  ON sod.SpecialOfferID = so.SpecialOfferID
ORDER BY p.Name, sod.SalesOrderDetailID;



