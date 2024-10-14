CREATE DATABASE triggers;

USE triggers;

-- Drop database triggers (commented out)
-- DROP DATABASE triggers;

CREATE TABLE accounts(
    acct_num INT PRIMARY KEY,
    amount DECIMAL(10,2)
);

-- Insert values
INSERT INTO accounts 
VALUES
(1, 100.00),
(2, 200.00),
(3, 300.00),
(4, 400.00),
(5, 500.00);

SELECT * FROM accounts;

SET @sum = 0;

-- Create Trigger
DELIMITER //
CREATE TRIGGER ins_sum BEFORE INSERT ON accounts
FOR EACH ROW 
BEGIN
    SET @sum = @sum + NEW.amount;
END;
//
DELIMITER ;

-- Select @sum
SELECT @sum;

-- Show Trigger 
SHOW TRIGGERS;

-- Drop trigger
DROP TRIGGER ins_sum;

-- Create Employee Table
CREATE TABLE EMPLOYEE(
    Fname VARCHAR(10) NOT NULL,
    Minit CHAR,
    Lname VARCHAR(20) NOT NULL,
    Ssn CHAR(9) NOT NULL,
    Bdate DATE,
    Address VARCHAR(30),
    Sex CHAR(1),
    Salary DECIMAL(10,2),
    Super_ssn CHAR(9),
    Dno INT NOT NULL,
    PRIMARY KEY (Ssn),
    account INT
);

DESC EMPLOYEE;

INSERT INTO EMPLOYEE
VALUES
    ('John', 'B', 'Smith', '123456789', '1965-01-09', '731 Fondren, Houston TX', 'M', 30000, '333445555', 5, 1),
    ('Franklin', 'T', 'Wong', '333445555', '1965-12-08', '638 Voss, Houston TX', 'M', 40000, '888665555', 5, 2),
    ('Alicia', 'J', 'Zelaya', '999887777', '1968-01-19', '3321 Castle, Spring TX', 'F', 25000, '987654321', 4, 3),
    ('Jennifer', 'S', 'Wallace', '987654321', '1941-06-20', '291 Berry, Bellaire TX', 'F', 43000, '888665555', 4, 4),
    ('Ramesh', 'K', 'Narayan', '666884444', '1962-09-15', '975 Fire Oak, Humble TX', 'M', 38000, '333445555', 5, 5),
    ('Joyce', 'A', 'English', '453453453', '1972-07-31', '5631 Rice, Houston TX', 'F', 25000, '333445555', 5, 6),
    ('Ahmad', 'V', 'Jabbar', '987987987', '1969-03-29', '980 Dallas, Houston TX', 'M', 25000, '987654321', 4, 7),
    ('James', 'E', 'Borg', '888665555', '1937-11-10', '450 Stone, Houston TX', 'M', 55000, NULL, 1, 8);

SELECT * FROM EMPLOYEE;

create table WORKERS_ON(
	Essn char(9) not null,
    Pno int not null,
    Hours decimal(3,1) not null,
    primary key (Essn,Pno),
    foreign key (Essn) references EMPLOYEE(Ssn),
    foreign key (Pno) references PROJECT(Pnumber)    
);

desc WORKERS_ON;

insert into WORKERS_ON
values
	(123456789,1,32.5),
	(123456789,2,7.5),
	(666884444,3,40.0),
	(453453453,1,20.0),
	(453453453,2,20.0),
	(333445555,2,10.0),
	(333445555,3,10.0),
	(333445555,10,10.0),
	(333445555,20,10.0),
	(999887777,30,30.0),
	(999887777,10,10.0),
	(987987987,10,35.0),
	(987987987,30,5.0),
	(987654321,30,20.0),
	(987654321,20,15.0),
	(888665555,20,16.0);

select * from WORKERS_ON;

-- Create Trigger
DELIMITER //
CREATE TRIGGER upd_check BEFORE UPDATE ON EMPLOYEE
FOR EACH ROW
BEGIN
    IF NEW.Salary < 0 THEN 
        SET NEW.Salary = 0;
    ELSEIF NEW.Salary > 10000 THEN 
        SET NEW.Salary = 10000;
    END IF;
END;
//
DELIMITER ;

UPDATE EMPLOYEE SET Salary = 99999 WHERE Fname = 'John';
SELECT Salary, Fname FROM EMPLOYEE WHERE Fname = 'John';



-- Create a procedure to raise the salary of an employee using an IN parameter

select * from EMPLOYEE;
DELIMITER //
CREATE PROCEDURE raise_salary(IN eno INT)
BEGIN 
    DECLARE sal DECIMAL(10,2);
    DECLARE newSal DECIMAL(10,2);
	set sal = (SELECT Salary FROM EMPLOYEE WHERE Ssn = eno);
    IF sal < 35000 THEN
        SET newSal = sal + (sal * 0.1) + Salary;
        UPDATE EMPLOYEE SET Salary = newSal WHERE Ssn = eno;
    END IF;
    SELECT newSal AS UpdatedSalary;
END;
//
DELIMITER ;

drop procedure raise_salary;

CALL raise_salary('123456789');
select * from EMPLOYEE;


--  
DELIMITER //
CREATE FUNCTION getsal(dept_no INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    RETURN (
        SELECT SUM(Salary) 
        FROM EMPLOYEE
        WHERE Dno = dept_no
	);
end
//
DELIMITER ;

SELECT getsal(5);
-- drop function getsal;

-- Create a Function to display the count if number of projects for a given employee is working on
DELIMITER //
CREATE FUNCTION get_projects(eno CHAR(9))
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE project_count INT;
    SELECT COUNT(Pno) INTO project_count
    FROM WORKERS_ON
    WHERE Essn = eno;
END;
//
DELIMITER ;

SELECT get_projects('123456789');

