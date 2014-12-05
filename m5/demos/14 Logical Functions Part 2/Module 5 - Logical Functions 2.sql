-- Demo: Logical Functions (2)

USE AdventureWorks2012;

-- Simple CASE
SELECT pch.ProductID,
       pch.StartDate,
	   pch.StandardCost,
	   CASE pch.ProductID
	     WHEN 707 THEN 'Platinum Collection'
		 WHEN 711 THEN 'Silver Collection'
		 WHEN 713 THEN 'Gold Collection'
		 ELSE 'Standard Product'
	   END AS 'Product Status'
FROM [Production].[ProductCostHistory] AS pch;

-- Searched CASE
SELECT pch.ProductID,
       pch.StartDate,
	   CASE 
	      WHEN pch.StartDate BETWEEN '12/31/2004' AND '1/1/2006'
		     THEN 'Owned by K-Tech'
		  WHEN pch.StartDate BETWEEN '12/31/2006' AND '1/1/2008'
		     THEN 'Owned by Z-Tech'
		  ELSE 'Unknown Ownership'
	   END AS 'OwnerStatus',
	   pch.StandardCost
FROM [Production].[ProductCostHistory] AS pch;