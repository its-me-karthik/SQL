Cursors 

Static cursor:
CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DateOfBirth DATE,
);
DECLARE @FirstName VARCHAR(50), @LastName VARCHAR(50) —- variable declaration

DECLARE static_cursor CURSOR STATIC FOR —- cursor declaration
SELECT StudentID, FirstName
FROM Students;

OPEN static_cursor;

FETCH NEXT FROM static_cursor INTO @FirstName, @LastName; —- fetches first row


WHILE @@FETCH_STATUS = 0 —- loop
BEGIN
    
    PRINT @FirstName + ' ' + @LastName;

    FETCH NEXT FROM static_cursor INTO @FirstName, @LastName;
END;

CLOSE static_cursor;
DEALLOCATE static_cursor;

Key set cursor:

CREATE TABLE Students (
    StudentID INT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DateOfBirth DATE,
);
INSERT INTO Students (StudentID, FirstName, LastName, DateOfBirth)
VALUES
    (1, 'karthik', 'Ajai', '2000-05-15'),
    (2, 'Sam', 'sandy', '1999-08-20'),
    (3, 'Raj', 'Kumar', '2001-02-10'),
    (4, 'Emily', 'Brown', '2002-11-30'),
    (5, 'William', 'Davis', '2003-07-25');
 SELECT * from Students;

DECLARE @StudentID VARCHAR(50), @FirstName VARCHAR(50), @LastName VARCHAR(50);
DECLARE keyset_cursor CURSOR KEYSET FOR
SELECT StudentID, FirstName, LastName
FROM Students;

OPEN keyset_cursor;


FETCH LAST FROM keyset_cursor INTO @StudentID, @FirstName, @LastName;


WHILE @@FETCH_STATUS = 0
BEGIN
    
    PRINT @StudentID + ' ' + @FirstName + ' ' + @LastName;
	Select @StudentID as StdId, @FirstName as FirstName , @LastName AS Lastname;

    
    FETCH PRIOR FROM keyset_cursor INTO @StudentID, @FirstName, @LastName;
END;

CLOSE keyset_cursor;
DEALLOCATE keyset_cursor;

Forward only cursor:

CREATE TABLE AuditTable (
    AuditID INT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    ModifiedDate DATE,
);
INSERT INTO AuditTable (AuditID, FirstName, LastName, ModifiedDate)
VALUES
    (1, 'karthik', 'Ajai', '2000-05-15'),
    (2, 'Sam', 'sandy', '1999-08-20'),
    (3, 'Raj', 'Kumar', '2001-02-10'),
    (4, 'Emily', 'Brown', '2002-11-30'),
    (5, 'William', 'Davis', '2003-07-25');
 SELECT * from AuditTable; 

DECLARE @FirstName VARCHAR(50), @LastName VARCHAR(50)

DECLARE forward_only_cursor CURSOR FORWARD_ONLY FOR
SELECT AuditID, ModifiedDate
FROM AuditTable;

OPEN forward_only_cursor;

FETCH NEXT FROM forward_only_cursor INTO @FirstName, @LastName;

-- Process the fetched rows
WHILE @@FETCH_STATUS = 0
BEGIN
    -- Do something with the fetched data
    PRINT @FirstName + ' ' + @LastName;

    FETCH NEXT FROM forward_only_cursor INTO @FirstName, @LastName;
END;

CLOSE forward_only_cursor;
DEALLOCATE forward_only_cursor;

Dynamic cursor:

CREATE TABLE Department (
    DeptID INT,
    DepartmentName VARCHAR(50),
    ModifiedDate DATE,
);
INSERT INTO Department (DeptID, DepartmentName, ModifiedDate)
VALUES
    (1, 'John', '2000-05-15'),
    (2, 'Jane', '1999-08-20'),
	(3, 'Michael', '2001-02-10'),
    (4, 'Emily', '2002-11-30'),
    (5, 'William', '2003-07-25');
 SELECT * from Department; 

DECLARE @DeptID VARCHAR(50), @DepartmentName VARCHAR(50), @ModifiedDate VARCHAR(50)

DECLARE dynamic_cursor CURSOR DYNAMIC FOR
SELECT *
FROM Department;

OPEN dynamic_cursor;

FETCH LAST FROM dynamic_cursor INTO @DeptID, @DepartmentName ,@ModifiedDate;

-- Process the fetched rows
WHILE @@FETCH_STATUS = 0
BEGIN
    -- Do something with the fetched data
    -- Here, I'm updating the DepartmentName for each row
    UPDATE Department
    SET DepartmentName = @DepartmentName
    WHERE DeptID = @DeptID;
    
	 Select @DeptID as DeptId, @DepartmentName as DeptName ,@ModifiedDate as Ondate;
    -- Fetch the next row
    FETCH PRIOR FROM dynamic_cursor INTO @DeptId, @DepartmentName ,@ModifiedDate;
END;

CLOSE dynamic_cursor;
DEALLOCATE dynamic_cursor;

TRIGGERS

USE TestDB;


