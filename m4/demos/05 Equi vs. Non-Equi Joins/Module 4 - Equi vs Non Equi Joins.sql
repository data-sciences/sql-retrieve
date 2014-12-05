-- Demo: Equi vs. Non-Equi Joins

USE AdventureWorks2012;

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
