create database COMPANY;
use COMPANY;
show tables;
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


-- Queries

-- 1.For every project located in 'Stafford', list the project number, the controlling department number and name. 
select P.Pnumber, P.Dnum, D.Dname from PROJECT P join DEPARTMENT D on P.Dnum = D.Dnumber where P.Plocation = 'Stafford';

-- 2.For every project located in 'Houston', list the project number, the controlling department number, and the department manager's last name, address, and birthdate.
select P.Pnumber, P.Dnum, E.Lname, E.Address, E.Bdate 
from PROJECT P 
join DEPARTMENT D on P.Dnum = D.Dnumber 
join EMPLOYEE E on D.Mgr_ssn = E.Ssn 
where P.Plocation = 'Houston';

-- 3.Retrieve the names of the managers for each department 
select D.Dname, E.Fname, E.Minit, E.Lname 
from DEPARTMENT D 
join EMPLOYEE E on D.Mgr_ssn = E.Ssn;

-- 4.Show the resulting salaries if every employee working on the ‘ProductX’ project is given a 10 percent raise
select E.Fname, E.Lname, E.Salary, (E.Salary * 1.1) as NewSalary
from EMPLOYEE E
join WORKERS_ON W on  E.Ssn = W.Essn
join PROJECT P on W.Pno = P.Pnumber
where P.Pname = 'ProductX';

-- 5.For each employee, retrieve the employee's name, and the name of his or her immediate supervisor.
select E1.Fname as EmployeeFirstName, E1.Lname as EmployeeLastName, 
       E2.Fname as SupervisorFirstName, E2.Lname as SupervisorLastName
from EMPLOYEE E1
left join EMPLOYEE E2 on E1.Super_ssn = E2.Ssn;

-- 6.Retrieve a list of employees and the projects  they are working on,order by department 
select E.Fname, E.Lname, D.Dname as DepartmentName, P.Pname as ProjectName
from EMPLOYEE E
join DEPARTMENT D on E.Dno = D.Dnumber
join WORKERS_ON W on E.Ssn = W.Essn
join PROJECT P on W.Pno = P.Pnumber
order by D.Dname;

-- Task 1

-- 7.Retrieve the birthdate and address of the employee whose name is 'John B. Smith'.
select Bdate, Address
from EMPLOYEE
where Fname = 'John' and Minit = 'B' and Lname = 'Smith';

-- 8.List the employees working in department 10
select Fname, Minit, Lname from EMPLOYEE where Dno = 10;

-- 9.Retrieve distinct salary values from employee table
select distinct Salary from EMPLOYEE;

-- 10.Retrieve all employees whose address is in ‘Houston,Texas’
select Fname, Minit, Lname from EMPLOYEE where Address like '%Houston, Texas%';

-- 11.Find all employees who were born during 1950s
select Fname, Minit, Lname, Bdate from EMPLOYEE where Bdate BETWEEN '1950-01-01' and '1959-12-31';

-- 12.Add a column phone_no to dept_location table.
alter table DEPT_LOCATIONS add(phone_no int(10));
select * from DEPT_LOCATIONS;

-- 13.Add ‘super_ssn’ as a foreign key for employee table.
alter table EMPLOYEE add constraint Emp_super foreign key (Super_ssn) references EMPLOYEE(Ssn);
desc EMPLOYEE;

-- 14.Modify the size of address column in employee table to 30. -> Starting only while Creating we took 30
-- This is the cmd to modify the size of address column in employee table to 30.
alter table EMPLOYEE modify Address varchar(30);
desc EMPLOYEE;

-- 15.Change the salary of ‘franklin wong’ to 35000
update EMPLOYEE set Salary = 35000 where Fname = 'Franklin' and Lname = 'Wong';
select * from EMPLOYEE where Fname = 'Franklin' and Lname = 'Wong';

-- 16.Change the location and controlling department number of project no 10 to ‘Bellaire’ and 5.
update PROJECT set Plocation = 'Bellaire', Dnum = 5 where Pnumber = 10;
select * from PROJECT where Pnumber = 10;

