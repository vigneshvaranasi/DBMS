-- Show all available databases
show databases;
 -- to use a particular database
use mysql;
-- Show all tables in a databases
show tables;
-- Create a Table in a Database
create table studs_data(sno int(3),sname varchar(20));
desc studs_data;
-- insert
insert into studs_data values(101,'vvsv');
insert into studs_data values(102,'vvsvignesh');
select * from studs_data;
-- Alter
alter table studs_data add branch varchar(4);
select * from studs_data;
-- Update
update studs_data set branch='CSE' where sno=102;
select * from studs_data;
-- delete
delete from studs_data where sno=101;
select * from studs_data;
-- truncate -> Remove all data from the table and still have the structure
truncate table studs_data; 
select * from studs_data;
-- Insert again
insert into studs_data values(101,'vvsv','10','CSE');
insert into studs_data values(102,'vvsvignesh','20','AI');
-- drop -> deletes full table 
drop table studs_data;
-- Commit -> Save all the data permanently
commit
-- Rollback -> Undo the changes
rollback
