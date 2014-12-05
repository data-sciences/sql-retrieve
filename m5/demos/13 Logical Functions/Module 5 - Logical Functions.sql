-- Demo: Logical Functions

USE AdventureWorks2012;

-- CHOOSE ( index, val_1, val_2 [, val_n ] )
SELECT CHOOSE (2, 'Route 1', 'Route 2', 'Route 3') 
   AS RouteChoice;

SELECT CHOOSE (3, 'Route 1', 'Route 2', 'Route 3') 
   AS RouteChoice;

-- IIF ( boolean_expression, true_value, false_value )
SELECT pch.ProductID,
       pch.StartDate,
	   IIF ( pch.StartDate BETWEEN '12/31/2004' AND '1/1/2006',
			 'K-Tech Ownership', 'Unknown Ownership') AS OwnerStatus,
	   pch.StandardCost
FROM [Production].[ProductCostHistory] AS pch;
