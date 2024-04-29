-- Create Database for project part 2
CREATE DATABASE Projectpt2
GO

-- Use project part 2 database
USE Projectpt2
GO

-- Use Master and Drop the database
USE master
GO

DROP DATABASE Projectpt2
GO

-- Create Table T1 and T2
CREATE TABLE T1(
    a INT,
    b INT,
    c INT
)
GO

CREATE TABLE T2(
    a INT,
    b INT,
    x INT
)
GO

CREATE TABLE T3(
    x INT
)
GO

-- Create Non-Clustered Index on T1.c
CREATE INDEX idx_T1_c ON T1(c)
GO
-- Create Clustered Index on T1.a
CREATE CLUSTERED INDEX idx_T1_a ON T1(a)
GO
-- Create Clustered Index on T2.a 
CREATE CLUSTERED INDEX idx_T2_a ON T2(a)
GO
-- Create Clustered Index on T3.x
CREATE CLUSTERED INDEX idx_T3_x ON T3(x)
GO

--
SELECT T1.a, T1.b, SUM(T1.c) AS Sum_Tc, T2.x
FROM T1
LEFT OUTER JOIN T2 ON T1.a = T2.a AND T1.c > T2.x
LEFT OUTER JOIN T3 ON T2.x = T3.x
GROUP BY T1.a, T1.b, T2.x;

-- Loop to insert records into T1
DECLARE @counter1 INT = 11;
WHILE @counter1 <= 10000 -- Insert 10 records
BEGIN
    INSERT INTO T1 (a, b, c)
    VALUES (@counter1, @counter1 * 2, @counter1 * 3);
    SET @counter1 = @counter1 + 1;
END;

-- Loop to insert records into T2
DECLARE @counter2 INT = 11;
WHILE @counter2 <= 100 -- Insert 10 records
BEGIN
    INSERT INTO T2 (a, b, x)
    VALUES (@counter2, @counter2 * 2, @counter2 * 4);
    SET @counter2 = @counter2 + 1;
END;

-- Loop to insert records into T3
DECLARE @counter3 INT = 6;
WHILE @counter3 <= 1000 -- Insert 5 records
BEGIN
    INSERT INTO T3 (x)
    VALUES (@counter3 * 5);
    SET @counter3 = @counter3 + 1;
END;
