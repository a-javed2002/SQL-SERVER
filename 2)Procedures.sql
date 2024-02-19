create procedure sp1	--instead of procedure we can write proc--
as
begin
select * from emp;
end

--3 ways to use--
sp1;
exec sp1;
execute sp1;

--alter...adding parameters...the difference between view and proc--
alter procedure sp1 --stored procedure with input parameter--
@id int
as
begin
select * from emp where emp_id=@id;
end

exec sp1 4;

alter procedure sp1
@id int,
@name varchar(50)
as
begin
select * from emp where emp_id=@id and name=@name;
end

exec sp1 4,'stuv';

sp_helptext sp1;  --output structure of proc--

--database -> programmability -> stored procedures--

--encryption for proc--
alter procedure sp1
@id int,
@name varchar(50)
with encryption		--remove this and alter...to finish encryption--
as
begin
select * from emp where emp_id=@id and name=@name;
end
sp_helptext sp1;  --output structure of proc--


drop procedure sp1; --	procedure===pro  --


select * from emp;
create procedure sp2 --stored procedure with input and output parameter--
@gender varchar(30),
@totalEmployee int OUTPUT
as
begin
select @totalEmployee=count(emp_id) from emp where gender=@gender;
end

declare @totalEmployee int;
exec sp2 'male',@totalEmployee OUTPUT;
select @totalEmployee as Total_Male_Employees;