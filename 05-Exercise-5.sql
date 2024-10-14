
create database exercise5;
use exercise5;

-- Create tables
create table EMPLOYEE(
	Fname varchar(10) not null,
	Minit char,
	Lname varchar(20) not null,
	Ssn char(9) not null,
	Bdate date,
	Address varchar(30),
	Sex char(1),
	Salary decimal(5),
	Super_ssn char(9),
	Dno int not null,
	primary key (Ssn)
);

-- Insert data into EMPLOYEE table
insert into EMPLOYEE
values
    ('John', 'B', 'Smith', 123456789, '1965-01-09', '731 Fondren, Houston TX', 'M', 30000, 333445555, 5),
    ('Franklin', 'T', 'Wong', 333445555, '1965-12-08', '638 Voss, Houston TX', 'M', 40000, 888665555, 5),
    ('Alicia', 'J', 'Zelaya', 999887777, '1968-01-19', '3321 Castle, Spring TX', 'F', 25000, 987654321, 4),
    ('Jennifer', 'S', 'Wallace', 987654321, '1941-06-20', '291 Berry, Bellaire TX', 'F', 43000, 888665555, 4),
    ('Ramesh', 'K', 'Narayan', 666884444, '1962-09-15', '975 Fire Oak, Humble TX', 'M', 38000, 333445555, 5),
    ('Joyce', 'A', 'English', 453453453, '1972-07-31', '5631 Rice, Houston TX', 'F', 25000, 333445555, 5),
    ('Ahmad', 'V', 'Jabbar', 987987987, '1969-03-29', '980 Dallas, Houston TX', 'M', 25000, 987654321, 4),
    ('James', 'E', 'Borg', 888665555, '1937-11-10', '450 Stone, Houston TX', 'M', 55000, NULL, 1);
select * from EMPLOYEE;





-- String Functions

-- Instr -> Returns the position of the first occurrence of a substring in a string
select instr("Hello, World!","world");
select instr("Hello, World!","2");

-- Concat -> Concatenates two or more strings
select concat("Hello,"," World!");
select concat(Fname," ",Lname) from EMPLOYEE;

-- least -> Returns the smallest of the given arguments
select least(9,4,1,2,3,4,5,6);

-- greatest -> Returns the greatest of the given arguments
select greatest(9,4,1,2,3,4,5,6,7);

-- truncate -> Truncate the number to the specified decimal places
select truncate(123.4567,2);
select truncate(123.4567,3);
select truncate(123.4567,0);
select truncate(123.4567,7);

-- Round -> Round the number to the specified decimal places
select round(123.453,2);
select round(123.456,2);
select round(123.456,0);

-- lpad -> Left pad the string with the specified character
select lpad("Hello",9,'*');

-- rpad -> Right pad the string with the specified character
select rpad("Hello",9,'*');


-- ltrim -> Removes the leading spaces from a string
select ltrim("		Hello");

-- rtrim -> Removes the trailing spaces from a string
select rtrim("Hello		");

-- ltrim & rtrim -> Removes the leading and trailing spaces from a string
select rtrim(ltrim("	Hello	"));

-- Trim -> Removes the leading and trailing spaces from a string
select trim("	Hello	");

-- Lower -> Converts the string to lower case
select lower("HELLO");

-- Upper -> Converts the string to upper case
select upper("hello");
select upper(Fname) from EMPLOYEE;

-- length -> Returns the length of the string
select length("Hello");

-- replace -> Replaces the substring in a string
select replace("Hello World","World","Universe"); 

-- Reverse -> Reverses the string
select reverse("Hello");

-- strcmp -> Compares two strings
select strcmp("Hello","Hello"); 
select strcmp("ABC","ABD"); 
select strcmp("ABD","ABC"); 

-- substr -> Extracts the substring from a string
select substr("Hello World", 2, 5);
select substr("Hello World", 2);






-- Numeric Functions
-- count -> Returns the number of rows in a result set
select count(Fname) from EMPLOYEE;

-- Floor -> Returns the largest integer less than or equal to a number
select floor(1234.23);

-- ceil -> Returns the smallest integer greater than or equal to a number
select ceil(1234.23);

-- min,max,avg,sum -> Returns the minimum, maximum, average, and sum of the values in a column
select min(Salary),max(Salary),avg(Salary),sum(Salary) from EMPLOYEE;





-- Date Functions

-- curdate -> Returns the current date
select curdate(); 

-- adddate -> Adds the specified date interval to the date
select adddate(curdate(),interval 10 day); 
select adddate('2024-11-09',interval 10 day); 
select adddate('2024-11-09',10);
select adddate('2024-11-09',-10); 
select adddate('2024-11-09',interval 10 year); 

-- dayofmonth,dayofyear,dayofweek -> Returns the day of the month, day of the year, and day of the week
select dayofmonth(curdate());
select dayofyear(curdate());
select dayofweek(curdate());

-- sysdate -> Returns the current date and time
select sysdate();

-- week -> Returns the week number for a date
select week(curdate());

-- weekday -> Returns the weekday index for a date
select weekday(curdate());

-- isnull  -> Returns the specified value if the expression is NULL
select isnull(Fname) from EMPLOYEE;






-- Conversion Functions

-- Convert -> Converts the string to a date
select convert("2024/11/09",date);
select convert("2024.11.09",date);

-- str_to_date -> Converts the string to a date
select str_to_date("November 9 2004","%M %d %Y");

