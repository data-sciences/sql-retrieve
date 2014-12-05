-- Demo: Multi-Attribute Joins

USE AdventureWorks2012;

-- Creating a new table based on [Person].[BusinessEntityAddress]
SELECT BusinessEntityID, AddressID, 
	   AddressTypeID, rowguid, ModifiedDate
INTO [Person].[BusinessEntityAddressArchive]
FROM [Person].[BusinessEntityAddress];

-- Removing an arbitrary 1,500 rows for the demo
DELETE TOP (1500)
FROM [Person].[BusinessEntityAddressArchive];

-- Which rows are in the production table that 
-- are NOT in the archive table?
SELECT bea.BusinessEntityID, bea.AddressID, bea.AddressTypeID, 
	   bea.rowguid, bea.ModifiedDate
FROM [Person].[BusinessEntityAddress] AS bea
LEFT OUTER JOIN [Person].[BusinessEntityAddressArchive] AS abea 
  ON bea.BusinessEntityID = abea.BusinessEntityID AND
     bea.AddressID = abea.AddressID AND
	 bea.AddressTypeID = abea.AddressTypeID
WHERE abea.BusinessEntityID IS NULL;

-- Demo cleanup
DROP TABLE [Person].[BusinessEntityAddressArchive];