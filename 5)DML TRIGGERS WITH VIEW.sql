--DML TRIGGERS WITH VIEW--

/*
MAKE INNER JOIN TO MAKE VIEW...
NOW WE DELETE A ROW FROM VIEW...
ACCORDING TO THINKING THE TABLE WILL ALSO EFFECT BUT AS WE HAVE @ TABLES THUS ERROR GENERATE
SQL GOT CONFUSED
HENCE USE INSTAED OF TRIGGER
*/


--!!	MAKE PROPER FK TABLE TO WORK WITH THIS CODE	  !!--
select * from dbo.emp

create view vm_emp_details
as
select * from dbo.emp as A
INNER JOIN dbo.emp_dep as B
on A.emp_id=B.emp_id;


delete from vm_emp_details where emp_id=4; --generates error--

create trigger tr_instaed_delete_for_view
on vm_emp_details
instead of delete
as
begin
delete from dbo.emp where emp_id in(select emp_id from deleted)
delete from dbo.emp_dep where emp_id in(select emp_id from deleted)
end

/*
3 rows effect on deletion
i) virtual deleted may insertion
ii) delete row from emp
iii) delete row from emp_temp
*/

