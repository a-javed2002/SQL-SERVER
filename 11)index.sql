--sql 2012 index comes--
/*
index contain information that allows you to find specific data without scanning the entire table
index can be craeted on tables and views
index is similar to that we used to have on our registers
if we don't have index we have to search whole register for a topic..same concept in sql index
*/

create database institute;
use institute;
create table faculty(
id int,
f_name varchar(50),
salary int
)

insert into faculty values(1,'abc',10000);
insert into faculty values(2,'abc',17000);
insert into faculty values(3,'abc',13000);
insert into faculty values(4,'abc',20000);
insert into faculty values(5,'abc',15000);

/*
index creates a seperate table(virtual) arrange that column in asc/desc to make search easier plus have a col with row address
but real table will have no effect
*/

create index ix_faculty_salary
on faculty (salary asc)		--by default asc hee hota..likhnay ki zaroorat nhi--

sp_helpindex faculty;

select * from faculty
where salary>10000 and salary<20000;

drop index faculty.ix_faculty_salary;

--	we can make index through design view too...index folder is located in table folder--

/*
1)create index on those col that will be searched frequently
2)an index is a pointer to data in a table
3)index create or drop will have no effect on data
4)index is faster with select and where commands
5)index is slower with insert,update delete
6)index automatically created when primary Key or unique constarints are defined on a table --> implicit indexes
7)system stored proc used to chk syntax of index --> sp_helpindex tablename..
*/

/*
single column index-->above example
*/

/*
when to avoid indexes..?
1)on small tables
2)tables that have frequent insertion and updation
3)don't use index on col that have high number of null values
*/

/*
index found in tables folders...!!!
index is of 2 types...
1)clustered index --> changes in the original table --> likes a dictionary
2)Non-clustered index --> make a  seperate virtual table..with columns that have index on them plus extra column for original table row address --> likes a index in register/book
more over they are classified in 2 more categories:-
i)Unique
ii)Non-Unique

clustered index can be one in table while Non-clustered index can be more then one...
columns in index can be more then one in both...
*/

--CLUSTERED INDEX--

create database indexs;
use indexs;

create table idx1(
id int,
name varchar(30),
salary int
)

insert into idx1(4,'abd',3000);
insert into idx1(1,'pqr',1000);
insert into idx1(5,'mno',2000);
insert into idx1(2,'and',500);
insert into idx1(3,'xyz',1300);
--	insert in this order but...once the index xreated on id it will arrange in asc/desc according to index--

create clustered index IX_ID_CLUSTERED --if clustered not written non-clustered index will form--
on idx1 (id asc); --asc is default..if order not written--

--if we put or add primary key on column..the clustered index automatically generates--

--sp_helpindex tablename--
sp_helpindex idx1;


drop index idx1.IX_ID_SALARY_CLUSTERED;

create clustered index IX_ID_CLUSTERED --if clustered not written non-clustered index will form--
on idx1 (id asc,salary desc); --asc is default..if order not written--

--NON CLUSTERED INDEX--

--it makes seperately from the original table...that's why we can make more then one--

create nonclustered index NIX_NAME_CLUSTERED --if nonclustered not written non-clustered index will form automatically--
on idx1 (name asc); --asc is default..if order not written--

create nonclustered index NIX_NAME_SALARY_CLUSTERED --if nonclustered not written non-clustered index will form automatically--
on idx1 (name asc,salary asc); --asc is default..if order not written--

sp_helpindex idx1;

drop index idx1.NIX_NAME_SALARY_CLUSTERED;


--UNIQUE AND NON_UNIQUE--

/*
1)unique index created on columns which have no duplicate values as it ensures
entity and integrity in a table...
2)no big diffrence between unique index and unique constraint...both have unique values while unique index 
arrange it's values in  order asc/desc to search faster
3)if a table defination have unique constarint then unique non-clustered index forms...
4)if a table defination have primary key constarint then unique clustered index forms...
*/


create unique clustered index IX_U_ID_CLUSTERED --if clustered not written non-clustered index will form--
on idx1 (id asc,salary desc); --asc is default..if order not written--

create unique nonclustered index NIX_U_NAME_CLUSTERED --if nonclustered not written non-clustered index will form automatically--
on idx1 (name asc); --asc is default..if order not written--

--if clusterd not written non-clustered index will form automatically and if unique is not written then non-unique clustered forms--
create unique nonclustered index NIX_U_NAME_CLUSTERED
on idx1 (name asc); --asc is default..if order not written--

