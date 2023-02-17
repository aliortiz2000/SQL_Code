-- CREATE TABLES

CREATE TABLE EmployeeDemographics (
    employeeID int,
    firstName varchar (50),
    lastName (50),
    age int,
    gender (1)
)

CREATE TABLE EmployeeSalary (
    employeeID int, 
    jobTitle varchar (50),
    salary int
)

CREATE TABLE WareHouseEmployeeDemographics (
    employeeID int, 
    firstName varchar(50), 
    lastName varchar(50), 
    age int, 
    gender varchar(50)
)

-- SIMPLE SELECTS

SELECT *
FROM EmployeeDemographics /* TutorialSQL_Employee.dbo.EmployeeDemographics */

SELECT firstName, lastName
FROM EmployeeDemographics

SELECT firstName + ' ' + lastName AS Employee
FROM EmployeeDemographics

SELECT *
FROM EmployeeSalary /* TutorialSQL_Employee.dbo.EmployeeSalary */


-- INSERT THE DATA

INSERT INTO EmployeeDemographics VALUES 
(1001, 'Jim', 'Halpert', 30, 'M'),
(1002, 'Pam', 'Beasley', 30, 'F'),
(1003, 'Dwight', 'Schrute', 29, 'M'),
(1004, 'Angela', 'Martin', 31, 'F'),
(1005, 'Toby', 'Flenderson', 32, 'M'),
(1006, 'Michael', 'Scott', 35, 'M'),
(1007, 'Meredith', 'Palmer', 32, 'F'),
(1008, 'Stanley', 'Hudson', 38, 'M'),
(1009, 'Kevin', 'Malone', 31, 'M'),
(1010, 'Tod', 'Fender', 30, 'F'),
(1011, 'Mike', 'Luis', 28, 'M'),
(1012, 'Maria', 'Daza', 25, 'F'),
(1013, 'Steve', 'Harry', 30, 'M'),
(1014, 'Kylie', 'Mata', 29, 'F'),
(1011, 'Ryan', 'Howard', 26, 'M'),
(NULL, 'Holly', 'Flax', NULL, NULL),
(1013, 'Darryl', 'Philbin', NULL, 'M')

INSERT INTO EmployeeSalary VALUES
(1001, 'Salesman', 45000),
(1002, 'Receptionist', 36000),
(1003, 'Salesman', 63000),
(1004, 'Accountant', 47000),
(1005, 'HR', 50000),
(1006, 'Regional Manager', 65000),
(1007, 'Supplier Relations', 41000),
(1008, 'Salesman', 48000),
(1009, 'Accountant', 42000),
(1015, 'National Manager', 70000),
(1016, 'Recruiter', 41000),
(1017, 'Salesman', 45000),
(1018, 'Accountant', 43000)

INSERT INTO WareHouseEmployeeDemographics VALUES
(1013, 'Darryl', 'Philbin', NULL, 'Male'),
(1050, 'Roy', 'Anderson', 31, 'Male'),
(1051, 'Hidetoshi', 'Hasagawa', 40, 'Male'),
(1052, 'Val', 'Johnson', 31, 'Female')



-- USING THE MAX, MIN, AVG, DISTINCT, COUNT FUNCTIONS

SELECT DISTINCT (gender)
FROM EmployeeDemographics

SELECT COUNT (*)
FROM EmployeeDemographics

SELECT MAX (salary)
FROM EmployeeSalary

SELECT MIN (salary)
FROM EmployeeSalary

SELECT AVG (salary)
FROM EmployeeSalary



-- WHERE STATEMENTS USING =, <>, <, >, <=, >=, AND, OR, LIKE, IN, IS NULL, IS NOT NULL

/*
    The WHERE clause is used to filter records. It is used to extract only those records that 
    fulfill a specified condition.
*/

SELECT *
FROM EmployeeDemographics
WHERE age = 31

SELECT *
FROM EmployeeDemographics
WHERE gender <> 'M'

SELECT *
FROM EmployeeDemographics
WHERE lastName LIKE '%a%'

SELECT * 
FROM EmployeeDemographics 
WHERE lastName IS NOT NULL

SELECT * 
FROM EmployeeDemographics 
WHERE lastName IN ('Beasley', 'Scott')

SELECT *
FROM EmployeeDemographics
WHERE lastName LIKE '%a%' OR gender = 'M'

SELECT *
FROM EmployeeSalary
WHERE salary > 60000

SELECT *
FROM EmployeeSalary
WHERE employeeID <= 1005

