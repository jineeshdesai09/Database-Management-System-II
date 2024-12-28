--Part – A
--1. Write a function to print "hello world".
CREATE OR ALTER FUNCTION FN_HELLOWORLD()
	RETURNS VARCHAR(100)
AS
BEGIN
	RETURN 'HELLO WORLD';
END

SELECT DBO.FN_HELLOWORLD();

--2. Write a function which returns addition of two numbers.
CREATE OR ALTER FUNCTION FN_ADDTWONUMBER(@NUM1 INT, @NUM2 INT)
	RETURNS INT
AS
BEGIN
	RETURN @NUM1+@NUM2;
END

SELECT DBO.FN_ADDTWONUMBER(5,5);
--3. Write a function to check whether the given number is ODD or EVEN.
CREATE OR ALTER FUNCTION FN_EVENORODD(@NUM INT)
	RETURNS VARCHAR(50)
AS
BEGIN
	DECLARE @RESULT VARCHAR(10)
	IF @NUM%2=0
		SET @RESULT = 'EVEN';
	ELSE
		SET @RESULT = 'ODD';
	RETURN @RESULT;
END

SELECT DBO.FN_EVENORODD(9);
--4. Write a function which returns a table with details of a person whose first name starts with B.
CREATE OR ALTER FUNCTION FN_FNAMEB()
	RETURNS TABLE
AS
	RETURN(SELECT * FROM PERSON WHERE FirstName LIKE 'B%');

SELECT * FROM FN_FNAMEB();
--5. Write a function which returns a table with unique first names from the person table.
CREATE OR ALTER FUNCTION FN_UNIQUEFNAME()
	RETURNS TABLE
AS
	RETURN(SELECT DISTINCT FirstName FROM PERSON);

SELECT * FROM FN_UNIQUEFNAME();
--6. Write a function to print number from 1 to N. (Using while loop)
CREATE OR ALTER FUNCTION FN_1TON(@NUM INT)
	RETURNS VARCHAR(100)
AS
BEGIN
	DECLARE @I INT=1
	DECLARE @N VARCHAR(100) = '';
	WHILE @I <= @NUM
		BEGIN
			SET @N = @N + CAST(@I AS VARCHAR) + ' '
			SET @I = @I+1
		END
		RETURN @N
END

SELECT DBO.FN_1TON(10)
--7. Write a function to find the factorial of a given integer.
CREATE OR ALTER FUNCTION FN_FACTORIAL(@NUM INT)
	RETURNS INT
AS
BEGIN
	DECLARE @I INT=1
	DECLARE @FAC INT=1;
	WHILE @I <= @NUM
		BEGIN
			SET @FAC = @FAC *@I
			SET @I = @I+1
		END
		RETURN @FAC
END

SELECT DBO.FN_FACTORIAL(5)
--Part – B
--8. Write a function to compare two integers and return the comparison result. (Using Case statement)
CREATE OR ALTER FUNCTION FN_COMPARISON(@NUM1 INT, @NUM2 INT)
	RETURNS VARCHAR(50)
AS
BEGIN
	RETURN
	CASE
		WHEN @NUM1>@NUM2 THEN CAST(@NUM1 AS VARCHAR)+ ' IS GREATER THAN ' +CAST(@NUM2 AS VARCHAR)
		WHEN @NUM1<@NUM2 THEN CAST(@NUM1 AS VARCHAR)+ ' IS LESS THAN ' +CAST(@NUM2 AS VARCHAR)
		ELSE 'BOTH ARE EQUALS'
	END
END;
SELECT DBO.FN_COMPARISON(50,25)
--9. Write a function to print the sum of even numbers between 1 to 20.
CREATE OR ALTER FUNCTION FN_SUMOFEVENNUMBERS()
	RETURNS INT
