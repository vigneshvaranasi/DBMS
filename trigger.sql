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

-- Create Procedures
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `EMP_DATA`()
BEGIN
    SELECT * FROM EMPLOYEE;
END;
//

CREATE DEFINER=`root`@`localhost` PROCEDURE `MY_PROC_IN`(IN var1 INT)
BEGIN
    SELECT * FROM EMPLOYEE LIMIT var1;
END;
//

CREATE DEFINER=`root`@`localhost` PROCEDURE `MY_PROC_OUT`(OUT highest_salary INT)
BEGIN
    SELECT MAX(Salary) INTO highest_salary FROM EMPLOYEE;
END;
//

CREATE DEFINER=`root`@`localhost` PROCEDURE `MY_PROC_INOUT`(INOUT mfgender INT, IN EMP_GENDER CHAR(1))
BEGIN
    SELECT COUNT(Sex) INTO mfgender FROM EMPLOYEE WHERE Sex = EMP_GENDER;
END;
//

create procedure raise_salary(in eno int)
begin 
declare sal int;
select salary into sal from employee where ssn = eno;
if sal < 35000 THEN
	set sal = sal + (sal * 0.1);
	update employee set salary = sal where ssn = eno;
	select "Salary Updated" as status, as new_salaray;
else
    select "Salary not updated" as status;
end if;
end;
//

DELIMITER ;

call raise_salary(123456789);
