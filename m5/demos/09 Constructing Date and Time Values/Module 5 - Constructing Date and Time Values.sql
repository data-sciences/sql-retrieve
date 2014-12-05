-- Demo: Constructing Date and Time Values

USE AdventureWorks2012;

-- DATEFROMPARTS ( year, month, day )
-- DATETIMEFROMPARTS ( year, month, day, hour, minute, seconds, milliseconds )
-- DATETIME2FROMPARTS ( year, month, day, hour, minute, seconds, fractions, precision )

SELECT DATEFROMPARTS (2012, 08, 31) AS 'MyDate';

-- All arguments required!
SELECT DATETIMEFROMPARTS (2012, 08) AS 'MyDate';

-- Null returns null
SELECT DATEFROMPARTS (2012, 08, NULL) AS 'MyDate';