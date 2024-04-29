-- Create Database Named Project1
CREATE DATABASE Project1
GO

-- Switch To Project1
USE Project1
GO

-- Switch To Master
USE master
GO

-- Dropping The Project1 Database using Master
DROP DATABASE Project1
GO

-- Create Table Address
CREATE TABLE Address(
    A_ID INT NOT NULL UNIQUE,
    Apt_house_no VARCHAR(20),
    Street_Name VARCHAR(50),
    City VARCHAR(50),
    Zipcode DECIMAL(5,0)
)
GO

-- Create Table Departments
CREATE TABLE Departments(
    D_ID INT NOT NULL UNIQUE,
    D_Name VARCHAR(50),
    Office_Sec VARCHAR(10),
    Budget_Allocation DECIMAL(10,2)
)
GO

-- Create Table Employees
CREATE TABLE Employees(
    EID INT NOT NULL UNIQUE,
    E_First_Name VARCHAR(50),
    E_Last_Name VARCHAR(50),
    Email VARCHAR(50),
    Phone VARCHAR(15),
    Job_Title VARCHAR(50),
    Dept_ID INT,
    Address_ID INT DEFAULT NULL,
    Salary DECIMAL(10,2),
)
GO

-- Query For Inserting Records in Address Table
INSERT INTO Address(A_ID, Apt_house_no, Street_Name, City, Zipcode)
VALUES
    (1, 742, 'Rosewood and Elk', 'Tacoma', 74256),
    (2, 666, 'Pine St North', 'Pullyalup', 33333),
    (3, 777, 'Market Street', 'Kirkland', 98934),
    (4, 4523, 'MLK Way North', 'Bain Bridge', 66666),
    (5, 103, '55th Avondale N', 'Seattle', 65429),
    (6, 7789, '81 Madsion St', 'Kent', 88888)
GO

-- Query For Inserting Records in Departments Table
INSERT INTO Departments(D_ID, D_Name, Office_Sec, Budget_Allocation)
VALUES
    (1, 'HR', 'A1', 100000.00),
    (2, 'Cloud', 'B7', 700000.00),
    (3, 'R&D', 'C12', 3000000.00),
    (4, 'Artificial Intelligence', 'B6', 600000.00),
    (5, 'Sales', 'C9', 200000),
    (6, 'Marketing', 'F8', 350000.00),
    (7, 'IT', 'G13', 6000000),
    (8, 'Accounting', 'D2', 2500000.00),
    (9, 'Customer Service', 'A14', 400000.00)
GO

