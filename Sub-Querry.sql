CREATE TABLE DatabaseTable(
Name VARCHAR(50),
RollNo int,
Location VARCHAR(50),
Phone VARCHAR(50)
)

CREATE TABLE StudentTable(
Name VARCHAR(50),
RollNo int,
Section VARCHAR(50)
)

INSERT INTO DatabaseTable (Name,RollNo,Location,Phone)
VALUES ( 'Karrhik','105','Chennai','2736824')

INSERT INTO StudentTable (Name,RollNo,Section)
VALUES ( 'Ajai','104','Pondicherry')

SELECT * FROM DatabaseTable

SELECT * FROM StudentTable

--Syntax:

--SELECT column_name FROM table_name  WHERE   column_name expression operator 
--( SELECT COLUMN_NAME  from TABLE_NAME  WHERE ... );


SELECT  
     Name, 
	 Location  	 
FROM  
     DatabaseTable  	 
WHERE 
     RollNo IN(
	    SELECT  
	       RollNo   
	    FROM  
		   StudentTable  
		WHERE 
		   Section = 'B' 
	); 


CREATE TABLE CUSTOMERS (
   ID INT NOT NULL,
   NAME VARCHAR (20) NOT NULL,
   AGE INT NOT NULL,
   ADDRESS CHAR (25),
   SALARY DECIMAL (18, 2)       
   
);

INSERT INTO CUSTOMERS VALUES 
(1, 'Ramesh', 32, 'Ahmedabad', 2000.00 ),
(2, 'Khilan', 25, 'Delhi', 1500.00 ),
(3, 'Kaushik', 23, 'Kota', 2000.00 ),
(4, 'Chaitali', 25, 'Mumbai', 6500.00 ),
(5, 'Hardik', 27, 'Bhopal', 8500.00 ),
(6, 'Komal', 22, 'Hyderabad', 4500.00 ),
(7, 'Muffy', 24, 'Indore', 10000.00 );


--Syntax

--WITH CTE_NAME (column_name) AS (query)
--SELECT * FROM CTE_NAME;

WITH 
CUSTOMERDETAILS AS (
SELECT * FROM customers WHERE AGE = 25)
SELECT ID, NAME, AGE FROM CUSTOMERDETAILS ;


---CTE Multiple Table

--Syntax

--WITH
--   CTE_NAME1 (column_name) AS (query),
--  CTE_NAME2 (column_name) AS (query)
--SELECT * FROM CTE_NAME1
--UNION ALL
--SELECT * FROM CTE_NAME2;

---Statement

WITH
CUSTOMERS_IN_DELHI AS (
   SELECT * FROM CUSTOMERS WHERE ADDRESS = 'Delhi'),
CUSTOMERS_IN_MUMBAI AS (
   SELECT * FROM CUSTOMERS WHERE ADDRESS = 'Mumbai')
SELECT ID, NAME, ADDRESS FROM CUSTOMERS_IN_DELHI
UNION ALL
SELECT ID, NAME, ADDRESS FROM CUSTOMERS_IN_MUMBAI;
