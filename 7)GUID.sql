/*
16 byte binary data type that is globally unique..
to create it --> newid()
sql server gurantees to be unique across tables,databses and servers

advantages:-
unique across tables,databse and even servers
useful if u are consolidating records from multiple sql servers into a single table

disadvantages;-
16 bytes where int is 4 bytes..thus largest datat type in sql server
an index built on guid is larger and slower
hard to read as compare to int
*/

create database guid;
use guid;

create table karachi(
id uniqueidentifier primary key default newid(),
name varchar(100)
)

insert into karachi values(default,'abd');
insert into karachi values(default,'xyz');
insert into karachi values(default,'pqr');

create table lahore(
id uniqueidentifier primary key default newid(),
name varchar(100)
)

insert into lahore values(default,'asd');
insert into lahore values(default,'fgh');
insert into lahore values(default,'jkl');

select * from karachi;
select * from lahore;

select * into all_data from karachi where 1<>1;  --craeting all_data table--

insert into all_data 
select * from karachi
union all
select * from lahore;

select * from all_data;


--selecting data from another databse table--
create database guid2;
use guid2;

select * into city from guid.dbo.karachi where 1<>1;  --craeting city table--


--putting guid->all_data into guid2--> city table--
insert into dbo.city 
select * from guid.dbo.karachi
union all
select * from guid.dbo.lahore;

select * from city;
select * from guid.dbo.all_data;