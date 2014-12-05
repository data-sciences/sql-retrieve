-- Demo: Constructing Date and Time Values (2)

USE AdventureWorks2012;

-- DATETIMEOFFSETFROMPARTS ( year, month, day, hour, minute, seconds, fractions, hour_offset, minute_offset, precision )

-- TIMEFROMPARTS ( hour, minute, seconds, fractions, precision )

-- SMALLDATETIMEFROMPARTS ( year, month, day, hour, minute )

SELECT SMALLDATETIMEFROMPARTS (2012, 7, 23, 3, 17) AS MySmallDateTime;

-- Each argument required!
SELECT DATETIMEOFFSETFROMPARTS (2012);

-- Any null arguments return null
SELECT SMALLDATETIMEFROMPARTS (2012, NULL, 23, 3, 17);