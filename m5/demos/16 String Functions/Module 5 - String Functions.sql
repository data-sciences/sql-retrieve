-- Demo: String Functions

USE AdventureWorks2012;

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


