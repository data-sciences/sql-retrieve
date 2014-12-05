-- Demo: String Functions (2)

USE AdventureWorks2012;

-- LEFT ( character_expression , integer_expression )
-- RIGHT ( character_expression , integer_expression )
SELECT LEFT(p.LastName, 1) +
       '####' +
	   RIGHT(p.LastName, 2) AS Mask
FROM [Person].[Person] AS p;

-- FORMAT ( value, format [, culture ] )
-- See http://bit.ly/MEAOeM for type formats to choose from
SELECT pch.ProductID,
       pch.StartDate,
	   FORMAT(pch.StartDate, 'MMMM dd, yyyy') AS StartDateFmt
FROM [Production].[ProductCostHistory] AS pch
WHERE pch.EndDate IS NOT NULL;
