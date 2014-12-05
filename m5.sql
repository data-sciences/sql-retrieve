

--file: Module 5 - Aggregate Functions.sql

-- Demo: Aggregate Functions



-- AVG quantity across location/shelf/bin
SELECT	p.Name AS ProductName,
		AVG(pin.Quantity) AS AvgQuantity
FROM [Production].[Product] AS p
INNER JOIN [Production].[ProductInventory] AS pin 
  ON p.ProductID = pin.ProductID
GROUP BY p.Name
ORDER BY p.Name;

SELECT pin.Bin, pin.LocationID, pin.Shelf, 
	   pin.Quantity
FROM [Production].[Product] AS p
INNER JOIN [Production].[ProductInventory] AS pin 
  ON p.ProductID = pin.ProductID
WHERE p.Name = 'Adjustable Race';

SELECT (408 + 324 + 353) / 3;

-- Using CHECKSUM to compute a hash value for each row based on all 
-- columns in the table... (warning - HashBytes may be better at detecting changes)
SELECT CHECKSUM(*) CheckSumVal, ProductID, Name, ProductNumber, MakeFlag, FinishedGoodsFlag, Color, SafetyStockLevel, ReorderPoint, StandardCost, ListPrice, Size, SizeUnitMeasureCode, WeightUnitMeasureCode, Weight, DaysToManufacture, ProductLine, Class, Style, ProductSubcategoryID, ProductModelID, SellStartDate, SellEndDate, DiscontinuedDate, rowguid, ModifiedDate
FROM [Production].[Product] AS p;

-- One row checksum
SELECT CHECKSUM(*) 
FROM [Production].[Product] AS p
WHERE p.ProductID = 1;

-- Will this remain -273937161? 
UPDATE [Production].[Product]
SET ProductNumber = 'AR-538999'
WHERE ProductID = 1;

-- Now it's 1337300156
SELECT CHECKSUM(*) 
FROM [Production].[Product] AS p
WHERE p.ProductID = 1;

-- Setting it back...
UPDATE [Production].[Product]
SET ProductNumber = 'AR-5381'
WHERE ProductID = 1;

-- Now it's -273937161 (what it was originally)
SELECT CHECKSUM(*) 
FROM [Production].[Product] AS p
WHERE p.ProductID = 1;

-- Use CHECKSUM_AGG to see if a table has changed
SELECT CHECKSUM_AGG(CHECKSUM(*)) TableCheckSum
FROM [Production].[Product] AS p;

-- Was 1117395237

-- Will this remain -273937161? 
UPDATE [Production].[Product]
SET ProductNumber = 'AR-538999'
WHERE ProductID = 1;

-- Use CHECKSUM_AGG to see if a table has changed
SELECT CHECKSUM_AGG(CHECKSUM(*)) TableCheckSum
FROM [Production].[Product] AS p;

-- Now its -494698130

-- Setting it back...
UPDATE [Production].[Product]
SET ProductNumber = 'AR-5381'
WHERE ProductID = 1;

-- Back to 1117395237
SELECT CHECKSUM_AGG(CHECKSUM(*)) TableCheckSum
FROM [Production].[Product] AS p;

-- COUNT
SELECT COUNT(*) RowCnt
FROM [Production].[Product] AS p;

SELECT DISTINCT Color
FROM [Production].[Product] AS p;

-- Notice the count doesn't include NULL value
SELECT COUNT(DISTINCT Color)
FROM [Production].[Product] AS p;

-- Count by group
SELECT	p.Name AS ProductName,
		COUNT(pin.Shelf) AS ShelfCount
FROM [Production].[Product] AS p
INNER JOIN [Production].[ProductInventory] AS pin 
  ON p.ProductID = pin.ProductID
GROUP BY p.Name
ORDER BY p.Name;

-- MIN and MAX
SELECT	p.Name AS ProductName,
		MIN(pin.Quantity) AS MinQty,
		MAX(pin.Quantity) AS MaxQty
FROM [Production].[Product] AS p
INNER JOIN [Production].[ProductInventory] AS pin 
  ON p.ProductID = pin.ProductID
