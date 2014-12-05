-- Demo: String Functions (5)

USE AdventureWorks2012;

-- CHARINDEX ( expression1, expression2 [ , start_location ] ) 
SELECT pd.ProductDescriptionID, 
	   CHARINDEX('alloy', pd.[Description]) 
	      AS StartLocation,
       pd.[Description]
FROM [Production].[ProductDescription] AS pd
WHERE CHARINDEX('alloy', pd.[Description]) > 0;

SELECT pd.ProductDescriptionID, 
	   CHARINDEX('%alloy%', pd.[Description]) 
	      AS StartLocation,
       pd.[Description]
FROM [Production].[ProductDescription] AS pd
WHERE CHARINDEX('%alloy%', pd.[Description]) > 0;

-- PATINDEX
SELECT pd.ProductDescriptionID, 
	   PATINDEX('%all%', pd.[Description]) 
	      AS StartLocation,
       pd.[Description]
FROM [Production].[ProductDescription] AS pd
WHERE PATINDEX('%all%', pd.[Description]) > 0 AND
     CHARINDEX('alloy', pd.[Description]) = 0;

-- REPLACE ( string_expression , string_pattern , string_replacement )
SELECT pd.ProductDescriptionID, 
       REPLACE(pd.[Description], 'alloy', 'mixture') ModifiedDescription
FROM [Production].[ProductDescription] AS pd
WHERE PATINDEX('%alloy%', pd.[Description]) > 0;

-- STUFF (character_expression, start , length,character_expression)
DECLARE @PhoneCallNotes nvarchar(max) =
  'The AdventureWorks client had an issue with the recent shipment.';

DECLARE @StartLocation int = 
   PATINDEX('%AdventureWorks%', @PhoneCallNotes);

SELECT STUFF(@PhoneCallNotes, @StartLocation, 14, '"Anonymous"');

-- SUBSTRING(character_expression, position, length)
SELECT p.Name,
       p.ProductNumber,
	   SUBSTRING(p.ProductNumber, 4, 21) AS EndCode
FROM [Production].[Product] AS p;