-- 17.update the salary of all employees in department no 10 by 10%
update EMPLOYEE set Salary = Salary * 1.1 where Dno = 10;
select * from EMPLOYEE where Dno = 10;

-- 18.List the employees between the salary range 30000 to 40000
select Fname, Minit, Lname, Salary from EMPLOYEE where Salary BETWEEN 30000 and 40000;

-- 19.List the names and salaries of employees earning a salary of 35000 or more.
select Fname, Minit, Lname, Salary from EMPLOYEE where Salary >= 35000;

-- 20.List the employees who are staying in ‘Houston’ and earning a salary greater than 30000
select Fname, Minit, Lname, Salary from EMPLOYEE where Address like '%Houston%' and Salary > 30000;

-- 21.Retrieve the Female employees who belongs to either department 4 or 1
select Fname, Minit, Lname, Sex, Dno from EMPLOYEE where Sex = 'F' and (Dno = 4 OR Dno = 1);

-- 22.Retrieve the projects controlled by  department 10 
select Pname, Pnumber from PROJECT where Dnum = 10;

-- 23.delete the employee with name ‘joyce’
-- For this the foreign key constraint should be removed first
delete from workers_on where Essn = (select Ssn from EMPLOYEE where Fname = 'Joyce');
delete from EMPLOYEE where Fname = 'Joyce';
select * from EMPLOYEE;

-- 24.Retrieve all the Male employees from employee.
select * from EMPLOYEE where Sex = 'M';

-- 25.List the departments with ‘e’ as the second letter in their name.
select * from DEPARTMENT where Dname like '_e%';


-- Task 2

-- 26.Retrieve the name and address of all employees who work for the 'Research' department.
select E.Fname, E.Lname, E.Address from EMPLOYEE E join DEPARTMENT D on E.Dno = D.Dnumber where D.Dname = 'Research';


-- 27.For every project located in 'Stafford', list the project number, the controlling department number and name. 
select P.Pnumber, P.Dnum, D.Dname from PROJECT P join DEPARTMENT D on P.Dnum = D.Dnumber where P.Plocation = 'Stafford';

-- 28.For every project located in 'Houston', list the project number, the controlling department number, and the department manager's last name, address, and birthdate.
select P.Pnumber, P.Dnum, E.Lname, E.Address, E.Bdate
from PROJECT P join DEPARTMENT D on P.Dnum = D.Dnumber join EMPLOYEE E on D.Mgr_ssn = E.Ssn
where P.Plocation = 'Houston';


-- 29.Retrieve the names of the managers for each department 
select D.Dname, E.Fname, E.Minit, E.Lname from DEPARTMENT D join EMPLOYEE E on D.Mgr_ssn = E.Ssn;

-- 30.Show the resulting salaries if every employee working on the ‘ProductX’ project is given a 10 percent raise
select E.Fname, E.Minit, E.Lname, E.Salary, E.Salary * 1.10 as New_Salary
from employee E
join workers_on W on E.Ssn = W.Essn
join project P on W.Pno = P.Pnumber
where P.Pname = 'ProductX';


-- 31.For each employee, retrieve the employee's name, and the name of his or her immediate supervisor.
select E.Fname as Employee_Fname, E.Minit as Employee_Minit, E.Lname as Employee_Lname,
       S.Fname as Supervisor_Fname, S.Minit as Supervisor_Minit, S.Lname as Supervisor_Lname
from EMPLOYEE E
left join EMPLOYEE S on E.Super_ssn = S.Ssn;

-- 32.Retrieve a list of employees and the projects they are working on,order by department 
select E.Fname, E.Minit, E.Lname, P.Pname, E.Dno 
from EMPLOYEE E 
join workers_on W 
on E.Ssn = W.Essn 
join PROJECT P 
on W.Pno = P.Pnumber 
order by E.Dno;

