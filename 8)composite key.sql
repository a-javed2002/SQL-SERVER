/*
1)composite key --> more then one primary key
2)Pk violation error --> if we have same value in both columns
3)in this case fk will also have same num of columns
4)columns that make up of composite key can be of any data type
*/

use new;
create table composite (
emp_id int,
dep_id int,
name varchar (20),
primary key(emp_id,dep_id)
)

ALTER TABLE composite ADD PRIMARY KEY(emp_id,dep_id);

insert into composite values(1,1,'abd');
insert into composite values(2,2,'xyz');
insert into composite values(3,1,'pqr');
insert into composite values(4,2,'das');
insert into composite values(5,5,'abs');
insert into composite values(5,5,'abd'); --error as primary key can't be same...(5,5)...primary key violation--

select * from composite;