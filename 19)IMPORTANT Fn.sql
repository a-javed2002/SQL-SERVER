/*
COALESCE --> Returns the first non-null value in a list(no limit)...but all arguments of the same datatype...
isNull --> Returns the first non-null value between 2 parameters...
*/

select COALESCE(NULL,NULL,'abd',NULL,'hello bro');
select COALESCE(NULL,NULL,NULL,NULL,'hello bro');

use abc;

create table student_detail(
id int identity,
first_name varchar(50),
middle_name varchar(50),
last_name varchar(50)
)

insert into student_detail values('abd',NULL,'xyz');
insert into student_detail values(NULL,NULL,'mno');
insert into student_detail values(NULL,'pqr','xyz');
insert into student_detail values(NULL,NULL,'jkl');
insert into student_detail values(NULL,NULL,NULL);
insert into student_detail values('opq','ghi',NULL);
insert into student_detail values('asd','bno',NULL);

select * from student_detail;
select id,coalesce(first_name,middle_name,last_name) from student_detail;


select * from student_detail;
select id,first_name,middle_name from student_detail;
select id,isNull(first_name,middle_name) from student_detail;



/*
CAST --> 
CONVERT -->

CAST is part of the ANSI-SQL specification; whereas,
CONVERT is not. In fact, CONVERT is SQL implementation-specific.
CONVERT differences lie in that it accepts an optional style parameter that is used for formatting.
*/

select CAST(23.45 as int) as [value];
select CAST('2023-07-11' as date) as [date];
select CAST('2023-07-11' as datetime) as [date/time];

create table emp_det(
id int identity,
name varchar(20),
joining_date datetime default(getdate())
)

insert into emp_det(name) values('abd')
insert into emp_det(name) values('xyz')
insert into emp_det(name) values('asd')
insert into emp_det(name) values('pqr')
insert into emp_det(name) values('jkl')


select * from emp_det;

select name +' - '+CAST(id as varchar(max)) as [detail of emp] from emp_det;


--we can use this to concatination with some previous arguments in table..like last inserted id--
insert into emp_det(name) values('fgh ' + CAST(26 as varchar(30)))

select * from emp_det where joining_date = '2023-01-22'; --no result--
select * from emp_det where joining_date = '2023-01-22 10:51:19.150'; --only matched ones--
select * from emp_det where joining_date = '%2023-01-22'; --error--
select * from emp_det where cast(joining_date as date) = '2023-01-22'; --all users detail join on this date but wuth time--
select id,name,cast(joining_date as date) as [Date] from emp_det where cast(joining_date as date) = '2023-01-22'; --all users detail join on this date--

--MAGIC--
select cast(joining_date as date),count(id) from emp_det
group by cast(joining_date as date);

insert into emp_det values('awsd1','2024-01-22 01:31:19.150')
insert into emp_det values('awsd2','2024-02-22 09:51:39.120')
insert into emp_det values('awsd3','2025-04-22 06:41:19.150')
insert into emp_det values('awsd4','2026-07-22 11:51:49.110')
insert into emp_det values('awsd5','2024-01-22 01:31:19.150')
insert into emp_det values('awsd6','2024-02-22 09:51:39.120')
insert into emp_det values('awsd7','2025-04-22 06:41:19.150')
insert into emp_det values('awsd8','2026-07-22 11:51:49.110')

truncate table emp_det;



select CAST(23.45 as int) as [value1];
select CONVERT(int,23.45) as [value2];

declare @num1 decimal = 11.23;
select CAST(@num1 as int) as [value1];

declare @num2 decimal = 11.23;
select CONVERT(int,@num2) as [value2];


--STILL NO DIFFREENCE--


--IN CONVERT() WE CAN USE DIFFRENT FORMATS OF DATE AND TIME--
--	CONVERT(datatype[length],expression,[style])

--https://learn.microsoft.com/en-us/sql/t-sql/functions/cast-and-convert-transact-sql?view=sql-server-ver15

select getdate();
select convert(varchar,getdate(),0) as [Today Date];
select convert(varchar,getdate(),1) as [Today Date]; --mm/dd/yy
select convert(varchar,getdate(),101) as [Today Date]; --mm/dd/yyyy
select convert(varchar,getdate(),2) as [Today Date]; --yy/mm/dd
select convert(varchar,getdate(),102) as [Today Date]; --yyyy/mm/dd

select id,name,convert(varchar,joining_date,103) as [joining_date] from emp_det;
select id,name,convert(varchar,joining_date,100) as [joining_date] from emp_det;
select id,name,convert(nvarchar,joining_date,130) as [joining_date] from emp_det;




/*
ROW_NUMBER --> Numbers The output of a result set...
It works with 'OVER' clause hence 'group by' too...
*/


use abc;

--asc is default
select *,ROW_NUMBER() over (order by name) as Numbering
from fam;


select *,ROW_NUMBER() over (order by name desc) as Numbering
from fam;

--numbering according to partition by gender...order by name
select *,ROW_NUMBER() over (partition by gender order by name desc) as Numbering
from fam;

--numbering according to partition by city...order by salary..asc by default..still u can write
select *,ROW_NUMBER() over (partition by city order by salary) as Numbering
from fam;

/*
*)More Specifically,returns the sequential number of a row within a partition of a result set,starting at 1 for the first row in each partition..
*)Row_NUMBER is a temporary value calculated when the query is run..To presist numbers in the Table,use identity Property..
*/


/*
Rank And Dense_Rank Function In SQL Server
*)We use Dense_Rank() More then Rank()
*/

use abc;

create table tbl_stu(
id int identity,
name varchar(20),
gender varchar(20),
age int,
marks int
)

insert into tbl_stu values ('abd','male',16,66);
insert into tbl_stu values ('xyz','female',16,58);
insert into tbl_stu values ('asd','male',16,87);
insert into tbl_stu values ('jkl','male',16,59);
insert into tbl_stu values ('pqr','female',16,83);
insert into tbl_stu values ('opf','male',16,91);
insert into tbl_stu values ('mno','male',16,74);
insert into tbl_stu values ('bju','female',16,90);
insert into tbl_stu values ('rty','male',16,74);
insert into tbl_stu values ('uvx','female',16,90);
insert into tbl_stu values ('cvm','male',16,90);

select * from tbl_stu;

select name,gender,age,marks,rank() over (order by marks desc) as [Rank]
from tbl_stu;


--PARTITION BY is optional with RANK()

select name,gender,age,marks,rank() over (partition by gender order by marks desc) as [Rank]
from tbl_stu;


--DENSE_RANK()--
select name,gender,age,marks,DENSE_RANK() over (order by marks desc) as [Rank]
from tbl_stu;


--Diffrence is in giving numbers--
select name,gender,age,marks,
rank() over (order by marks desc) as [Rank],
DENSE_RANK() over (order by marks desc) as [Dense_Rank]
from tbl_stu;


--PARTITION BY is optional with DENSE_RANK()

select name,gender,age,marks,dense_rank() over (partition by gender order by marks desc) as [Rank]
from tbl_stu;

/*
The RANK(),DENSE_RANK() and ROW_NUMBER() Fns are used to retrieve an increasing integer value...
They start with a value based on the condition imposed by the 'ORDER BY' clause...
All of these Fn require the 'ORDER BY' clause to Fn Properly HOWEVER 'Partiton BY' clause is optional...
In case Of partitioned data,the integer counter is reset to 1 for each partition...
*/