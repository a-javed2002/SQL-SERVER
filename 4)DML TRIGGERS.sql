--insert trigger--
create trigger tr_emp_insert
on dbo.emp
after insert
as
begin
	--print'INSERTION IN EMPLOYEE TABLE';--
	select * from inserted	--virtual tables--
end

insert into dbo.emp values('cedr','male',13);

drop trigger tr_emp_delete;

--delete trigger--
alter trigger tr_emp_delete
on dbo.emp
after delete
as
begin
	--print'INSERTION IN EMPLOYEE TABLE';--
	select * from deleted	--virtual tables--
end

delete from dbo.emp where emp_id=4;

create table tbl_emp_audit(
audit_id int primary key identity(1,1),
audit_info varchar(max)
)


create trigger tr_emp_insert2
on dbo.emp
after insert
as
begin
declare @id int
select @id=emp_id from inserted	--virtual tables--
insert into dbo.tbl_emp_audit values ('Employee With id ' + cast(@id as varchar(50))+' is inserted at '+ Cast(GETDATE() as varchar(50)))
end


insert into dbo.emp values('cdr','male',13);

select * from tbl_emp_audit;
select * from emp;

create trigger tr_emp_delete2
on dbo.emp
after delete
as
begin
declare @id int
select @id=emp_id from deleted  --virtual tables--
insert into dbo.tbl_emp_audit values ('Employee With id ' + cast(@id as varchar(50))+' is deleted at '+ Cast(GETDATE() as varchar(50)))
end
delete from dbo.emp where emp_id=4;

create trigger tr_emp_update
on dbo.emp
after update
as
begin
select * from inserted
select * from deleted
declare @id int
select @id=emp_id from deleted  --virtual tables--
insert into dbo.tbl_emp_audit values ('Employee With id ' + cast(@id as varchar(50))+' is updated at '+ Cast(GETDATE() as varchar(50)))
end

update emp set gender='male' where emp_id=5;


sp_helptext tr_emp_update;

/*
A trigger is a special kind of stored procedure that automatically executes whne an event occurs in the database server
DML --> insert,delete,update --> 2 types
i)after triggers(also called 'For triggers') --> executed after insert,delete,update --> can make multiple...insert,delete,update triggers
ii)INSTEAD OF TRIGGERS --> executed in place of insert,delete,update --> can make single...insert,delete,update triggers

DDL --> Create,Alter
*/

alter trigger tr_emp_instead_insert
on dbo.emp
instead of insert
as
begin
select * from inserted
declare @name varchar(50)
select @name=[name] from inserted  --virtual tables--
insert into dbo.tbl_emp_audit values ('Someone Try To Insert Employee With Name ' + @name+' at '+ Cast(GETDATE() as varchar(50)))
end

insert into dbo.emp values('ceadr','male',19);

select * from tbl_emp_audit;
select * from emp;

alter trigger tr_emp_instead_delete
on dbo.emp
instead of delete
as
begin
select * from deleted
declare @name varchar(50),@id int
select @name=[name] from deleted  --virtual tables--
select @id=[emp_id] from deleted  --virtual tables--
insert into dbo.tbl_emp_audit values ('Someone Try To Delete Employee With Id ' + Cast(@id as varchar(50))+' and with name '+@name+' at '+ Cast(GETDATE() as varchar(50)))
end

delete from dbo.emp where emp_id=5;


create trigger tr_emp_instead_update
on dbo.emp
/*with encryption*/ --also put lock icon on folder--
instead of update
as
begin
select * from deleted
declare @id int
select @id=emp_id from deleted  --virtual tables--
insert into dbo.tbl_emp_audit values ('Someone Try To Change Employee With Id ' + Cast(@id as varchar(50))+' at '+ Cast(GETDATE() as varchar(50)))
end

update emp set gender='male' where emp_id=5;

sp_helptext tr_emp_instead_update;
drop trigger tr_emp_instead_delete;