GROUP BY p.Name
ORDER BY p.Name;

--file: Module 5 - Aggregate Functions 2.sql

-- Demo: Aggregate Functions (2)



-- SUM
SELECT LocationID,
	   SUM(Quantity) AS QtyByLocationID
FROM [Production].[ProductInventory]
GROUP BY LocationID
ORDER BY LocationID;

SELECT SUM(Quantity) AS TotalQty
FROM [Production].[ProductInventory];

-- STDEV (numbers provided assumed to be a partial sampling of population)
SELECT STDEV(ListPrice) AS STDEVListPrice
FROM [Production].[ProductListPriceHistory];

-- STDEVP (calculations assume complete population of values)
SELECT STDEVP(ListPrice) AS STDEVListPrice
FROM [Production].[ProductListPriceHistory];

-- VAR (statistical variance - partial sample assumed)
SELECT VAR(ListPrice) AS STDEVListPrice
FROM [Production].[ProductListPriceHistory];

-- VARP (statistical variance for the population for all values )
SELECT VARP(ListPrice) AS STDEVListPrice
FROM [Production].[ProductListPriceHistory];

--file: Module 5 - Mathematical Functions.sql

-- Demo: Mathematical Functions



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


--file: Module 5 - Ranking Functions.sql

-- Demo: Ranking Functions



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


--file: Module 5 - Conversion Functions.sql

-- Demo: Conversion Functions



-- PARSE ( string_value AS data_type [ USING culture ] )
SELECT PARSE('12/31/2012' AS date) AS YearEndDateUS;

-- Error converting string value
SELECT PARSE('31/12/2012' AS date USING 'en-US') AS YearEndDate;

-- This works...
SELECT PARSE('31/12/2012' AS date USING 'en-GB') AS YearEndDateUK;

-- TRY_PARSE ( string_value AS data_type [ USING culture ] )
--     from string to date/time and number types

-- Returns a date
SELECT TRY_PARSE('12/31/2012' AS date) AS YearEndDateUS;

-- Returns NULL
SELECT TRY_PARSE('31/12/2012' AS date USING 'en-US') AS YearEndDate;

-- Returns Date
SELECT TRY_PARSE('31/12/2012' AS date USING 'en-GB') AS YearEndDateUK;

--  CAST ( expression AS data_type [ ( length ) ] )

SELECT CAST ('12/31/2012' AS date) AS YearEndDate;

-- Error
SELECT CAST ('13/31/2012' AS date) AS YearEndDate;

-- TRY_CAST ( expression AS data_type [ ( length ) ] )
SELECT TRY_CAST ('13/31/2012'AS date) AS YearEndDate;

-- CONVERT ( data_type [ ( length ) ] , expression [ , style ] )
SELECT CONVERT (date, '12/31/2012', 101) AS YearEndDateUS;

-- Fails
SELECT CONVERT (date, '13/31/2012', 101) AS YearEndDateUS;

-- TRY_CONVERT ( data_type [ ( length ) ], expression [, style ] )
SELECT TRY_CONVERT (date, '13/31/2012', 101) AS YearEndDateUS;

--file: Module 5 - Validating Data Types.sql

-- Demo: Validating Data Types



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

--file: Module 5 - System Time Functions.sql

-- Demo: System Time Functions



SELECT 'SYSDATETIME' AS STFunction, SYSDATETIME();

SELECT 'SYSDATETIMEOFFSET' AS STFunction, SYSDATETIMEOFFSET();

SELECT 'SYSUTCDATETIME' AS STFunction, SYSUTCDATETIME();

SELECT 'CURRENT_TIMESTAMP' AS STFunction, CURRENT_TIMESTAMP;

SELECT 'GETUTCDATE' AS STFunction, GETUTCDATE();

SELECT 'GETDATE' AS STFunction, GETDATE();



--file: Module 5 - Returning Date and Time Parts.sql

-- Demo: Returning Date and Time Parts



SELECT pch.ProductID,
       pch.StartDate,
	   MONTH(pch.StartDate) AS StartMonth,
	   DAY(pch.StartDate) AS StartDay,
	   YEAR(pch.StartDate) AS StartYear
