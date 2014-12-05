--file: Module 4 - Inner Joins.sql

USE AdventureWorks2008;
go

-- Demo: Inner Join

SELECT p.Name, od.ProductID, 
       od.SalesOrderDetailID, od.OrderQty
FROM [Production].[Product] AS p
INNER JOIN [Sales].[SalesOrderDetail] AS od
 ON p.ProductID = od.ProductID
ORDER BY p.Name, od.SalesOrderDetailID;

-- Almost all joins on keys are called equi-joins - equi for equivalence
-- and the equivalence operator is '=', ie. the equals sign.

-- INNER was optional, but can help for readability
SELECT p.Name, od.ProductID, 
       od.SalesOrderDetailID, od.OrderQty
FROM [Production].[Product] AS p
 JOIN [Sales].[SalesOrderDetail] AS od
 ON p.ProductID = od.ProductID
ORDER BY p.Name, od.SalesOrderDetailID;

-- ANSI SQL-89 syntax
SELECT p.Name, od.ProductID, 
       od.SalesOrderDetailID, od.OrderQty
FROM [Production].[Product] AS p,
     [Sales].[SalesOrderDetail] AS od
WHERE p.ProductID = od.ProductID
ORDER BY p.Name, od.SalesOrderDetailID;

-- ANSI SQL-92 syntax allows a USING clause to specify the equi-join
-- field - if the name is the same in both tables.
-- Not supported by SQL Server.


--file: Module 4 - Outer Joins.sql

-- Demo: Outer Joins

SELECT p.Name, od.ProductID, 
       od.SalesOrderDetailID, od.OrderQty
FROM [Production].[Product] AS p
INNER JOIN [Sales].[SalesOrderDetail] AS od
 ON p.ProductID = od.ProductID
ORDER BY p.Name, od.SalesOrderDetailID;

-- Contrast with LEFT OUTER JOIN
SELECT p.Name, od.ProductID, 
       od.SalesOrderDetailID, od.OrderQty
FROM [Production].[Product] AS p
LEFT OUTER JOIN [Sales].[SalesOrderDetail] AS od
 ON p.ProductID = od.ProductID
ORDER BY p.Name, od.SalesOrderDetailID;

-- What's the difference?
SELECT p.Name, od.ProductID, 
       od.SalesOrderDetailID, od.OrderQty
FROM [Production].[Product] AS p
LEFT OUTER JOIN [Sales].[SalesOrderDetail] AS od
 ON p.ProductID = od.ProductID
WHERE od.ProductID IS NULL
ORDER BY p.Name, od.SalesOrderDetailID;

-- Predicate placement in ON
SELECT p.Name, od.ProductID, 
       od.SalesOrderDetailID, od.OrderQty
FROM [Production].[Product] AS p
LEFT OUTER JOIN [Sales].[SalesOrderDetail] AS od
 ON p.ProductID = od.ProductID AND
	od.OrderQty > 2
ORDER BY p.Name, od.SalesOrderDetailID;

-- Predicate placement in WHERE
SELECT p.Name, od.ProductID, 
       od.SalesOrderDetailID, od.OrderQty
FROM [Production].[Product] AS p
LEFT OUTER JOIN [Sales].[SalesOrderDetail] AS od
 ON p.ProductID = od.ProductID 
WHERE od.OrderQty > 2
ORDER BY p.Name, od.SalesOrderDetailID;

--file: Module 4 - Cross Joins.sql

-- Demo: Cross Joins

-- How many rows?
SELECT COUNT(*)
FROM [HumanResources].[Employee];

-- How many rows?
SELECT COUNT(*)
FROM [HumanResources].[EmployeeDepartmentHistory];

-- What gets returned?
SELECT e.BusinessEntityID, edh.DepartmentID
FROM [HumanResources].[Employee] AS e
CROSS JOIN [HumanResources].[EmployeeDepartmentHistory] AS edh;

-- The math
SELECT 290 * 296;

-- Practical usage - numbers result set
SELECT TOP 100000
		ROW_NUMBER() OVER (ORDER BY sv1.number) AS num
FROM [master].[dbo].[spt_values] sv1
CROSS JOIN [master].[dbo].[spt_values] sv2;

--file: Module 4 - Self Joins.sql

-- Demo: Self Joins

