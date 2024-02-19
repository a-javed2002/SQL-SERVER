--Functions--
--compile every time..--
--large fn is slower so we use procedures--
--fn works only with select statements--
--always return any result or value--
--fn only work with input parameters...while procedures also have output parametres--
--cannot use try and catch in fn--
--user defined and system defined functions(built-in fn are database defined fn)--

--return types can be of any type except text,ntext,image,cursor and timestamp--
/*
3 types of user user defined fn
scalar fn --> takes one or more parameters but returns a single value (built-in eg: count(),max() etc)
inline table fn --> returns a table
multi-statement table valued fn
*/

--	databse -> programmabilty -> functions	--
--	dbo stand for databse owner	--

create function wishing()
returns varchar(100)
as
begin
return 'welcome to FN'
end

select dbo.wishing();

create function sqring(@num as int)
returns int
as
begin
return (@num*@num)
end

select dbo.sqring(3);

alter function sqring(@num1 as int,@num2 as int)
returns int
as
begin
return (@num1*@num1+@num2)
end

select dbo.sqring(3,3);

drop function dbo.sqring; --do not use ()--

--scalar fn can be used any where in T_SQL(Transact sql-->insert,update,delete,read)--
--we can access data with scalar fn..but we don't use it--
--scalar fn can call built-in fn--

create function getMyDate()
returns datetime
as
begin
return getDate()
end

select dbo.getMydate();

--if and while can be used--
create function chkAge(@age as int)
returns varchar(100)
as
begin
declare @str varchar(100)
if @age>=18
begin
set @str='you are eligible for vote';
end
else
begin
set @str='you are not eligible for vote';
end
return @str
end

select dbo.chkAge(18);



--INLINE TABLE VALUED FUNCTIONS--
create function fn_emp()
returns table
as
return (select * from emp)

select * from fn_emp();

create function fn_age(@age int)
returns table
as
return (select * from emp where age>=@age)

select * from fn_age(15);

--can use joins with fn--
select * from fn_age(15) As A inner join xyz_table As B on A.id_Fk=B.id;


--MULTI STATEMENT TABLE VALUED FUNCTIONS--
create function fn_getEmpByGender(@gender varchar(20))
returns @mytable table(emp_id int,emp_name varchar(50),emp_age int)
as
begin
insert into @mytable
select emp_id,[name],age from emp where gender = @gender;
return
end

select * from [dbo].[fn_getEmpByGender]('male');
select * from [dbo].[fn_getEmpByGender]('Female');


--for sam epupose making inline table fn--
create function fn_getEmpByGender2(@gender varchar(20))
returns table
as
return(select emp_id,[name],age from emp where gender = @gender)
select * from [dbo].[fn_getEmpByGender2]('male');
select * from [dbo].[fn_getEmpByGender2]('Female');


/*
diffrence b/w inline and multi
1)in inline returns clause does not contain structure of table while multi do...
2)in inline there is no BEgin or End block while multi do...
3)inline table-valued fnare better in peformence as comparede to multi statement table-valued fn bcz..
internally(behind the scenes) inline much work like view while multi much work like procedures....remmeber both
view and procedure are sql objects...but view is light weight

similarities
1)both are table-valued fn
2)both are located in table-valued fn folder in ssms
3)both are user-defined fn in sql server
*/



/*
Diffrence between stored procedures and functions
1)in fn return value is must..but not compulsary in proc
2)in fn we use return while in proc we use OUTPUT
3)fn have only input parameters while proc have input as well as output parameters
4)fn can't call a proc but proc can call fn
5)fn allow only select statement in it...while proc allow select and as well as dml statements
6)can use select/having/where fn but for proc we use exec/execute
7)fn can't use try-catch block but we can handle exception handling in stroed proc
8)we cannot use transactions in fn but we can use in proc....(transaction --> rollback/commit)
9)fn cannot perform permenant enviormental changes(insert or update) to sql server but proc do....
10)fn can be use in join clause but proc cannot...
*/