CREATE TABLE Workers (
    EmployeeID INT PRIMARY KEY,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    Salary DECIMAL(10, 2)
);
-- Inserting sample values into the Workers table
INSERT INTO Workers (EmployeeID, FirstName, LastName, Salary)
VALUES 
    (1, 'John', 'Doe', 50000.00),
    (2, 'Jane', 'Smith', 60000.00),
    (3, 'Michael', 'Johnson', 75000.00),
    (4, 'Emily', 'Williams', 1000.00);

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TRIGGER [dbo].[altertriggerchange]
ON [dbo].[Workers]
INSTEAD OF INSERT
AS
BEGIN
    -- Check if any inserted row has a salary equal to 1000
    IF EXISTS (SELECT 1 FROM inserted WHERE salary = 1000)
    BEGIN
        RAISERROR ('Salary cannot be equal to 1000', 16, 1)
        ROLLBACK TRANSACTION;
    END;
    ELSE
    BEGIN
        -- If no row has a salary equal to 1000, proceed with the insert
        INSERT INTO Employee
        SELECT * FROM inserted;
    END;
END;

– – After triggers– –
USE Tempdb

GO


CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    HireDate DATE
);


CREATE TABLE IF NOT EXISTS AuditTable (
    AuditID INT PRIMARY KEY,
    Action VARCHAR(10),
    EmployeeID INT,
    ModifiedDate DATETIME
);


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[AfterAuditChange]
ON [dbo].[Employees]
AFTER INSERT
AS
BEGIN
    IF EXISTS (SELECT * FROM inserted)
    BEGIN
        INSERT INTO AuditTable (Action, EmployeeID, ModifiedDate)
        SELECT 'INSERT', EmployeeID, GETDATE() FROM inserted;
    END;
END;









JOINS

Inner join:
USE TestDB;


CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departmonts(id)
);


INSERT INTO employees (id, name, department_id) VALUES
(1, 'John Doe', 1),
(2, 'Jane Smith', 2),
(3, 'Michael Johnson', 1),
(4, 'Emily Brown', 3);


CREATE TABLE departmonts (
    id INT PRIMARY KEY,
    name VARCHAR(50)
);


INSERT INTO departmonts (id, name) VALUES
(1, 'HR'),
(2, 'Marketing'),
(3, 'Finance');

– – Inner Join – – All matched rows
SELECT employees.name AS employee_name, departmonts.name AS department_name
FROM employees
INNER JOIN departmonts ON employees.department_id = departmonts.id;

– – Right Join – – matched rows and all rows in right table
SELECT employees.name AS employee_name, departmonts.name AS department_name
FROM employees
RIGHT JOIN departmonts ON employees.department_id = departmonts.id;

– – Left Join – – matching rows and all rows in left table 
SELECT employees.name AS employee_name, departmonts.name AS department_name
FROM employees
LEFT JOIN departmonts ON employees.department_id = departmonts.id;

– – full outer join – –
SELECT employees.name AS employee_name, departmonts.name AS department_name
FROM employees
FULL OUTER JOIN departmonts ON employees.department_id = departmonts.id;

– – Cross join – –
CREATE TABLE table1(
    id INT PRIMARY KEY,
    name VARCHAR(50)
);

CREATE TABLE table2 (
    id INT PRIMARY KEY,
    description VARCHAR(50)
);

INSERT INTO table1 (id, name) VALUES
(1, 'A'),
(2, 'B');

INSERT INTO table2 (id, description) VALUES
(1, 'X'),
(2, 'Y'),
(3, 'Z'); 


SELECT table1.name AS table1_name, table2.description AS table2_description
FROM table1
CROSS JOIN table2;


Having
CREATE TABLE orderss (
    order_id INT,
    customer_id INT,
    order_amount DECIMAL(10, 2)
);


INSERT INTO orderss (order_id, customer_id, order_amount)
VALUES
    (1, 101, 5000.00),
    (2, 102, 200.00),
    (3, 101, 800.00),
    (4, 103, 3500.00),
    (5, 104, 300.00);

SELECT customer_id, SUM(order_amount) AS total_order_amount
FROM orderss
GROUP BY customer_id
HAVING SUM(order_amount) > 1000;

Order by:

USE Tempdb

CREATE TABLE Employes (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    HireDate DATE
);

INSERT INTO Employes (EmployeeID, FirstName, LastName, HireDate)
VALUES (1, 'John', 'Doe', '2020-01-15'),
       (2, 'Jane', 'Smith', '2019-08-20'),
       (3, 'Alice', 'Johnson', '2021-03-10'),
       (4, 'Bob', 'Williams', '2022-05-05');


SELECT * FROM Employes
ORDER BY HireDate Asc;

GroupBy
USE tempdb


CREATE TABLE Sales (
    Product VARCHAR(50),
    Category VARCHAR(50),
    Amount DECIMAL(10, 2)
);


INSERT INTO Sales (Product, Category, Amount)
VALUES 
    ('Laptop', 'Electronics', 1500.00),
    ('Printer', 'Electronics', 500.00),
    ('Chair', 'Furniture', 100.00),
    ('Desk', 'Furniture', 300.00),
    ('Headphones', 'Electronics', 200.00),
    ('Table', 'Furniture', 250.00),
    ('TV', 'Electronics', 1200.00);

-- total sales amount by category--
SELECT Category, SUM(Amount) AS TotalSales
FROM Sales
GROUP BY Category;