FROM [Production].[ProductCostHistory] AS pch
WHERE pch.EndDate IS NOT NULL;

-- DATEPART ( datepart , date )
SELECT pch.ProductID,
       pch.StartDate,
	   DATEPART(m, pch.StartDate) AS StartMonth,
	   DATEPART(d, pch.StartDate) AS StartDay,
	   DATEPART(yy, pch.StartDate) AS StartYear
FROM [Production].[ProductCostHistory] AS pch
WHERE pch.EndDate IS NOT NULL;

-- DATENAME ( datepart , date )
SELECT pch.ProductID,
       pch.StartDate,
	   DATENAME(m, pch.StartDate) AS StartMonth,
	   DATENAME(d, pch.StartDate) AS StartDay,
	   DATENAME(yy, pch.StartDate) AS StartYear
FROM [Production].[ProductCostHistory] AS pch
WHERE pch.EndDate IS NOT NULL;

--file: Module 5 - Constructing Date and Time Values.sql

-- Demo: Constructing Date and Time Values



-- DATEFROMPARTS ( year, month, day )
-- DATETIMEFROMPARTS ( year, month, day, hour, minute, seconds, milliseconds )
-- DATETIME2FROMPARTS ( year, month, day, hour, minute, seconds, fractions, precision )

SELECT DATEFROMPARTS (2012, 08, 31) AS 'MyDate';

-- All arguments required!
SELECT DATETIMEFROMPARTS (2012, 08) AS 'MyDate';

-- Null returns null
SELECT DATEFROMPARTS (2012, 08, NULL) AS 'MyDate';

--file: Module 5 - Constructing Date and Time Values 2.sql

-- Demo: Constructing Date and Time Values (2)



-- DATETIMEOFFSETFROMPARTS ( year, month, day, hour, minute, seconds, fractions, hour_offset, minute_offset, precision )

-- TIMEFROMPARTS ( hour, minute, seconds, fractions, precision )

-- SMALLDATETIMEFROMPARTS ( year, month, day, hour, minute )

SELECT SMALLDATETIMEFROMPARTS (2012, 7, 23, 3, 17) AS MySmallDateTime;

-- Each argument required!
SELECT DATETIMEOFFSETFROMPARTS (2012);

-- Any null arguments return null
SELECT SMALLDATETIMEFROMPARTS (2012, NULL, 23, 3, 17);

--file: Module 5 - Calculating Time Differences.sql

-- Demo: Calculating Time Differences



-- DATEDIFF ( datepart , startdate , enddate )

-- Years
SELECT DATEDIFF (yy,'1/1/2007', '1/1/2008') AS 'YearDiff';

-- Days
SELECT DATEDIFF (dd,'1/1/2007', '1/1/2008') AS 'DayDiff';

-- Months
SELECT pch.ProductID,
       pch.StartDate,
	   pch.EndDate,
	   DATEDIFF(mm, pch.StartDate, pch.EndDate) AS MonthsStartEnd
FROM [Production].[ProductCostHistory] AS pch
WHERE pch.EndDate IS NOT NULL;


--file: Module 5 - Modifying Dates.sql

-- Demo: Modifying Dates



-- DATEADD (datepart , number , date )
SELECT pch.ProductID,
	   pch.StartDate,
	   DATEADD (yy, 1, pch.StartDate) AS PriceEvaluationDate
FROM [Production].[ProductCostHistory] AS pch;

-- EOMONTH ( start_date [, month_to_add ] )
SELECT pch.ProductID,
	   pch.StartDate,
	   EOMONTH (pch.StartDate) AccountingPeriod
FROM [Production].[ProductCostHistory] AS pch;

SELECT pch.ProductID,
	   pch.StartDate,
	   EOMONTH (pch.StartDate, 1) AccountingPeriod
FROM [Production].[ProductCostHistory] AS pch;

