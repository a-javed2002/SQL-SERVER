/*
There Are 3 Fn to get the last inserted ID...
1. Scope_identity() --> Fn
2. @@identity --> Global variable
3. ident_Current('table_name') --> Fn
*/


use abc;

create table tbl_cus(
id int identity,
name varchar(20)
)

insert into tbl_cus values('abd');
insert into tbl_cus values('xyz');

select * from tbl_cus;
select SCOPE_IDENTITY();
select @@IDENTITY;
--chk in another connection/session the result will be diffrent...insert record form othe connection/session then chk
--both works according to connection/session..so what's the difference..?
--for that make another table...and a trigger

create table tbl_cus_det(
id int identity,
date_time datetime
)


create trigger tr_tbl_cus
on tbl_cus
after insert
as
begin
	insert into tbl_cus_det values(getdate());
end

insert into tbl_cus values('asd');
select * from tbl_cus;
select SCOPE_IDENTITY();
select @@IDENTITY;



insert into tbl_cus values('jkl');
select * from tbl_cus;
select SCOPE_IDENTITY(); --> returns first table id according to connection/session...
select @@IDENTITY; --> returns current table (that is manipulated) id according to connection/session...

/*
The SCOPE_IDENTITY() Fn returns the last identity created in the same session and the same scope....
The @@IDENTITY returns the last identity created in the same session and in any scope...
The IDENT_CURRENT('table_name') returns the last identity created for a specific table or view in any session...
*/


select IDENT_CURRENT('tbl_cus');
select IDENT_CURRENT('tbl_cus_det');