AS
BEGIN
	DECLARE @RESULT INT=0;
	DECLARE @I INT=1;
	WHILE @I<=20
		BEGIN
			IF @I%2=0
				SET @RESULT+=@I;
			SET @I=@I+1;
		END
	RETURN @RESULT
END

SELECT DBO.FN_SUMOFEVENNUMBERS();
--10. Write a function that checks if a given string is a palindrome
CREATE OR ALTER FUNCTION FN_PALINDROME(@STRING VARCHAR(100))
	RETURNS VARCHAR(100)
AS
BEGIN
	DECLARE @REVERSE VARCHAR(100) = REVERSE(@STRING);
	DECLARE @RESULT VARCHAR(100);
	IF @STRING = @REVERSE
		SET @RESULT = 'PALINDROME'
	ELSE
		SET @RESULT = 'NOT PALINDROME'
	RETURN @RESULT
END

SELECT DBO.FN_PALINDROME('MADAM');

 -----------------------------------------------Part-C-------------------------------------------------
--11. Write a function to check whether a given number is prime or not.
CREATE OR ALTER FUNCTION FN_CHECKPRIME(@NUM INT)
	RETURNS VARCHAR(50)
AS
BEGIN
	DECLARE @I INT = 2
	DECLARE @COUNT INT = 0
	DECLARE @RESULT VARCHAR(50) = ''
	WHILE (@I != @NUM)
		BEGIN
			IF (@NUM % @I = 0)
				SET @COUNT = @COUNT + 1
			SET @I = @I +1
		END
	IF @COUNT = 0
		SET @RESULT = 'NO. IS PRIME'
	ELSE
		SET @RESULT = 'NO. IS NOT PRIME'
	RETURN @RESULT
END

SELECT DBO.FN_CHECKPRIME(6)

--12. Write a function which accepts two parameters start date & end date, and returns a difference in days.
CREATE OR ALTER FUNCTION FN_DIFFERENCE(@STARTDATE DATE , @ENDDATE DATE)
	RETURNS INT
AS
BEGIN
	DECLARE @DATEDIFF INT = 0
	SET @DATEDIFF = DATEDIFF(DAY,@STARTDATE,@ENDDATE)
	RETURN @DATEDIFF
END

SELECT DBO.FN_DIFFERENCE('2024-12-01', '2024-12-26')

--13. Write a function which accepts two parameters year & month in integer and returns total days each year.
CREATE OR ALTER FUNCTION FN_TOTALDAYS(@YEAR INT, @MONTH INT)
	RETURNS INT
AS
BEGIN
	DECLARE @START_DATE DATE;
    DECLARE @END_DATE DATE;
    DECLARE @TOTAL_DAYS INT;

    SET @START_DATE = DATEFROMPARTS(@YEAR, @MONTH, 1);
    SET @END_DATE = EOMONTH(@START_DATE);
    SET @TOTAL_DAYS = DATEDIFF(DAY, @START_DATE, @END_DATE) + 1;

    RETURN @TOTAL_DAYS;
END

SELECT DBO.FN_TOTALDAYS(2024,12);

--14. Write a function which accepts departmentID as a parameter & returns a detail of the persons.
CREATE OR ALTER FUNCTION FN_DETAILS(@DID INT)
	RETURNS TABLE
AS
RETURN
(
    SELECT P.PersonID, 
        P.FirstName, 
        P.LastName, 
        P.JoiningDate, 
        P.Salary,
        D.DepartmentName
	FROM Person P INNER JOIN Department D
	ON D.DepartmentID = P.DepartmentID
	WHERE D.DepartmentID = @DID
);

SELECT * FROM Department
SELECT * FROM DBO.FN_DETAILS(2)
 
--15. Write a function that returns a table with details of all persons who joined after 1-1-1991.
CREATE OR ALTER FUNCTION FN_JOINING()
	RETURNS TABLE
AS
RETURN(
	SELECT * FROM Person WHERE JoiningDate > '1991-01-01'
);

SELECT * FROM DBO.FN_JOINING();