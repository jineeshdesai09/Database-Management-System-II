-- Create Department Table
CREATE TABLE Department(
 DepartmentID INT PRIMARY KEY,
 DepartmentName VARCHAR(100) NOT NULL UNIQUE
);

-- Create Designation Table
CREATE TABLE Designation (
 DesignationID INT PRIMARY KEY,
 DesignationName VARCHAR(100) NOT NULL UNIQUE
);

-- Create Person Table
CREATE TABLE Person (
 PersonID INT PRIMARY KEY IDENTITY(101,1),
 FirstName VARCHAR(100) NOT NULL,
 LastName VARCHAR(100) NOT NULL,
 Salary DECIMAL(8, 2) NOT NULL,
 JoiningDate DATETIME NOT NULL,
 DepartmentID INT NULL,
 DesignationID INT NULL,
 FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID),
 FOREIGN KEY (DesignationID) REFERENCES Designation(DesignationID)
);

--Part � A
--1. Department, Designation & Person Table�s INSERT, UPDATE & DELETE Procedures.

--DEPARTMENT

--INSERT
CREATE OR ALTER PROCEDURE PR_INSERT_DEPARTMENT
@DEPARTMENTID INT , 
@DEPARTMENTNAME VARCHAR(100)
AS
BEGIN
	INSERT INTO Department VALUES
	(@DEPARTMENTID , @DEPARTMENTNAME)
END

EXEC PR_INSERT_DEPARTMENT 1 , 'ADMIN';
EXEC PR_INSERT_DEPARTMENT 2 , 'IT';
EXEC PR_INSERT_DEPARTMENT 3 , 'HR';
EXEC PR_INSERT_DEPARTMENT 4 , 'ACCOUNT';

--UPDATE
CREATE OR ALTER PROCEDURE PR_UPDATE_DEPARTMENT
@DEPARTMENTID INT , 
@DEPARTMENTNAME VARCHAR(100)
AS
BEGIN
	UPDATE Department
	SET DepartmentName = @DEPARTMENTNAME
	WHERE DepartmentID = @DEPARTMENTID
END

--DELETE
CREATE OR ALTER PROCEDURE PR_DELETE_DEPARTMENT
@DEPARTMENTID INT
AS
BEGIN
	DELETE FROM Department WHERE DepartmentID = @DEPARTMENTID
END

EXEC PR_DELETE_DEPARTMENT 11;
SELECT * FROM Department;

--Designation

--INSERT

CREATE OR ALTER PROCEDURE PR_INSERT_DESIGNATION
@DESIGNATIONID INT, 
@DESIGNATIONNAME VARCHAR(100)
AS
BEGIN
	INSERT INTO Designation VALUES
	(@DESIGNATIONID , @DESIGNATIONNAME)
END

EXEC PR_INSERT_DESIGNATION 11 , 'JOBBER';
EXEC PR_INSERT_DESIGNATION 12 , 'WELDER';
EXEC PR_INSERT_DESIGNATION 13 , 'CLERK';
EXEC PR_INSERT_DESIGNATION 14 , 'MANAGER';
EXEC PR_INSERT_DESIGNATION 15 , 'CEO';

SELECT * FROM Designation;


--UPDATE
CREATE OR ALTER PROCEDURE PR_UPDATE_DESIGNATION
@DESIGNATIONID INT, 
@DESIGNAME VARCHAR(100)
AS
BEGIN
	UPDATE Designation
	SET DesignationName = @DESIGNAME
	WHERE DesignationID = @DESIGNATIONID
END

--DELETE
CREATE OR ALTER PROCEDURE PR_DELETE_DESIGNATION
@DESIGNATIONID INT
AS
BEGIN
	DELETE FROM Designation WHERE DesignationID = @DESIGNATIONID
END


--PERSON

--INSERT

CREATE OR ALTER PROCEDURE PR_INSERT_PERSON
@FIRSTNAME VARCHAR(100),
@LASTNAME VARCHAR(100),
@SALARY DECIMAL(8,2),
@JOINGDATE DATETIME,
@DEPARTMENTID INT,
@DESIGNATIONID INT
AS
BEGIN
	INSERT INTO Person VALUES
	(@FIRSTNAME , @LASTNAME , @SALARY , @JOINGDATE , @DEPARTMENTID , @DESIGNATIONID)
END

EXEC PR_INSERT_PERSON 'RAHUL','ANSHU',56000,'1990-01-01',1, 12;
EXEC PR_INSERT_PERSON 'Hardik','Hinsu',18000,'1990-09-25',2, 11;
EXEC PR_INSERT_PERSON 'Bhavin','Kamani',25000,'1991-05-14',NULL, 11;
EXEC PR_INSERT_PERSON 'Bhoomi','Patel',39000,'2014-02-20',1, 13;
EXEC PR_INSERT_PERSON 'Rohit','Rajgor',17000,'1990-07-23',2, 15;
EXEC PR_INSERT_PERSON 'Priya','Mehta',25000,'1990-10-18',2, NULL;
EXEC PR_INSERT_PERSON 'Neha','Trivedi',18000,'2014-02-20',3, 15;