-- SWITCHOFFSET ( DATETIMEOFFSET, time_zone ) 
SELECT pch.ProductID,
	   pch.StartDate,
	   CAST(pch.StartDate as datetimeoffset) 
	      AS StartDateUTC,
	   SWITCHOFFSET(CAST(pch.StartDate as datetimeoffset), '-06:00')
	      AS StartDateUTC_CST
FROM [Production].[ProductCostHistory] AS pch;

-- TODATETIMEOFFSET ( expression , time_zone )
SELECT pch.ProductID,
	   pch.StartDate,
	   TODATETIMEOFFSET(pch.StartDate, '-06:00')
	      AS StartDateUTC_CST
FROM [Production].[ProductCostHistory] AS pch;


--file: Module 5 - Logical Functions.sql

-- Demo: Logical Functions



-- CHOOSE ( index, val_1, val_2 [, val_n ] )
SELECT CHOOSE (2, 'Route 1', 'Route 2', 'Route 3') 
   AS RouteChoice;

SELECT CHOOSE (3, 'Route 1', 'Route 2', 'Route 3') 
   AS RouteChoice;

-- IIF ( boolean_expression, true_value, false_value )
SELECT pch.ProductID,
       pch.StartDate,
	   IIF ( pch.StartDate BETWEEN '12/31/2004' AND '1/1/2006',
			 'K-Tech Ownership', 'Unknown Ownership') AS OwnerStatus,
	   pch.StandardCost
FROM [Production].[ProductCostHistory] AS pch;


--file: Module 5 - Logical Functions 2.sql

-- Demo: Logical Functions (2)



-- Simple CASE
SELECT pch.ProductID,
       pch.StartDate,
	   pch.StandardCost,
	   CASE pch.ProductID
	     WHEN 707 THEN 'Platinum Collection'
		 WHEN 711 THEN 'Silver Collection'
		 WHEN 713 THEN 'Gold Collection'
		 ELSE 'Standard Product'
	   END AS 'Product Status'
FROM [Production].[ProductCostHistory] AS pch;

-- Searched CASE
SELECT pch.ProductID,
       pch.StartDate,
	   CASE 
	      WHEN pch.StartDate BETWEEN '12/31/2004' AND '1/1/2006'
		     THEN 'Owned by K-Tech'
		  WHEN pch.StartDate BETWEEN '12/31/2006' AND '1/1/2008'
		     THEN 'Owned by Z-Tech'
		  ELSE 'Unknown Ownership'
	   END AS 'OwnerStatus',
	   pch.StandardCost
FROM [Production].[ProductCostHistory] AS pch;

--file: Module 5 - Working with NULL.sql

-- Demo: Working with NULLs



-- COALESCE ( expression [ ,...n ] ) 
DECLARE @val1 int = NULL;
DECLARE @val2 int = NULL;
DECLARE @val3 int = 2;
DECLARE @val4 int = 5;

SELECT COALESCE(@val1, @val2, @val3, @val4) 
   AS FirstNonNull;

-- ISNULL
SELECT p.Name,
       ISNULL(p.Color, 'Unknown') AS Color
FROM [Production].[Product] AS p
ORDER BY p.Name;

-- CONCAT_NULL_YIELDS_NULL behavior

SET CONCAT_NULL_YIELDS_NULL ON;
GO

DECLARE @ReportName varchar(20) = NULL;
SELECT 'Report Date:' + @ReportName
   AS ReportHeader;
GO


SET CONCAT_NULL_YIELDS_NULL OFF;
GO

DECLARE @ReportName varchar(20) = NULL;
SELECT 'Report Date:' + @ReportName
   AS ReportHeader;
GO

-- In a future version of SQL Server CONCAT_NULL_YIELDS_NULL will always be ON 


--file: Module 5 - String Functions.sql

﻿-- Demo: String Functions



-- ASCII code value of the leftmost character 
SELECT ASCII('T') AS ASCII_T_int;
SELECT ASCII('t') AS ASCII_t_int;

-- int ASCII code to a character
SELECT CHAR(84) AS ASCII_T_char;
SELECT CHAR(116) AS ASCII_t_char;

-- integer value given Unicode character
SELECT UNICODE(N'Њ') AS Unicode_Cyrillic_int;

