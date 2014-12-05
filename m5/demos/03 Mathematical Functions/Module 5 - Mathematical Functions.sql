-- Demo: Mathematical Functions

USE AdventureWorks2012;

-- CEILING ( numeric_expression )
-- smallest integer greater than or equal to numeric expression
SELECT plph.ProductID,
	   plph.StartDate,
	   plph.ListPrice,
	   CEILING(plph.ListPrice) AS TaxableListPrice
FROM [Production].[ProductListPriceHistory] AS plph;

-- FLOOR ( numeric_expression )
-- Largest integer less than or equal to the specified expression
SELECT plph.ProductID,
	   plph.StartDate,
	   plph.ListPrice,
	   FLOOR(plph.ListPrice) AS MinTaxableListPrice
FROM [Production].[ProductListPriceHistory] AS plph;

-- ROUND ( numeric_expression , length [ ,function ] )
SELECT plph.ProductID,
	   plph.StartDate,
	   plph.ListPrice,
	   ROUND(plph.ListPrice, 1) AS Round1,
	   ROUND(plph.ListPrice, 2) AS Round2,
	   ROUND(plph.ListPrice, 3) AS Round3,
	   ROUND(plph.ListPrice, -1) AS RoundNeg1
FROM [Production].[ProductListPriceHistory] AS plph;

-- RAND
SELECT RAND() AS RandomVals;
GO 5


-- RAND (with seed value)
SELECT RAND(1) AS RandomVals;
GO 5

-- PI ( )
-- POWER ( float_expression , y )
-- SQRT ( float_expression )

SELECT PI(), POWER(10.00, 2), SQRT(100);
