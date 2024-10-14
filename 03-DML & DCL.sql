-- Show all available databases
show databases;
 -- to use a particular database
use mysql;
-- Show all tables in a databases
show tables;
-- Create a Table in a Database
create table studs_data(sno int(3),sname varchar(20));
desc studs_data;

-- DML
-- insert
insert into studs_data values(101,'vvsv');
insert into studs_data values(102,'vvsvignesh');
select * from studs_data;
-- delete
delete from studs_data where sno=101;
select * from studs_data;
-- Update
update studs_data set sname='vvsvignesh' where sno=103;
select * from studs_data;


-- DCL
-- Commit -> Save all the data permanently
commit
-- Rollback -> Undo the changes
Rollback
-- Savepoint
select * from employee;
savepoint s1;
insert into studs_data values(102,'vignesh');
-- To rollback from that savepoint
rollback s1;