-- Output nchar given integer for Unicode character
SELECT NCHAR(1034) AS Unicode_Cyrillic_nchar;




--file: Module 5 - String Functions 2.sql

-- Demo: String Functions (2)



-- LEFT ( character_expression , integer_expression )
-- RIGHT ( character_expression , integer_expression )
SELECT LEFT(p.LastName, 1) +
       '####' +
	   RIGHT(p.LastName, 2) AS Mask
FROM [Person].[Person] AS p;

-- FORMAT ( value, format [, culture ] )
-- See http://bit.ly/MEAOeM for type formats to choose from
SELECT pch.ProductID,
       pch.StartDate,
	   FORMAT(pch.StartDate, 'MMMM dd, yyyy') AS StartDateFmt
FROM [Production].[ProductCostHistory] AS pch
WHERE pch.EndDate IS NOT NULL;


--file: Module 5 - String Functions 3.sql

-- Demo: String Functions (3)



-- LEN vs. DATALENGTH
-- Name column is nvarchar(50) data type
SELECT p.Name,
       LEN(p.Name) AS Name_LEN,
	   DATALENGTH(p.Name) AS Name_DATALENGTH
FROM [Production].[Product] AS p
ORDER BY p.Name;


--file: Module 5 - String Functions 4.sql

-- Demo: String Functions (4)



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


--file: Module 5 - String Functions 5.sql

-- Demo: String Functions (5)



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

--file: Module 5 - String Functions 6.sql

-- Demo: String Functions (6)



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


--file: Module 5 - Analytic Functions.sql

-- Demo: Analytic Functions



-- LAG
/* BOL syntax
	LAG (scalar_expression [,offset] [,default])
		OVER ( [ partition_by_clause ] order_by_clause )
*/

SELECT p.Name ProductName,
	   pch.EndDate,
       pch.StandardCost,
	   LAG(pch.StandardCost, 1, 0.00)
	     OVER (PARTITION BY p.ProductID
		       ORDER BY p.Name, pch.EndDate) AS PreviousStandardCost
FROM [Production].[Product] AS p
INNER JOIN [Production].[ProductCostHistory] AS pch 
  ON p.ProductID = pch.ProductID
ORDER BY p.Name, pch.EndDate, pch.StandardCost;

-- LEAD
/* BOL syntax
	LEAD ( scalar_expression [ ,offset ] , [ default ] ) 
      OVER ( [ partition_by_clause ] order_by_clause )
*/

SELECT p.Name ProductName,
	   pch.EndDate,
       pch.StandardCost,
	   LEAD(pch.StandardCost, 1, 0.00)
	     OVER (PARTITION BY p.ProductID
		       ORDER BY p.Name, pch.EndDate) AS NextStandardCost
FROM [Production].[Product] AS p
INNER JOIN [Production].[ProductCostHistory] AS pch 
  ON p.ProductID = pch.ProductID
ORDER BY p.Name, pch.EndDate, pch.StandardCost;

-- FIRST_VALUE

-- LEAD
/* BOL syntax
	FIRST_VALUE ( [scalar_expression ) 
    OVER ( [ partition_by_clause ] order_by_clause [ rows_range_clause ] ) 

*/

SELECT p.Name ProductName,
	   CAST(pch.StartDate as date) AS StartDate,
       pch.StandardCost,
	   FIRST_VALUE(pch.StandardCost)
	     OVER (PARTITION BY p.ProductID
		       ORDER BY p.Name, pch.StartDate) AS InitialStandardCost
FROM [Production].[Product] AS p
INNER JOIN [Production].[ProductCostHistory] AS pch 
  ON p.ProductID = pch.ProductID
WHERE p.Name IN 
	('AWC Logo Cap', 'Long-Sleeve Logo Jersey, L', 'Sport-100 Helmet, Black')
ORDER BY p.Name, pch.StartDate, pch.StandardCost;

-- LAST_VALUE
/*
	LAST_VALUE ( [scalar_expression ) 
		OVER ( [ partition_by_clause ] order_by_clause rows_range_clause ) 

	Window Frames become important here... (Sampling of options below)

	UNBOUNDED PRECEDING (Window begins at first row of partition)
	UNBOUNDED FOLLOWING (Window ends at last row of partition)
*/