-- Query For Inserting Records in Employees Table
INSERT INTO Employees (EID, E_First_Name, E_Last_Name, Email, Phone, Job_Title, Dept_ID, Address_ID, Salary)
VALUES 
    (101, 'John', 'Doe', 'john.doe@example.com', '123-456-7890', 'Software Engineer', 1, 1, 75000),
    (102, 'Jane', 'Smith', 'jane.smith@example.com', '234-567-8901', 'QA Engineer', 9, 4, 70000),
    (201, 'Alice', 'Johnson', 'alice.johnson@example.com', '345-678-9012', 'Marketing Specialist', 3, 2, 60000),
    (202, 'Bob', 'Williams', 'bob.williams@example.com', '456-789-0123', 'Marketing Analyst', 4, 5, 55000),
    (301, 'Michael', 'Brown', 'michael.brown@example.com', '567-890-1234', 'Financial Analyst', 6, 4,65000),
    (302, 'Emily', 'Jones', 'emily.jones@example.com', '678-901-2345', 'Accountant', 5, 3, 60000),
    (401, 'John', 'Doesnt', 'john.doesnt@example.com', '333-888-7890', 'Database Optimizer', 1, 2, 150000),
    (402, 'Janet', 'Smithson', 'janet.smithson@example.com', '234-567-9999', 'React Developer', 1, 3, 90000),
    (111, 'Jammie', 'Holt', 'Jammie.jholt@example.com', '115-000-9012', 'Devops Specialist', 2, 5, 98000),
    (112, 'Marley', 'Bob', 'marley.bobbers@example.com', '896-969-0963', 'Hiring Manager', 2, 6, 82000),
    (211, 'Chris', 'Meddle', 'chris.meddle@example.com', '711-911-1284', 'IT Technician', 3, 3, 59000),
    (212, 'Wilkins', 'Joanna', 'wilkins.joanna@example.com', '789-789-7420', 'Social Media Director', 3, 2, 72000),
    (501, 'Jonnah', 'Paul', 'jonnah.paul@example.com', '420-000-7890', 'Team Lead', 5, 1, 110000),
    (502, 'Janice', 'Murinko', 'janice.Murinko@example.com', '888-999-8989', 'QA Manager', 3, 4, 94000),
    (601, 'Philomina', 'Dmello', 'Phil.Dme@example.com', '665-555-4331', 'Accountant', 4, 2, 57000),
    (602, 'Billy', 'Bob', 'bob.billy@example.com', '333-928-5479', 'Inventory Manager', 6, 1, 78000),
    (511, 'Scotty', 'Daniel', 'Scotty.daniel@example.com', '732-777-1114', 'Public Relations', 4, 3,72000),
    (512, 'Eleanor', 'Ivy', 'eleanor.ivy@example.com', '425-281-4445', 'Cloud Developer', 8, 2, 130000),
    (611, 'Katherine', 'Rodrigues', 'Kat.Rodz@example.com', '434-792-2210', 'UX Designer', 9, 1, 97000),
    (612, 'Philip', 'Margot', 'Margot.Philip@example.com', '717-590-0010', 'General Director', 9, 3, 140000)
GO

-- Adding Primary Key Constarints to Address Table
ALTER TABLE dbo.Address
ADD CONSTRAINT PK_Address PRIMARY KEY (A_ID);
GO

-- Adding Primary Key Constraint to Departments Table
ALTER TABLE Departments
ADD CONSTRAINT PK_Departments PRIMARY KEY (D_ID);
GO

-- Adding Primary Key Constraint to Employees Table
ALTER TABLE Employees
ADD CONSTRAINT PK_Employees PRIMARY KEY (EID);
GO

-- Linking Employees Table and Address Table Via Foreign Key In Employees Table
ALTER TABLE Employees
ADD CONSTRAINT FK_Address
FOREIGN KEY (Address_ID)
REFERENCES dbo.Address(A_ID);
GO

-- Linking Employees Table and Departments Table Via Foreign Key In Employees Table
ALTER TABLE Employees
ADD CONSTRAINT FK_Department
FOREIGN KEY (Dept_ID)
REFERENCES Departments(D_ID);
GO

-- Query to retrieve employees with a specific job title
SELECT 
    E.Job_Title AS Title,
    E.E_First_Name AS First_Name,
    A.Street_Name AS Street_Name,
    D.Budget_Allocation AS Budget
FROM 
    Employees E
JOIN 
    Departments D ON E.Dept_ID = D.D_ID
JOIN 
    dbo.Address A ON E.Address_ID = A.A_ID
WHERE 
    E.Job_Title = 'Software Engineer' OR
    D.D_ID < 5 OR
    A.Street_Name LIKE 'M%' OR
    D.Budget_Allocation > 1000000
ORDER BY
    E.E_First_Name ASC;

-- Create Unclustered Index On Employees Table
CREATE INDEX idx_compound ON Employees(E_First_Name);
GO

-- Query For Dropping Unclustered Index On Employees Table
DROP INDEX Employees.idx_compound
GO

-- Create Unclustered Index On Departments Table
CREATE INDEX idx_compound2 ON Departments(D_ID,Budget_Allocation);
GO

-- Query For Dropping Unclustered Index On Departments Table
DROP INDEX Departments.idx_compound2
GO

-- Create Unclustered Index On Address Table
CREATE INDEX idx_compound3 ON dbo.Address(A_ID,Street_Name);
GO

-- Query For Dropping Unclustered Index On Address Table
DROP INDEX dbo.Address.idx_compound3
GO