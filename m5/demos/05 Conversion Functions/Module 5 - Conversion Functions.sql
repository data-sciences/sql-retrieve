-- Demo: Conversion Functions

USE AdventureWorks2012;

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