SELECT *
FROM EmployeeSalary
WHERE employeeID > 1005 AND salary > 60000



-- GROUP BY, ORDER BY

/*
    The GROUP BY statement groups rows that have the same values into summary rows, 
    like "find the number of customers in each country". It's often used with aggregate 
    functions (COUNT(), MAX(), MIN(), SUM(), AVG()) to group the result-set by one or 
    more columns.
*/

/*
    The ORDER BY keyword is used to sort the result-set in ascending or descending order.
    To sort the records in descending order, use the DESC keyword.
*/

SELECT gender, COUNT (gender)
FROM EmployeeDemographics
GROUP BY gender 

SELECT gender, COUNT (gender)
FROM EmployeeDemographics
WHERE age >= 30
GROUP BY gender 

SELECT DISTINCT jobTitle
FROM EmployeeSalary
ORDER BY jobTitle

SELECT jobTitle, salary
FROM EmployeeSalary
ORDER BY 2 DESC



-- JOINS: INNER JOIN, LEFT/RIGHT/FULL OUTER JOIN, SELF JOIN
-- CASE

/*
    The INNER JOIN keyword selects records that have matching values in both tables.

    The LEFT JOIN keyword returns all records from the left table, and the matching 
    records from the right table. The result is 0 records from the right side, if 
    there is no match.

    The RIGHT JOIN keyword returns all records from the right table, and the matching 
    records from the left table (table1). The result is 0 records from the left side, 
    if there is no match.

    The FULL OUTER JOIN keyword returns all records when there is a match in left or 
    right table records.

    A self join is a regular join, but the table is joined with itself.
*/

/* 
    The CASE expression goes through conditions and returns a value when the first 
    condition is met (like an if-then-else statement). So, once a condition is true, 
    it will stop reading and return the result. If no conditions are true, it returns 
    the value in the ELSE clause. If there is no ELSE part and no conditions are true, 
    it returns NULL.
*/

SELECT 
    CASE 
        WHEN ed.gender = 'F' THEN 'Ms. ' +  ed.firstName + ' ' + ed.lastName
        ELSE  'Mr. ' +  ed.firstName + ' ' + ed.lastName 
    END AS Employee,
    ed.age AS Age, es.jobTitle AS Job_Title, es.salary AS Salary
FROM EmployeeDemographics ed JOIN EmployeeSalary es
    ON ed.employeeID = es.employeeID
ORDER BY 3, 4 DESC

SELECT 
    CASE 
        WHEN ed.gender = 'F' THEN 'Ms. ' +  ed.firstName + ' ' + ed.lastName
        ELSE  'Mr. ' +  ed.firstName + ' ' + ed.lastName 
    END AS Employee,
    ed.age AS Age, es.jobTitle AS Job_Title, es.salary AS Salary
FROM EmployeeDemographics ed LEFT JOIN EmployeeSalary es
    ON ed.employeeID = es.employeeID

SELECT 
    CASE 
        WHEN ed.gender = 'F' THEN 'Ms. ' +  ed.firstName + ' ' + ed.lastName
        ELSE  'Mr. ' +  ed.firstName + ' ' + ed.lastName 
    END AS Employee,
    ed.age AS Age, es.jobTitle AS Job_Title, es.salary AS Salary
FROM EmployeeDemographics ed RIGHT JOIN EmployeeSalary es
    ON ed.employeeID = es.employeeID

SELECT 
    CASE 
        WHEN ed.gender = 'F' THEN 'Ms. ' +  ed.firstName + ' ' + ed.lastName
        ELSE  'Mr. ' +  ed.firstName + ' ' + ed.lastName 
    END AS Employee,
    ed.age AS Age, es.jobTitle AS Job_Title, es.salary AS Salary
FROM EmployeeDemographics ed FULL JOIN EmployeeSalary es
    ON ed.employeeID = es.employeeID

SELECT ed.employeeID, ed.firstName, wed.lastName 
FROM EmployeeDemographics ed FULL OUTER JOIN WareHouseEmployeeDemographics wed
	ON ed.employeeID = wed.employeeID

SELECT firstName, lastName, jobTitle, salary, 
    CASE
        WHEN jobTitle = 'Accountant' THEN ROUND ( salary + ( salary * 0.05 ), 0 )
        WHEN jobTitle = 'Salesman' THEN ROUND ( salary + ( salary * 0.10 ), 0 )
        WHEN jobTitle = 'HR' THEN ROUND ( salary + ( salary * 0.01 ), 0 )
        ELSE ROUND ( salary + ( salary * 0.03), 0 )
    END AS bonus
