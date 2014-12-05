-- Demo: Returning Date and Time Parts

USE AdventureWorks2012;

SELECT pch.ProductID,
       pch.StartDate,
	   MONTH(pch.StartDate) AS StartMonth,
	   DAY(pch.StartDate) AS StartDay,
	   YEAR(pch.StartDate) AS StartYear
FROM [Production].[ProductCostHistory] AS pch
WHERE pch.EndDate IS NOT NULL;

-- DATEPART ( datepart , date )
SELECT pch.ProductID,
       pch.StartDate,
	   DATEPART(m, pch.StartDate) AS StartMonth,
	   DATEPART(d, pch.StartDate) AS StartDay,
	   DATEPART(yy, pch.StartDate) AS StartYear
FROM [Production].[ProductCostHistory] AS pch
WHERE pch.EndDate IS NOT NULL;

-- DATENAME ( datepart , date )
SELECT pch.ProductID,
       pch.StartDate,
	   DATENAME(m, pch.StartDate) AS StartMonth,
	   DATENAME(d, pch.StartDate) AS StartDay,
	   DATENAME(yy, pch.StartDate) AS StartYear
FROM [Production].[ProductCostHistory] AS pch
WHERE pch.EndDate IS NOT NULL;