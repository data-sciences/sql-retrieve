-- Demo: String Functions (4)

USE AdventureWorks2012;

-- LOWER / UPPER
SELECT p.Name,
       LOWER(p.Name) AS LOWER_Name,
	   UPPER(p.Name) AS UPPER_Name
FROM [Production].[Product] AS p
ORDER BY p.Name;

-- LTRIM / RTRIM
DECLARE @ExampleText nvarchar(100) = 
   '  I have leading and trailing spaces   ';

SELECT RTRIM(LTRIM(@ExampleText)) AS ExampleText;