FROM EmployeeDemographics ed FULL JOIN EmployeeSalary es
    ON ed.employeeID = es.employeeID 



-- UNION

/*
    The UNION operator is used to combine the result-set of two or more SELECT statements.
        - Every SELECT statement within UNION must have the same number of columns
        - The columns must also have similar data types
        - The columns in every SELECT statement must also be in the same order
*/

SELECT *
FROM EmployeeDemographics
    UNION ALL 
SELECT *
FROM WareHouseEmployeeDemographics
ORDER BY employeeID

SELECT employeeID, firstName, age
FROM EmployeeDemographics
UNION ALL 
SELECT employeeID, jobTitle, salary
FROM EmployeeSalary
ORDER BY employeeID



-- HAVING

/* 
    The HAVING clause was added to SQL because the WHERE keyword 
    cannot be used with aggregate functions. 
*/

SELECT jobTitle, COUNT (jobTitle)
FROM EmployeeDemographics ed INNER JOIN EmployeeSalary es
    ON ed.employeeID = es.employeeID
GROUP BY jobTitle
HAVING COUNT (jobTitle) > 1

SELECT jobTitle, AVG (salary)
FROM EmployeeDemographics ed INNER JOIN EmployeeSalary es
    ON ed.employeeID = es.employeeID
GROUP BY jobTitle
HAVING AVG (salary) > 45000
ORDER BY 2 



-- UPDATE, DELETE

/*
    The UPDATE statement is used to modify the existing records 
    in a table.

    The DELETE statement is used to delete existing records in 
    a table. Be careful when deleting records in a table! Notice 
    the WHERE clause in the DELETE statement. The WHERE clause 
    specifies which record(s) should be deleted. If you omit the 
    WHERE clause, all records in the table will be deleted!
*/

UPDATE EmployeeDemographics
SET age = 31, gender = 'F', employeeID = 1062
WHERE firstName = 'Holly' AND lastName = 'Flax'

UPDATE EmployeeDemographics
SET age = 30, gender = 'M', employeeID = 1062
WHERE employeeID = 1012

DELETE FROM EmployeeDemographics
WHERE employeeID = 1005



-- PARTITION BY 

/*
    We can use the SQL PARTITION BY clause with the OVER clause to 
    specify the column on which we need to perform aggregation. In 
    the previous example, we used Group By with CustomerCity column 
    and calculated average, minimum and maximum values.
*/

SELECT firstName, lastName, gender, salary, 
    COUNT (gender) OVER (PARTITION BY gender) AS TotalGender
FROM EmployeeDemographics ed JOIN  EmployeeSalary es
    ON ed.employeeID = es.employeeID



-- CTE: Common Table Expression

/*
    A common table expression, or CTE, is a temporary named result 
    set created from a simple SELECT statement that can be used in 
    a subsequent SELECT statement.
*/

WITH CTE_Employee AS (
    SELECT 
        CASE 
            WHEN ed.gender = 'F' THEN 'Ms. ' +  ed.firstName + ' ' + ed.lastName
            ELSE  'Mr. ' +  ed.firstName + ' ' + ed.lastName 
        END AS Employee,
        ed.age AS Age, es.jobTitle AS Job_Title, es.salary AS Salary
    FROM EmployeeDemographics ed JOIN EmployeeSalary es
        ON ed.employeeID = es.employeeID
    ORDER BY 3, 4 DESC
)

SELECT * 
FROM CTE_Employee



-- TEMPORARY TABLE

/*
    Temporary tables in SQL server are similar to permanent database 
    tables that are used for storing intermediate data records. These 
    temporary tables, as the name suggests, exist temporarily on the 
    server. They get deleted once the last connection to the server 
    is closed. Temporary tables are very useful in scenarios when we 
    have a large number of rows in a permanent database table and we 
    have to frequently use some rows of this table. 
*/

CREATE TABLE #temp_Employee (
    employeeID int, 
    jobTitle varchar (50),
    salary int
)

INSERT INTO #temp_Employee VALUES 
(1001, 'HR', 55555)

SELECT * 
FROM #temp_Employee

SELECT employeeID, jobTitle, salary
INTO #temp_Employee2
FROM EmployeeSalary

SELECT * 
FROM #temp_Employee2



-- STRING FUNCTIONS - TRIM, LTRIM, RTRIM, REPLACE, SUBSTRING, UPPER, LOWER

--Drop Table EmployeeErrors;

CREATE TABLE EmployeeErrors (
    employeeID varchar(50),
    firstName varchar(50),
    lastName varchar(50)
)

