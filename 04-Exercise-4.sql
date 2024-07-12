

create database exercise4;
use exercise4;


-- Create tables start
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

desc EMPLOYEE;

create table DEPARTMENT(
	Dname varchar(15) not null,
	Dnumber int not null,
	Mgr_ssn char(9) not null,
	Mgr_start_date date,
	PRIMARY KEY(Dnumber),
	UNIQUE(Dname),
	foreign key(Mgr_ssn) references EMPLOYEE(Ssn)
);

desc DEPARTMENT;

create table DEPT_LOCATIONS(
	Dnumber int not null,
	Dlocation varchar(15) not null,
	primary key (Dnumber,Dlocation),
	foreign key (Dnumber) references DEPARTMENT(Dnumber)
);

desc DEPT_LOCATIONS;

create table PROJECT(
	Pname varchar(15) not null,
    Pnumber int not null,
    Plocation varchar(15),
    Dnum int not null,
    primary key (Pnumber),
    unique (Pname),
    foreign key (Dnum) references DEPARTMENT(Dnumber)    
);

desc PROJECT;

create table WORKERS_ON(
	Essn char(9) not null,
    Pno int not null,
    Hours decimal(3,1) not null,
    primary key (Essn,Pno),
    foreign key (Essn) references EMPLOYEE(Ssn),
    foreign key (Pno) references PROJECT(Pnumber)    
);

desc WORKERS_ON;

create table DEPENDENT(
	Essn char(9) not null,
    Dependent_name varchar(15) not null,
    Sex char,
    Bdate date,
    Relationship varchar(8),
    primary key (Essn,Dependent_name),
    foreign key (Essn) references EMPLOYEE(Ssn)  
);

desc DEPENDENT;

-- Create tables end

-- Insert Data start

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


insert into DEPARTMENT
values
    ('Research', 5, '333445555', '1988-05-22'),
	('Administration', 4, '987654321', '1995-01-01'),
    ('Headquarters', 1, '888665555', '1981-06-19');

select * from DEPARTMENT;


insert into PROJECT
values
	('ProductX',1,'Bellaire',5),
	('ProductY',2,'Sugarland',5),
	('ProductZ',3,'Houston',5),
	('Computerization',10,'Stafford',4),
	('Reorganization',20,'Houston',1),
	('Newbenefits',30,'Stafford',4);

select * from PROJECT;

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


insert into DEPENDENT
values
	(333445555,'Alice','F','1986-04-04','Daughter'),
	(333445555,'Theodore','M','1983-10-25','Son'),
	(333445555,'Joy','F','1958-05-03','Spouse'),
	(987654321,'Abner','M','1942-02-28','Spouse'),
	(123456789,'Michael','M','1988-01-04','Son'),
	(123456789,'Alice','F','1988-12-30','Daughter'),
	(123456789,'Elizabeth','F','1967-05-05','Spouse');

select * from DEPENDENT;

insert into DEPT_LOCATIONS
values
	(1,'Houston'),
	(4,'Stafford'),
	(5,'Bellaire'),
	(5,'Sugarland'),
	(5,'Houston');

select * from DEPT_LOCATIONS;
-- Insert Data end 


-- AND
-- Retrive details of the Workers_on table whose Essn is 333445555 and Pno is 10 
select * from WORKERS_ON where Essn='333445555' and Pno=10;

-- OR 
-- Retrive the employees whose Minit is A or B or K
select * from EMPLOYEE where Minit='A' or Minit='B' or Minit='K';

-- BETWEEN 
-- Retrive the Salaries of the Employes b/w 30,000 to 40,000 using between and logical operators 
select * from EMPLOYEE where Salary between 30000 and 40000;
select * from EMPLOYEE where Salary >=30000 and Salary <=40000;

-- LIKE
-- Retrive the Employees whose Address is Houston TX
select * from EMPLOYEE  where Address like "%Houston TX%";

-- Retrive the Employees whose Address starts with F
select * from EMPLOYEE  where Address like "____F%";

-- Retrive the Employees who born in 1950's
select * from EMPLOYEE  where Bdate like "%195%";

-- Retrive the Employees who born in 1960's
select * from EMPLOYEE  where Bdate like "%196%";

-- ORDER BY
select * from EMPLOYEE;
select * from PROJECT;
select * from DEPARTMENT;

-- Retrive a list of employees & the projects they are working od Ordered by Last name
select * from EMPLOYEE , PROJECT  where EMPLOYEE.Dno = PROJECT.Dnum order by Lname;
-- Retrive a list of employees & the Department they are working od Ordered by First name
select * from EMPLOYEE , DEPARTMENT  where EMPLOYEE.Dno = DEPARTMENT.Dnumber order by Fname;

-- Retrive the dept number from Department table and sort Mgr_start_date
select * from DEPARTMENT  where DEPARTMENT.Dnumber order by Mgr_start_date;
-- Retrive the dept number from Department table and sort Mgr_start_date in Descending Order
select * from DEPARTMENT  where DEPARTMENT.Dnumber order by Mgr_start_date desc;

-- DISTINCT
-- Show the distinct values from Employee Salary  
select distinct Salary from EMPLOYEE;

-- LIMIT 
-- Display only first 3 rows of the Table
select * from EMPLOYEE limit 3;
-- Display only first 0 rows of the Table  -> Empty Set
select * from EMPLOYEE limit 0;
