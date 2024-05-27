-- Create Database Project_Part_3
CREATE DATABASE Project_Part_3
GO

-- Use Project Part 3 Database
USE Project_Part_3
GO

-- Use Master Database
USE master
GO

-- Drop Project Part 3 Database
DROP DATABASE Project_Part_3
GO

-- Create Table T1
CREATE TABLE T1(
    a INT,
    b INT,
    c INT
)
GO

-- Create Clustered Index on T1.a
CREATE CLUSTERED INDEX idx_T1_a ON T1(a)
GO

-- Create Non-clustered Index on T1.b
CREATE INDEX idx_T1_b ON T1(b)
GO

-- Create Table T2
CREATE TABLE T2(
    a INT,
    b INT
)   
GO

-- Create Clustered Index on T2.a
CREATE CLUSTERED INDEX idx_T2_a ON T2(a)
GO

-- Create Non-clustered Index on T2.b
CREATE INDEX idx_T2_b ON T2(b)
GO

-- Create Table T3
CREATE TABLE T3(
    x INT,
    y INT,
    z INT
)
GO

-- Create Clustered Index on T2.a
CREATE CLUSTERED INDEX idx_T3_x ON T3(x)
GO

-- Create Non-clustered Index on T2.b
CREATE INDEX idx_T3_y ON T3(y)
GO

-- Loop to Insert Data into T1
DECLARE @counter1 INT = 1;
WHILE @counter1 <= 10000
BEGIN
INSERT INTO T1(a, b, c)
VALUES (@counter1, @counter1 + 1, @counter1 + 2);
SET @counter1 = @counter1 + 1
END

-- Loop to Insert Data into T2
DECLARE @counter2 INT = 1;
WHILE @counter2 <= 10000
BEGIN
INSERT INTO T2(a, b)
VALUES (@counter2, @counter2 + 3);
SET @counter2 = @counter2 + 1
END

-- Loop to Insert Data into T3
DECLARE @counter3 INT = 1;
WHILE @counter3 <= 10000
BEGIN
INSERT INTO T3(x, y, z)
VALUES (@counter3, @counter3 * 2, @counter3 + 7);
SET @counter3 = @counter3 + 1
END

-- Query 1
SELECT T1.a, T1.b
FROM T1
WHERE T1.b < 10000 
GO

-- Query 1.1
SELECT T1.a, T1.b
FROM T1 WITH (INDEX(0))
WHERE T1.b < 10000
GO

-- Query 2
SELECT T1.a, T2.b
FROM T1
JOIN T2 ON T1.a = T2.a
WHERE T1.b > 1000
GO

-- Query 2.2
SELECT T1.a, T2.b
FROM T1
JOIN T2 ON T1.a = T2.a
WHERE T1.b > 1000
OPTION (MERGE JOIN)
GO

-- Query 3
SELECT T1.a, T2.b
FROM T1
INNER JOIN T2 ON T1.a = T2.a
WHERE T1.b > 500 OR T2.b < 3000 --- 36
GO

-- Query 3.2
SELECT T1.a, T2.b
FROM T1 WITH (INDEX(0))
INNER JOIN T2 ON T1.a = T2.a
WHERE T1.b > 500 OR T2.b < 3000 --- 28
GO

-- Query 4
SELECT 
    T1.a, 
    COUNT(T2.b) AS T2Count, 
    SUM(T3.z) AS TotalZ
FROM 
    T1
INNER JOIN 
    T2 ON T1.a = T2.a
INNER JOIN 
    T3 ON T1.a = T3.x
WHERE 
    T1.a BETWEEN 1000 AND 5000
GROUP BY 
    T1.a
GO

-- Query 4.2
SELECT 
    T1.a, 
    COUNT(T2.b) AS T2Count, 
    SUM(T3.z) AS TotalZ
FROM 
    T1
INNER JOIN 
    T2 ON T1.a = T2.a
INNER JOIN 
    T3 ON T1.a = T3.x
WHERE 
    T1.a BETWEEN 1000 AND 5000
GROUP BY 
    T1.a
OPTION (MAXDOP 4, MERGE JOIN)
GO

-- Query 5
SELECT T1.a, T1.b, T1.c, T2.a, T2.b, T3.x, T3.y, T3.z
FROM T1
INNER JOIN T2 ON T1.b = T2.b
INNER JOIN T3 ON T2.a = T3.x
WHERE T1.c > 5000 AND T2.b < 8000 AND T3.z BETWEEN 10000 AND 20000
GO

-- Query 5.2
SELECT T1.a, T1.b, T1.c, T2.a, T2.b, T3.x, T3.y, T3.z
FROM T1
INNER JOIN T2 ON T1.b = T2.b
INNER JOIN T3 ON T2.a = T3.x
WHERE T1.c > 5000 AND T2.b < 8000 AND T3.z BETWEEN 10000 AND 20000
OPTION (FORCE ORDER)
GO