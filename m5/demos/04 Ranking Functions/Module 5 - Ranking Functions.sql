-- Demo: Ranking Functions

USE AdventureWorks2012;

-- ROW_NUMBER ( ) OVER ( [ <partition_by_clause> ] <order_by_clause> )

SELECT  p.ProductID,
		p.Name,
		ROW_NUMBER() OVER (ORDER BY p.ProductID) AS RowNum
FROM [Production].[Product] AS p
ORDER BY p.ProductID;

SELECT  p.Color,
		p.Name,
		ROW_NUMBER() OVER (PARTITION BY p.Color
		                   ORDER BY p.Name) AS RowNum
FROM [Production].[Product] AS p
WHERE p.Color IS NOT NULL
ORDER BY p.Color, p.Name;

-- RANK ( ) OVER ( [ < partition_by_clause > ] < order_by_clause > )
SELECT  p.Name,
		p.StandardCost,
		RANK() OVER (ORDER BY p.StandardCost DESC) 
		   AS CostRank
FROM [Production].[Product] AS p
ORDER BY p.StandardCost DESC;

-- DENSE_RANK ( ) OVER ( [ <partition_by_clause> ] < order_by_clause > )
SELECT  p.Name,
		p.StandardCost,
		DENSE_RANK() OVER (ORDER BY p.StandardCost DESC) 
		   AS CostRank
FROM [Production].[Product] AS p
ORDER BY p.StandardCost DESC;

-- NTILE (integer_expression) OVER ( [ <partition_by_clause> ] < order_by_clause > )

SELECT  p.Name,
		p.StandardCost,
		NTILE(5) OVER (ORDER BY p.StandardCost DESC) 
		   AS CostRank
FROM [Production].[Product] AS p
ORDER BY p.StandardCost DESC;
