--DDL TRIGGERS IN SQL SERVER--

/*
CREATE,ALTER,DROP --> table...view...procedure etc
*/

create database new;
use new;

create trigger tr_ddl_table_create
on database
for CREATE_TABLE
as
begin
print 'TABLE CREATED.....!!!';
end

create table test(
id int primary key identity(1,1)
)

create trigger tr_ddl_table_alter
on database
for ALTER_TABLE
as
begin
print 'TABLE ALTER.....!!!';
end

alter table test add name varchar(50);

create trigger tr_ddl_table_delete
on database
for DROP_TABLE
as
begin
print 'TABLE DROP.....!!!';
end

drop table test;

drop trigger tr_ddl_table_insert;
drop trigger tr_ddl_table_alter;
drop trigger tr_ddl_table_delete;

create trigger tr_ddl_table
on database
for CREATE_TABLE,ALTER_TABLE,DROP_TABLE
as
begin
print 'TABLE CREATED ALTER OR DROP.....!!!';
end


create trigger tr_ddl_sp_create
on database 
/*with encrytion*/ --	sp_helptext cannot use to see syntax of trigger as it's on databse...thus right click on trigger name --> create to -->new query editor window--
for CREATE_PROCEDURE
as
begin
rollback
print 'you are not allowed to craete a stored procedure...!!!';
end

create procedure sp_temp
as
begin
print 'hi i am a proc';
end

/*
1)DDL triggers can be databse or server based --> ddl triggers scope
2)many events are avaible...chk web --> msdn
3)rollback command used to restrict/prevent the execution 
4)WITH ENCRYTION CAN BE USED
5)we can enable and disable triggers for a time being as per requirement
6) for sp_rename event we use RENAME
*/

disable trigger tr_ddl_sp_create on database
create procedure sp_temp
as
begin
print 'hi i am a proc';
end
enable trigger tr_ddl_sp_create on database
drop proc sp_temp;



create trigger tbl_col_rename
on database
for RENAME
as
begin
print 'table or column NAME CHANGED';
end

sp_rename 'test1' , 'test2';
sp_rename 'test1.id' , 'test1.emp_id';

/*how to drop databse triggers*/
drop trigger tbl_col_rename on database
--DML triggers are located in tables folder--
--DDL triggers are located in programmability ---> database triggers-- AND  -- on main folder -->server objects --> triggers

create trigger tr_ddl_server_tbl_creation
on ALL SERVER
for CREATE_TABLE  --CREATE_VIEW ---> ETC--
as
begin
rollback
print 'you cannot create table';
end

disable trigger tr_ddl_server_tbl_creation on ALL SERVER
create table temp4(id int)
enable trigger tr_ddl_server_tbl_creation on ALL SERVER


drop trigger tr_ddl_server_tbl_creation on ALL SERVER


--INVOKED BY DDL EVENTS AT THE SERVER LEVEL--
--ARE STORED IN MASTER DATABASE--

use new;
--SETTING EXECUTION ORDER OF TRIGGERS IN SQL--
create trigger tr_3
on dbo.temp3
after insert
as
begin
print'3rd trigger is fired..!!!';
end

create trigger tr_2
on dbo.temp3
after insert
as
begin
print'2nd trigger is fired..!!!';
end

create trigger tr_1
on dbo.temp3
after insert
as
begin
print'1st trigger is fired..!!!';
end

insert into dbo.temp3 values(1);

execute sp_settriggerorder
@triggername='tr_1',
@order='first',
@stmttype='insert';

execute sp_settriggerorder
@triggername='tr_3',		--DML/DDL trigger name and schema to which it belongs--
@order='last',				--Arrange order...first/last/none--
@stmttype='insert';		--sattement type --> specifies the type of sql statement to invoke--

--only arrange first and last--