SELECT p.Name ProductName,
	   CAST(pch.StartDate as date) AS StartDate,
       pch.StandardCost,
	   LAST_VALUE(pch.StandardCost)
	     OVER (PARTITION BY p.ProductID
		       ORDER BY p.Name, pch.StartDate
			   RANGE BETWEEN UNBOUNDED PRECEDING AND 
			                 UNBOUNDED FOLLOWING) AS LatestStandardCost
FROM [Production].[Product] AS p
INNER JOIN [Production].[ProductCostHistory] AS pch 
  ON p.ProductID = pch.ProductID
WHERE p.Name IN 
	('AWC Logo Cap', 'Long-Sleeve Logo Jersey, L', 'Sport-100 Helmet, Black')
ORDER BY p.Name, pch.StartDate, pch.StandardCost;

--file: Module 5 - Analytic Functions 2.sql

-- Demo: Analytic Functions (2)



-- CUME_DIST - computes the relative position of a specified value in a group of values
SELECT ps.Name SubCategoryName,
	   p.Name ProductName,
       pch.StandardCost,
	   CUME_DIST () OVER (PARTITION BY ps.ProductSubcategoryID
	                      ORDER BY pch.StandardCost) AS CumeDist
FROM [Production].[Product] AS p
INNER JOIN [Production].[ProductSubcategory] AS ps 
  ON p.ProductSubcategoryID = ps.ProductSubcategoryID
INNER JOIN [Production].[ProductCostHistory] AS pch 
  ON p.ProductID = pch.ProductID
ORDER BY ps.Name, pch.StandardCost;

-- PERCENT_RANK - derived by RANK 
--		(RANK - 1)/(Row Count - 1)
SELECT ps.Name SubCategoryName,
	   p.Name ProductName,
       pch.StandardCost,
	   RANK() OVER (PARTITION BY ps.ProductSubcategoryID
	                      ORDER BY pch.StandardCost) RowRank,
	   PERCENT_RANK () OVER (PARTITION BY ps.ProductSubcategoryID
	                      ORDER BY pch.StandardCost) AS PercentRank
FROM [Production].[Product] AS p
INNER JOIN [Production].[ProductSubcategory] AS ps 
  ON p.ProductSubcategoryID = ps.ProductSubcategoryID
INNER JOIN [Production].[ProductCostHistory] AS pch 
  ON p.ProductID = pch.ProductID
ORDER BY ps.Name, pch.StandardCost;

-- PERCENTILE_CONT (interpolated) - percentile based on a continuous distribution
SELECT ps.Name SubCategoryName,
	   p.Name ProductName,
       pch.StandardCost,
	   PERCENTILE_CONT (0.3) 
	     WITHIN GROUP (ORDER BY pch.StandardCost)
		 OVER (PARTITION BY ps.ProductSubcategoryID) 
		  AS Percentile
FROM [Production].[Product] AS p
INNER JOIN [Production].[ProductSubcategory] AS ps 
  ON p.ProductSubcategoryID = ps.ProductSubcategoryID
INNER JOIN [Production].[ProductCostHistory] AS pch 
  ON p.ProductID = pch.ProductID
ORDER BY ps.Name, pch.StandardCost;

-- PERCENTILE_DISC - percentile based on smallest CUME_DIST value >= percentile
SELECT ps.Name SubCategoryName,
	   p.Name ProductName,
       pch.StandardCost,
	   PERCENTILE_DISC (0.3) 
	     WITHIN GROUP (ORDER BY pch.StandardCost)
		 OVER (PARTITION BY ps.ProductSubcategoryID) 
		  AS Percentile
FROM [Production].[Product] AS p
INNER JOIN [Production].[ProductSubcategory] AS ps 
  ON p.ProductSubcategoryID = ps.ProductSubcategoryID
INNER JOIN [Production].[ProductCostHistory] AS pch 
  ON p.ProductID = pch.ProductID
ORDER BY ps.Name, pch.StandardCost;