-- Self-joins are very common, if the mapping is one-to-N then 
-- they have to indirect using a a link table.
-- Typical application is a parts database. A large assembly will 
-- comprise sub-assemblies and those sub-assemblies the atomic parts.

-- This is a simple example. Every employee has one manager.

-- Adding a column for this demo
ALTER TABLE [HumanResources].[Employee]
ADD [ManagerID] int NULL;
GO

-- The CEO doesn't have a manager (except the shareholders)
UPDATE [HumanResources].[Employee]
SET  ManagerID  = 1
WHERE BusinessEntityID <> 1;

-- Show the Employee / Manager relationship
SELECT e.BusinessEntityID, e.HireDate,
	   e.ManagerID, m.HireDate
FROM [HumanResources].[Employee] AS e
LEFT OUTER JOIN [HumanResources].[Employee] AS m
 ON e.ManagerID = m.BusinessEntityID;

-- Demo cleanup
ALTER TABLE [HumanResources].[Employee]
DROP COLUMN [ManagerID];
GO


--file: Module 4 - Equi vs Non-Equi Joins.sql

-- Demo: Equi vs. Non-Equi Joins
-- An equi join is when equivalence is used, ie. the equals sign, is
-- used to compare.

SELECT sod.SalesOrderID,
	   sod.SalesOrderDetailID,
	   sod.ProductID,
	   sod.OrderQty,
	   so.SpecialOfferID,
	   sod.ModifiedDate,
	   so.StartDate,
	   so.EndDate,
	   so.Description
FROM [Sales].[SalesOrderDetail] AS sod
INNER JOIN [Sales].[SpecialOffer] AS so
 ON so.SpecialOfferID = sod.SpecialOfferID 
    AND sod.ModifiedDate < so.EndDate 
	AND sod.ModifiedDate >= so.StartDate
WHERE so.SpecialOfferID > 1;


--file: Module 4 - Multi Attribute Joins.sql

-- Demo: Multi-Attribute Joins

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

--file: Module 4 - Joining More than Two Tables.sql

-- Demo: Joining More than Two Tables

-- INNER JOIN multi-table join example
-- Show actual execution plan (compare logical to physical)
SELECT p.Name AS [ProductName], 
	   pc.Name AS [CategoryName],
	   ps.Name AS [SubcategoryName]
FROM [Production].[Product] AS p
INNER JOIN [Production].[ProductSubcategory] AS ps
  ON p.ProductSubcategoryID = ps.ProductSubcategoryID
INNER JOIN [Production].[ProductCategory] AS pc
  ON ps.ProductCategoryID = pc.ProductCategoryID
ORDER BY [ProductName], [CategoryName], [SubcategoryName];

-- OUTER JOIN multi-table join example with logical issue
SELECT p.Name, sod.SalesOrderDetailID
FROM [Production].[Product] AS p
LEFT OUTER JOIN [Sales].[SalesOrderDetail] AS sod
  ON p.ProductID = sod.ProductID
INNER JOIN [Sales].[SpecialOffer] AS so
  ON sod.SpecialOfferID = so.SpecialOfferID
ORDER BY p.Name, sod.SalesOrderDetailID;

-- Fixing the logical issue
SELECT p.Name, sod.SalesOrderDetailID
FROM [Production].[Product] AS p
LEFT OUTER JOIN [Sales].[SalesOrderDetail] AS sod
  ON p.ProductID = sod.ProductID
LEFT OUTER JOIN [Sales].[SpecialOffer] AS so
  ON sod.SpecialOfferID = so.SpecialOfferID
ORDER BY p.Name, sod.SalesOrderDetailID;

--file: Module 4 - CROSS APPLY Operator.sql

-- Demo: CROSS and OUTER APPLY Operator



-- TVF that returns first name, last name, job title and business
--  entity type for the specified contact 
SELECT c.BusinessEntityType, c.FirstName, c.LastName,
       c.JobTitle, c.PersonID
FROM [dbo].[ufnGetContactInformation] (3) AS c;

/*
-- Try to INNER JOIN with a TVF
SELECT c.BusinessEntityType, c.FirstName, c.LastName, c.JobTitle
FROM [Person].[Person] AS p
INNER JOIN [dbo].[ufnGetContactInformation] (p.BusinessEntityID) AS C
WHERE p.LastName LIKE 'Abo%';
*/

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


