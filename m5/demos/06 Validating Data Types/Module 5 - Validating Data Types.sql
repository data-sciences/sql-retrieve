-- Demo: Validating Data Types

USE AdventureWorks2012;

-- ISDATE
DECLARE @Name nvarchar(50) = 'XY14822';
DECLARE @DiscontinuedDate datetime = '12/4/2012';

SELECT ISDATE(@Name) AS NameISDATE,
       ISDATE(@DiscontinuedDate) AS DiscontinuedDateISDATE;
GO

-- ISNUMERIC
DECLARE @Name nvarchar(50) = 'XY14822';
DECLARE @DiscontinuedDate datetime = '12/4/2012';
DECLARE @DaysToManufacture int = 100;

SELECT ISNUMERIC(@Name) AS NameISNUMERIC,
       ISNUMERIC(@DiscontinuedDate) AS DiscontinuedDateISNUMERIC,
	   ISNUMERIC(@DaysToManufacture) AS DaysToManufactureISNUMERIC;