SELECT * FROM Person;


--UPDATE

CREATE OR ALTER PROCEDURE PR_UPDATE_PERSON
@PERSONID INT,
@FIRSTNAME VARCHAR(100),
@LASTNAME VARCHAR(100),
@SALARY DECIMAL(8,2),
@JOINGDATE DATETIME,
@DEPARTMENTID INT,
@DESIGNATIONID INT
AS
BEGIN
	UPDATE Person
	SET FirstName = @FIRSTNAME,
	LastName = @LASTNAME,
	Salary = @SALARY,
	JoiningDate = @JOINGDATE,
	DepartmentID = @DEPARTMENTID,
	DesignationID = @DESIGNATIONID
	WHERE PersonID = @PERSONID
END

--DELETE
CREATE OR ALTER PROCEDURE PR_DELETE_PERSON
@PERSONID INT
AS
BEGIN
	DELETE FROM Person WHERE PersonID = @PERSONID
END

--2. Department, Designation & Person Table�s SELECTBYPRIMARYKEY

--PERSON
CREATE OR ALTER PROCEDURE PR_PERSON_SELECTALL
@PERSONID INT
AS
BEGIN
	SELECT * FROM Person WHERE PersonID = @PERSONID
END

EXEC PR_PERSON_SELECTALL 101;

--DEPARTMENT
CREATE OR ALTER PROCEDURE PR_DEPARTMENT_SELECTALL
@DID INT
AS
BEGIN
	SELECT * FROM Department WHERE DepartmentID = @DID;
END

EXEC PR_DEPARTMENT_SELECTALL 1

--DESIGNATION
CREATE OR ALTER PROCEDURE PR_DESIGNATION_SELECTALL
@DESIGNATIONID INT
AS
BEGIN
	SELECT * FROM Designation WHERE DesignationID = @DESIGNATIONID;
END

EXEC PR_DESIGNATION_SELECTALL 11

--3. Department, Designation & Person Table�s (If foreign key is available then do write join and take
--columns on select list)
CREATE PROCEDURE PR_PERSON_SELECT
AS
BEGIN
		SELECT
		Person.PersonID,
		Person.FirstName,
		Person.LastName,
		Person.Salary,
		Person.JoiningDate,
		Department.DepartmentName,
		Designation.DesignationName
	FROM Person
	INNER JOIN
	Department
	ON Person.DepartmentID = Department.DepartmentID
	INNER JOIN
	Designation
	ON Person.DesignationID = Designation.DesignationID
END

EXEC PR_PERSON_SELECT

--4. Create a Procedure that shows details of the first 3 persons.
CREATE PROCEDURE PR_PERSON_SELECT_TOP
AS
BEGIN	SELECT TOP 3
		Person.PersonID,
		Person.FirstName,
		Person.LastName,
		Person.Salary,
		Person.JoiningDate,
		Department.DepartmentName,
		Designation.DesignationName
	FROM Person
	INNER JOIN
	Department
	ON Person.DepartmentID = Department.DepartmentID
	INNER JOIN
	Designation
	ON Person.DesignationID = Designation.DesignationID
END

EXEC PR_PERSON_SELECT_TOP

--Part � B

--5. Create a Procedure that takes the department name as input and returns a table with all workers working in that department.
CREATE OR ALTER PROC PR_DEPARTMENTWISEWORKERS
@DEPTNAME VARCHAR(50)
AS
BEGIN 
	SELECT * FROM Person INNER JOIN Department
	ON Person.DepartmentID = Department.DepartmentID
	WHERE Department.DepartmentName = @DEPTNAME;
END

EXEC PR_DEPARTMENTWISEWORKERS 'IT'

--6. Create Procedure that takes department name & designation name as input and returns a table with worker�s first name, salary, joining date & department name.
CREATE OR ALTER PROC PR_DEPARTMENT_WORKERDETAIL
@DEPTNAME VARCHAR(50),
@DESIGNAME VARCHAR(50)
AS
BEGIN 
	SELECT Person.FirstName,Person.Salary,Person.JoiningDate,Department.DepartmentName
	FROM Person
	INNER JOIN Department
	ON Person.DepartmentID = Department.DepartmentID
	INNER JOIN Designation
	ON Person.DesignationID = Designation.DesignationID
	WHERE Department.DepartmentName = @DEPTNAME 
	OR Designation.DesignationName = @DESIGNAME;
END

EXEC PR_DEPARTMENT_WORKERDETAIL 'ADMIN' , 'CEO';

--7. Create a Procedure that takes the first name as an input parameter and display all the details of the worker with their department & designation name.
CREATE OR ALTER PROC PR_PERSON_WORKERDETAIL
@FIRSTNAME VARCHAR(50)
AS 
BEGIN
	SELECT *
	FROM Person
	INNER JOIN Department
	ON Person.DepartmentID = Department.DepartmentID
	INNER JOIN Designation
	ON Person.DesignationID = Designation.DesignationID
	WHERE Person.FirstName = @FIRSTNAME;