--file: Module 4 - Joining to Sub-queries.sql

-- Demo: Using Sub-queries

-- Joining to a sub-query
SELECT sod.SalesOrderDetailID, sod.SalesOrderID,
       soh.SalesPersonID
FROM [Sales].[SalesOrderDetail] AS sod
INNER JOIN (SELECT SalesOrderID, SalesPersonID
            FROM [Sales].[SalesOrderHeader]
			WHERE AccountNumber = '10-4020-000510') AS soh 
	ON sod.SalesOrderID = soh.SalesOrderID;

-- This could be re-written as follows
SELECT sod.SalesOrderDetailID, sod.SalesOrderID,
       soh.SalesPersonID
FROM [Sales].[SalesOrderDetail] AS sod
INNER JOIN [Sales].[SalesOrderHeader] AS soh 
	ON sod.SalesOrderID = soh.SalesOrderID
WHERE AccountNumber = '10-4020-000510';

-- Non-correlated sub-query in a predicate
SELECT sod.SalesOrderDetailID, sod.SalesOrderID
FROM [Sales].[SalesOrderDetail] AS sod
WHERE sod.SalesOrderID IN 
	(SELECT SalesOrderID 
	 FROM [Sales].[SalesOrderHeader]
	 WHERE AccountNumber = '10-4020-000510');

-- Correlated sub-query join
SELECT soh.SalesOrderID
FROM [Sales].[SalesOrderHeader] AS soh
WHERE soh.SalesOrderID IN
	(SELECT SalesOrderID
	 FROM [Sales].[SalesOrderDetail] AS sod
	 WHERE soh.SalesOrderID = sod.SalesOrderID AND
	       sod.OrderQty > 2);




--file: Module 4 - UNION Operator.sql

-- Demo: Using Sub-queries



-- Joining to a sub-query
SELECT sod.SalesOrderDetailID, sod.SalesOrderID,
       soh.SalesPersonID
FROM [Sales].[SalesOrderDetail] AS sod
INNER JOIN (SELECT SalesOrderID, SalesPersonID
            FROM [Sales].[SalesOrderHeader]
			WHERE AccountNumber = '10-4020-000510') AS soh 
	ON sod.SalesOrderID = soh.SalesOrderID;

-- This could be re-written as follows
SELECT sod.SalesOrderDetailID, sod.SalesOrderID,
       soh.SalesPersonID
FROM [Sales].[SalesOrderDetail] AS sod
INNER JOIN [Sales].[SalesOrderHeader] AS soh 
	ON sod.SalesOrderID = soh.SalesOrderID
WHERE AccountNumber = '10-4020-000510';

-- Non-correlated sub-query in a predicate
SELECT sod.SalesOrderDetailID, sod.SalesOrderID
FROM [Sales].[SalesOrderDetail] AS sod
WHERE sod.SalesOrderID IN 
	(SELECT SalesOrderID 
	 FROM [Sales].[SalesOrderHeader]
	 WHERE AccountNumber = '10-4020-000510');

-- Correlated sub-query join
SELECT soh.SalesOrderID
FROM [Sales].[SalesOrderHeader] AS soh
WHERE soh.SalesOrderID IN
	(SELECT SalesOrderID
	 FROM [Sales].[SalesOrderDetail] AS sod
	 WHERE soh.SalesOrderID = sod.SalesOrderID AND
	       sod.OrderQty > 2);




--file: Module 4 - INTERSECT and EXCEPT.sql

-- Demo: INTERSECT and EXCEPT Operators



-- We'll create some data discrepencies
SELECT SalesOrderID, SalesOrderDetailID, CarrierTrackingNumber, OrderQty, ProductID, SpecialOfferID, UnitPrice, UnitPriceDiscount, LineTotal, rowguid, ModifiedDate
INTO [Sales].[SalesOrderDetail_A]
FROM [Sales].[SalesOrderDetail];

SELECT SalesOrderID, SalesOrderDetailID, CarrierTrackingNumber, OrderQty, ProductID, SpecialOfferID, UnitPrice, UnitPriceDiscount, LineTotal, rowguid, ModifiedDate
INTO [Sales].[SalesOrderDetail_B]
FROM [Sales].[SalesOrderDetail];

