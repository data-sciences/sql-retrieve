-- Demo: Modifying Dates

USE AdventureWorks2012;

-- DATEADD (datepart , number , date )
SELECT pch.ProductID,
	   pch.StartDate,
	   DATEADD (yy, 1, pch.StartDate) AS PriceEvaluationDate
FROM [Production].[ProductCostHistory] AS pch;

-- EOMONTH ( start_date [, month_to_add ] )
SELECT pch.ProductID,
	   pch.StartDate,
	   EOMONTH (pch.StartDate) AccountingPeriod
FROM [Production].[ProductCostHistory] AS pch;

SELECT pch.ProductID,
	   pch.StartDate,
	   EOMONTH (pch.StartDate, 1) AccountingPeriod
FROM [Production].[ProductCostHistory] AS pch;

-- SWITCHOFFSET ( DATETIMEOFFSET, time_zone ) 
SELECT pch.ProductID,
	   pch.StartDate,
	   CAST(pch.StartDate as datetimeoffset) 
	      AS StartDateUTC,
	   SWITCHOFFSET(CAST(pch.StartDate as datetimeoffset), '-06:00')
	      AS StartDateUTC_CST
FROM [Production].[ProductCostHistory] AS pch;

-- TODATETIMEOFFSET ( expression , time_zone )
SELECT pch.ProductID,
	   pch.StartDate,
	   TODATETIMEOFFSET(pch.StartDate, '-06:00')
	      AS StartDateUTC_CST
FROM [Production].[ProductCostHistory] AS pch;
