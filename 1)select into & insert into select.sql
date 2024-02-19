create database abc;
use abc;
create table emp(
emp_id int identity(1,1),
[name] varchar(30),
)

insert into emp values('stuv');

--select into--
select * into emp_backup from emp;
select * into emp_backup from emp where emp_id in (2,4);
select name into emp_backup from emp;
select * from emp;
select * from emp_backup;
drop table emp_backup;
select * into emp_backup from emp where 1<>1;
select * into databse_name.dbo.emp_backup from emp;  --copying in another databse--

--insert into select--
create table karachi(
id int identity(1,1),
[name] varchar(30),
age int
)
insert into karachi values('abd',19);
insert into karachi values('anb',21);
insert into karachi values('jhs',43);
insert into karachi values('xyz',54);

create table lahore(
id int identity(1,1),
[name] varchar(30),
age int
)

insert into lahore values('fgh',19);
insert into lahore values('bnb',21);
insert into lahore values('lkj',43);
insert into lahore values('pot',54);


select * from karachi;
select * from lahore;

insert into lahore select [name],age from karachi;

insert into lahore ([name]) select TOP 2 ([name]) from karachi; --FOR AGE NULL APPEARS--

--WE CAN COPY FROM SOURCE TABLE TO TARGET TABLE--

sp_renamedb 'opq','asd';
sp_rename 'table1','table2';