DELETE TOP (15) 
FROM [Sales].[SalesOrderDetail_A];

UPDATE TOP (750) [Sales].[SalesOrderDetail_B]
SET UnitPrice = 9.9999
WHERE OrderQty = 9;

-- Which rows match between the two tables?
SELECT SalesOrderID, SalesOrderDetailID, CarrierTrackingNumber, OrderQty, ProductID, SpecialOfferID, UnitPrice, UnitPriceDiscount, LineTotal, rowguid, ModifiedDate
FROM [Sales].[SalesOrderDetail_A]
INTERSECT
SELECT SalesOrderID, SalesOrderDetailID, CarrierTrackingNumber, OrderQty, ProductID, SpecialOfferID, UnitPrice, UnitPriceDiscount, LineTotal, rowguid, ModifiedDate
FROM [Sales].[SalesOrderDetail_B];

-- Which rows are in A but not B?
SELECT SalesOrderID, SalesOrderDetailID, CarrierTrackingNumber, OrderQty, ProductID, SpecialOfferID, UnitPrice, UnitPriceDiscount, LineTotal, rowguid, ModifiedDate
FROM [Sales].[SalesOrderDetail_A]
EXCEPT
SELECT SalesOrderID, SalesOrderDetailID, CarrierTrackingNumber, OrderQty, ProductID, SpecialOfferID, UnitPrice, UnitPriceDiscount, LineTotal, rowguid, ModifiedDate
FROM [Sales].[SalesOrderDetail_B];

-- Which rows are in B but not A?
SELECT SalesOrderID, SalesOrderDetailID, CarrierTrackingNumber, OrderQty, ProductID, SpecialOfferID, UnitPrice, UnitPriceDiscount, LineTotal, rowguid, ModifiedDate
FROM [Sales].[SalesOrderDetail_B]
EXCEPT
SELECT SalesOrderID, SalesOrderDetailID, CarrierTrackingNumber, OrderQty, ProductID, SpecialOfferID, UnitPrice, UnitPriceDiscount, LineTotal, rowguid, ModifiedDate
FROM [Sales].[SalesOrderDetail_A];

-- Cleanup
DROP TABLE [Sales].[SalesOrderDetail_A];
DROP TABLE [Sales].[SalesOrderDetail_B];

--file: Module 4 - Introduction to CTEs.sql

-- Demo: Introduction to Common Table Expressions



-- Simple CTE reference
WITH ProductQty AS
	(SELECT ProductID, LocationID, Shelf, Bin, Quantity
	 FROM [Production].[ProductInventory])
SELECT ProductID, SUM(Quantity) SumQuantity
FROM ProductQty
GROUP BY ProductID;

-- Optional target column list
WITH ProductQty (PID, LID, Shelf, Bin, Qty) AS
	(SELECT ProductID, LocationID, Shelf, Bin, Quantity
	 FROM [Production].[ProductInventory])
SELECT PID, LID, Shelf, Bin, Qty
FROM ProductQty;

-- Multiple references to the same CTE
WITH ProductQty (PID, LID, Shelf, Bin, Qty) AS
	(SELECT ProductID, LocationID, Shelf, Bin, Quantity
	 FROM [Production].[ProductInventory])
SELECT p1.PID, 
       SUM(p1.Qty) AS ShelfQty_A, 
	   SUM(p2.Qty) AS ShelfQty_B
FROM ProductQty AS p1
INNER JOIN ProductQty AS p2 
 ON p1.PID = p2.PID
WHERE p1.Shelf = 'A' AND
      p2.Shelf = 'B'
GROUP BY p1.PID;

-- Multiple CTEs per statement
WITH ProductQty AS
	(SELECT ProductID, LocationID, Shelf, Bin, Quantity
	 FROM [Production].[ProductInventory]),

	 ListPriceHistory AS
	 (SELECT ProductID, StartDate, EndDate, ListPrice
	  FROM [Production].[ProductListPriceHistory]
	  WHERE ListPrice > 10.00)

SELECT p.ProductID, SUM(p.Quantity) SumQuantity
FROM ProductQty AS p
INNER JOIN ListPriceHistory AS lp
 ON p.ProductID = lp.ProductID
GROUP BY p.ProductID;