Insert into EmployeeErrors Values 
('1001  ', 'Jimbo', 'Halbert'), 
('  1002', 'Pamela', 'Beasely'), 
('1005', 'TOby', 'Flenderson - Fired')

SELECT *
FROM EmployeeErrors

SELECT employeeID, TRIM (employeeID) AS IDTRIM
FROM EmployeeErrors

SELECT employeeID, LTRIM (employeeID) AS IDTRIM
FROM EmployeeErrors

SELECT employeeID, RTRIM (employeeID) AS IDTRIM
FROM EmployeeErrors

SELECT lastName, REPLACE (lastName, '- Fired', '') AS LastNameFixed
FROM EmployeeErrors

SELECT SUBSTRING (lastName, 3, 3) 
FROM EmployeeErrors

SELECT SUBSTRING (err.FirstName,1,3), SUBSTRING (dem.FirstName,1,3), SUBSTRING (err.LastName,1,3), SUBSTRING (dem.LastName,1,3)
FROM EmployeeErrors err
JOIN EmployeeDemographics dem
	on SUBSTRING (err.FirstName,1,3) = SUBSTRING (dem.FirstName,1,3)
	and SUBSTRING (err.LastName,1,3) = SUBSTRING (dem.LastName,1,3)

SELECT firstname, LOWER (firstname)
FROM EmployeeErrors

SELECT firstname, UPPER (FirstName)
FROM EmployeeErrors



-- STORE PROCEDURES

/*
    A stored procedure is a prepared SQL code that you can save, 
    so the code can be reused over and over again. So if you have 
    an SQL query that you write over and over again, save it as a 
    stored procedure, and then just call it to execute it.You can 
    also pass parameters to a stored procedure, so that the stored 
    procedure can act based on the parameter value(s) that is passed.
*/

CREATE PROCEDURE Temp_Employee
AS
    DROP TABLE IF EXISTS #temp_employee
    CREATE TABLE #temp_employee (
        JobTitle varchar(100),
        EmployeesPerJob int ,
        AvgAge int,
        AvgSalary int
    )

    INSERT INTO #temp_employee
        SELECT JobTitle, COUNT (JobTitle), AVG (Age), AVG (salary)
        FROM SQLTutorial..EmployeeDemographics emp
        JOIN SQLTutorial..EmployeeSalary sal
            ON emp.EmployeeID = sal.EmployeeID
        GROUP BY JobTitle

    SELECT * 
    FROM #temp_employee
GO;




CREATE PROCEDURE Temp_Employee2 
@JobTitle nvarchar(100)
AS
    DROP TABLE IF EXISTS #temp_employee3
    CREATE TABLE #temp_employee3 (
        JobTitle varchar(100),
        EmployeesPerJob int ,
        AvgAge int,
        AvgSalary int
    )

    INSERT INTO #temp_employee3
        SELECT JobTitle, COUNT (JobTitle), AVG (Age), AVG (salary)
        FROM SQLTutorial..EmployeeDemographics emp
        JOIN SQLTutorial..EmployeeSalary sal
            ON emp.EmployeeID = sal.EmployeeID
        WHERE JobTitle = @JobTitle --- make sure to change this in this script from original above
        GROUP BY JobTitle

    SELECT * 
    FROM #temp_employee3
GO;


EXEC Temp_Employee2 @jobtitle = 'Salesman'
EXEC Temp_Employee2 @jobtitle = 'Accountant'



-- SUBQUERYS

/*
    A subquery is a query that is nested inside a SELECT, INSERT, 
    UPDATE, or DELETE statement, or inside another subquery.
*/

SELECT employeeID, salary, (SELECT AVG (salary) 
                            FROM EmployeeSalary) AS AllAvgSalary
FROM EmployeeSalary

-- How to do it with Partition By
SELECT employeeID, salary, AVG (salary) OVER () AS AllAvgSalary
FROM EmployeeSalary

-- Why Group By doesn't work
SELECT EmployeeID, Salary, AVG(Salary) AS AllAvgSalary
FROM EmployeeSalary
GROUP BY EmployeeID, Salary
ORDER BY EmployeeID

SELECT a.employeeID, a.AllAvgSalary
FROM 
	(SELECT employeeID, salary, AVG (salary) OVER () AS AllAvgSalary
	 FROM EmployeeSalary) a
ORDER BY a.employeeID

Select EmployeeID, JobTitle, Salary
From EmployeeSalary
where EmployeeID in (
	Select EmployeeID 
	From EmployeeDemographics
	where Age > 30)