-- Demo: Calculating Time Differences

USE AdventureWorks2012;

-- DATEDIFF ( datepart , startdate , enddate )

-- Years
SELECT DATEDIFF (yy,'1/1/2007', '1/1/2008') AS 'YearDiff';

-- Days
SELECT DATEDIFF (dd,'1/1/2007', '1/1/2008') AS 'DayDiff';

-- Months
SELECT pch.ProductID,
       pch.StartDate,
	   pch.EndDate,
	   DATEDIFF(mm, pch.StartDate, pch.EndDate) AS MonthsStartEnd
FROM [Production].[ProductCostHistory] AS pch
WHERE pch.EndDate IS NOT NULL;
