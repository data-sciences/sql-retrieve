-- Demo: String Functions (6)

USE AdventureWorks2012;

-- REPLICATE(character_expression,times)
SELECT LEFT(p.LastName, 1) +
       REPLICATE('#', 5) +
	   RIGHT(p.LastName, 2) AS Mask
FROM [Person].[Person] AS p;

-- REVERSE(character_expression)
SELECT LEFT(REVERSE(p.LastName), 3) +
       REPLICATE('#', 5) +
	   RIGHT(REVERSE(p.LastName), 3) Mask
FROM [Person].[Person] AS p;

-- SPACE ( integer_expression )
SELECT LEFT(p.LastName, 1) +
       SPACE(5) +
	   RIGHT(p.LastName, 2) Mask
FROM [Person].[Person] AS p;

-- STR ( float_expression [ , length [ , decimal ] ] )
SELECT (p.LastName + 
       ' ' +
       p.FirstName +
       ':' +
	   EmailPromotion) AS LabelHeader
FROM [Person].[Person] AS p;

SELECT (p.LastName + 
       ' ' +
       p.FirstName +
       ':' +
	   LTRIM(STR(EmailPromotion))) AS LabelHeader
FROM [Person].[Person] AS p;

-- CONCAT ( string_value1, string_value2 [, string_valueN ] )
SELECT CONCAT (p.LastName, ' ', p.FirstName) AS LabelHeader
FROM [Person].[Person] AS p;

-- QUOTENAME ( 'character_string' [ , 'quote_character' ] ) 
DECLARE @ExampleObjectName nvarchar(50) = 'Bad Object Name';
-- Return valid SQL Server delimited identifier
SELECT QUOTENAME(@ExampleObjectName) ;
