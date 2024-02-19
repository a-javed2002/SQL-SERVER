/*
Temprary tables (TB) are similar to your created yables(permenant tables) and they stored temporary data...
these tables in sql server are stored in database server in folder databses --> system databases --> TempDB --> Temporary tables...

2 Types Of TB
i)Local TB
ii)Gloabal TB

--LOCAL TEMPORARY TABLE--
It's only for the connection that has created the table...
when the connection closed local TB automatically drops...
we use # before table anme to create local TB...
but if local TB is created in stored proc(SP)..so local TB automatically drops when SP completes it's execution...
we can delete TB with 'drop table name'...
we can make multiple local TB with same name with in multiple connections..
in the object explorer,there will be random numbers suffixed at the end of the table name



--GLOBAL TEMPORARY TABLE--
we use ## before table anme to create global TB...
It's only accessible or visible in all the connections...
destroyed when the last connection referencing the table is closed...
if you close the connection that has created the global TB then that global TB will automatically deleted...
we cannot make multiple global TB with same name with in another connection...
in the object explorer,there will be no random numbers suffixed at the end of the table name...

--Similarities--
both created in Temp DB in system databses...
both are automatically deleted when the connection is closed...
both are the types of temprary tables...
*/

create table #EmpData(
name varchar(50),
gender varchar(50)
)

select * from tempdb..sysobjects
where name like '%EmpData%';
--OR--
select name from tempdb..sysobjects
where name like '%EmpData%';


insert into #EmpData values('abd','male');
insert into #EmpData values('xyz','female');
insert into #EmpData values('mno','male');

select * from #EmpData;





create procedure sp_r1
as
begin
create table #EmpData(
name varchar(50),
gender varchar(50)
)

insert into #EmpData values('abd','male');
insert into #EmpData values('xyz','female');
insert into #EmpData values('mno','male');

select * from #EmpData;
end

exec sp_r1;

drop proc sp_r1;







create table ##EmpData(
name varchar(50),
gender varchar(50)
)

select * from tempdb..sysobjects
where name like '%EmpData%';
--OR--
select name from tempdb..sysobjects
where name like '%EmpData%';


insert into ##EmpData values('abd','male');
insert into ##EmpData values('xyz','female');
insert into ##EmpData values('mno','male');

select * from ##EmpData;