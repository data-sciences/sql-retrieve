-- Demo: CROSS and OUTER APPLY Operator

USE AdventureWorks2012;

-- TVF that returns first name, last name, job title and business
--  entity type for the specified contact 
SELECT c.BusinessEntityType, c.FirstName, c.LastName,
       c.JobTitle, c.PersonID
FROM [dbo].[ufnGetContactInformation] (3) AS c;


-- Try to INNER JOIN with a TVF
SELECT c.BusinessEntityType, c.FirstName, c.LastName, c.JobTitle
FROM [Person].[Person] AS p
INNER JOIN [dbo].[ufnGetContactInformation] (p.BusinessEntityID) AS C
WHERE p.LastName LIKE 'Abo%';


-- Now try CROSS APPLY
SELECT c.BusinessEntityType, c.FirstName, c.LastName, c.JobTitle
FROM [Person].[Person] AS p
CROSS APPLY [dbo].[ufnGetContactInformation] (p.BusinessEntityID) AS C
WHERE p.LastName LIKE 'Abo%';

-- OUTER APPLY
SELECT p.LastName, p.FirstName,
       c.BusinessEntityType, c.FirstName, c.LastName, c.JobTitle
FROM [Person].[Person] AS p
OUTER APPLY [dbo].[ufnGetContactInformation] (p.BusinessEntityID) AS C
WHERE p.LastName LIKE 'Abo%';
