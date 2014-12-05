-- Demo: Aggregate Functions (2)

USE AdventureWorks2012;

-- SUM
SELECT LocationID,
	   SUM(Quantity) AS QtyByLocationID
FROM [Production].[ProductInventory]
GROUP BY LocationID
ORDER BY LocationID;

SELECT SUM(Quantity) AS TotalQty
FROM [Production].[ProductInventory];

-- STDEV (numbers provided assumed to be a partial sampling of population)
SELECT STDEV(ListPrice) AS STDEVListPrice
FROM [Production].[ProductListPriceHistory];

-- STDEVP (calculations assume complete population of values)
SELECT STDEVP(ListPrice) AS STDEVListPrice
FROM [Production].[ProductListPriceHistory];

-- VAR (statistical variance - partial sample assumed)
SELECT VAR(ListPrice) AS STDEVListPrice
FROM [Production].[ProductListPriceHistory];

-- VARP (statistical variance for the population for all values )
SELECT VARP(ListPrice) AS STDEVListPrice
FROM [Production].[ProductListPriceHistory];