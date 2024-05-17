-- String Functions

-- Convert to Lowercase
SELECT LOWER('This IS THE ORDER iN KarTHik') AS LowercaseString;

-- Convert to Uppercase
SELECT UPPER('this is THE terminal iN BLue coLouR') AS UppercaseString;

-- Concatenate Strings
SELECT CONCAT('This is the Value ', 'of table in SQL database', ' line of length') AS ConcatenatedString;

-- Trim Whitespace
SELECT TRIM('           this is SQL database                  ') AS TrimmedString;

-- Get Left Part of String
SELECT LEFT('this id is empty Value of string', 15) AS LeftString;

-- Get Right Part of String
SELECT RIGHT('This is fire Accident in place', 22) AS RightString;

-- Get String Length
SELECT LEN('This Product are sales in market') AS StringLength;

-- Get Substring
SELECT SUBSTRING('This is Place to visit in Chennai', 9, 18) AS Substring;

-- Replace Substring
SELECT REPLACE('Microsoft Power Platform', 'Platform', 'Apps and Power BI') AS ReplacedString;

-- Mathematical Functions

-- Absolute Value
SELECT ABS(-23.1254) AS AbsoluteValue;

-- Round Number
SELECT ROUND(12.4, 0) AS RoundedNumber;

-- Floor Value
SELECT FLOOR(12.80) AS FloorValue;

-- Ceiling Value
SELECT CEILING(12.3) AS CeilingValue;

-- Power Calculation
SELECT POWER(2, 5) AS PowerResult;

-- Logarithm
SELECT LOG(10) AS NaturalLogarithm;

-- PI Constant
SELECT PI() AS PIValue;

-- Exponential Function
SELECT EXP(5) AS ExponentialValue;

-- Aggregate Functions

-- Count Rows
SELECT COUNT(*) AS TotalCount FROM Employee;

-- Count Non-Null First Names
SELECT COUNT(FirstName) AS FirstNameCount FROM Employee;

-- Maximum Employee ID
SELECT MAX(EmployeeID) AS MaxEmployeeID FROM Employee;

-- Minimum First Name
SELECT MIN(FirstName) AS MinFirstName FROM Employee;