END

EXEC PR_PERSON_WORKERDETAIL 'RAHUL';

--8. Create Procedure which displays department wise maximum, minimum & total salaries.
CREATE OR ALTER PROC PR_DEPARTMENT_DEPARTMENTWISESALARY
AS
BEGIN
	SELECT MIN(Person.Salary) AS MINIMUM_SALARY,
		   MAX(Person.Salary) AS MAXIMUM_SALARY,
		   SUM(Person.Salary) AS TOTAL_SALARY,
		   Department.DepartmentName
	FROM Person INNER JOIN Department
	ON Person.DepartmentID = Department.DepartmentID
	GROUP BY Department.DepartmentName;
END

EXEC PR_DEPARTMENT_DEPARTMENTWISESALARY

--9. Create Procedure which displays designation wise average & total salaries.
CREATE OR ALTER PROC PR_DEPARTMENT_DESIGNATIONWISESALARY
	@DESIGNATIONNAME VARCHAR(100)
AS
BEGIN
	SELECT MIN(Person.Salary) AS MINIMUM_SALARY,
		   MAX(Person.Salary) AS MAXIMUM_SALARY,
		   SUM(Person.Salary) AS TOTAL_SALARY,
		   Designation.DesignationName
	FROM Person INNER JOIN Designation
	ON Person.DesignationID = Designation.DesignationID
	GROUP BY Designation.DesignationName;
END

EXEC PR_DEPARTMENT_DESIGNATIONWISESALARY 'JOBBER'

--Part � C

--10. Create Procedure that Accepts Department Name and Returns Person Count.
CREATE OR ALTER PROC PR_Department_PersonCount
@DEPTNAME VARCHAR(50)
AS
BEGIN
	SELECT COUNT(Person.PersonID) AS COUNT_EMPLOYEE FROM
	Person INNER JOIN Department
	ON Person.DepartmentID = Department.DepartmentID
	WHERE Department.DepartmentName = @DEPTNAME;
END

EXEC PR_Department_PersonCount 'ADMIN'


--11. Create a procedure that takes a salary value as input and returnsall workerswith a
--salarygreater than input salary value along with their department and designation details.
CREATE OR ALTER PROC PR_Department_Salary
@SALARY DECIMAL(8,2)
AS
BEGIN
	SELECT *
	FROM Person
	INNER JOIN Department
	ON Person.DepartmentID = Department.DepartmentID
	INNER JOIN Designation
	ON Person.DesignationID = Designation.DesignationID
	WHERE Person.Salary > @SALARY
END

EXEC PR_Department_Salary 10000;

--12. Create a procedure to find the department(s) with the highest total salary among all departments.
CREATE OR ALTER PROC PR_Department_HighestSalary
AS
BEGIN
	SELECT MAX(Person.Salary) AS MAXIMUM_SALARY,Department.DepartmentName
	FROM Person INNER JOIN Department
	ON Person.DepartmentID = Department.DepartmentID
	GROUP BY Department.DepartmentName;
END

EXEC PR_Department_HighestSalary

--13. Create a procedure that takes a designation name as input and returns a list of all 
--workers under that designation who joined within the last 10 years, along with their department.
CREATE OR ALTER PROC PR_Designation_WorkerDetails
@DESIGNAME VARCHAR(50)
AS
BEGIN
	SELECT *
	FROM Person
	INNER JOIN Department
	ON Person.DepartmentID = Department.DepartmentID
	INNER JOIN Designation
	ON Person.DesignationID = Designation.DesignationID
	WHERE YEAR(Person.JoiningDate) < 10;
END

EXEC PR_Designation_WorkerDetails 'CEO';

--14. Create a procedure to list the number of workers in each department who do not have a designation assigned.
CREATE OR ALTER PROC PR_Department_NoDesignation
AS
BEGIN
	SELECT COUNT(Person.PersonID) AS COUNT_EMPLOYEE
	FROM Person
	INNER JOIN Department
	ON Person.DepartmentID = Department.DepartmentID
	INNER JOIN Designation
	ON Person.DesignationID = Designation.DesignationID
	WHERE Designation.DesignationName IS NULL
	GROUP BY Department.DepartmentName
END

EXEC PR_Department_NoDesignation

SELECT * FROM Designation
--15. Create a procedure to retrieve the details of workers in departments where the average salary is above 12000.
CREATE PROCEDURE PR_Department_AvgSalary
AS
BEGIN
    -- Retrieve details of workers in departments where average salary is above 12000
    SELECT p.PersonID, p.FirstName, p.salary, d.DepartmentName, des.DesignationName
    FROM Person p
	INNER JOIN Department d
	ON p.DepartmentID = d.DepartmentID
	INNER JOIN Designation des
	ON p.DesignationID = des.DesignationID
    WHERE p.DepartmentID IN (
        SELECT DepartmentID
        FROM PERSON
        GROUP BY DepartmentID
        HAVING AVG(salary) > 12000
    );
END;

EXEC PR_Department_AvgSalary;