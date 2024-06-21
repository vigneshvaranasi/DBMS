-- Show all available databases
show databases;
 -- to use a particular database
use mysql;
-- Show all tables in a databases
show tables;
-- Create a Table in a Database
create table ex1_stud(sno int(3),sname varchar(20));
desc ex1_stud;
-- insert
insert into ex1_stud values(101,'vvsv');
insert into ex1_stud values(102,'vvsvignesh');
select * from ex1_stud;
-- Alter
alter table ex1_stud add branch varchar(4);
select * from ex1_stud;
-- Update
update ex1_stud set branch='CSE' where sno=102;
select * from ex1_stud;
-- delete
delete from ex1_stud where sno=101;
select * from ex1_stud;
-- truncate -> Remove all data from the table and still have the structure
truncate table ex1_stud; 
select * from ex1_stud;
-- Insert again
insert into ex1_stud values(101,'vvsv','10','CSE');
insert into ex1_stud values(102,'vvsvignesh','20','AI');
-- drop -> deletes full table 
drop table ex1_stud;
-- Commit -> Save all the data permanently
commit
