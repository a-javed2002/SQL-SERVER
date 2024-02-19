
begin try
print 10/0;
end try
begin catch
print 'you cannot divide by zero...';
end catch


--if fail the other exececution won't happen
use abc;

begin try
print 10/0;
select * from fam;
end try
begin catch
print 'you cannot divide by zero...';
end catch


begin try
update fam set salary='abc' where id=1
end try
begin catch
	--print 'cannot insert string in int...'
	select
	ERROR_NUMBER() as [Number Of Errors],
	ERROR_SEVERITY() as [Error Severity],
	ERROR_STATE() as [Error state Number],
	ERROR_PROCEDURE() as [Sp Name],
	ERROR_LINE() as [Error On Line],
	ERROR_MESSAGE() as [Error Message]
end catch

/*
built in Fn can be use to retrieve the information about error:- (BUT USED IN CATCH BLOCK ONLY..otherwise returns NULL only..!!!)
1)ERROR_NUMBER() --> returns the number of error...
2)ERROR_SEVERITY() --> returns the severity(level of error --> danger/light etc)...returns 16 means...we can fix that error
3)ERROR_STATE() --> returns the error state number...
4)ERROR_PROCEDURE() --> returns the name of the stored procedure or trigger where the error occurred...
5)ERROR_LINE() --> returns the line number inside the routine that caused the error...
6)ERROR_MESSAGE() --> returns the complete text of the error message...
*/


create proc sp_try
as
begin
begin try
update fam set salary='abc' where id=1
end try
begin catch
	--print 'cannot insert string in int...'
	select
	ERROR_NUMBER() as [Number Of Errors],
	ERROR_SEVERITY() as [Error Severity],
	ERROR_STATE() as [Error state Number],
	ERROR_PROCEDURE() as [Sp Name],
	ERROR_LINE() as [Error On Line],
	ERROR_MESSAGE() as [Error Message]
end catch
end

exec sp_try;