/*
TRANSCATIONS
INPLICIT TRANSACTION --> done by software itself
EXPLICIT TRANSACTION --. done by user

A Transaction is:-
i)A single work of unit...
ii)is successful only when all data modifications that are made in a transaction are committed and are saved in the database permenantly

If transaction is rolled back or cancelled,then it means that the transaction has encountered errors and there are no changes
made to the contents of the datatbase

A transaction can either be committed or rolled back
TCL(TRANSFER CONTROL LANGUAGE) COMMIT,ROLLBACK,SAVEPOINT
*/


select * from fam;

--if you begin trasaction the result on other connection (new/another query) will not be visible...but it can be seen with some terms & conditions
begin transaction; ----> this is called EXPLICIT TRANSACTION
update fam set [name]='khan' where id=1;

rollback transaction; --undo

commit transaction; --saves permemnant in table


--if we run update command without 'begin transaction;' then sql server automatically use following patteren behind the scenes
begin transaction;
update fam set [name]='khan' where id=1;
commit transaction;
--gives us no chance to rollback transaction --> this is called IMPLICIT TRANSACTION;


--can do multiple tasks in transaction..
begin transaction;	----> this is called EXPLICIT TRANSACTION
update fam set [name]='pathan' where id=1;
delete from fam where id=3;
rollback transaction;
--choose one
commit transaction;

/*
Defining Transaction:-	A logical unit of work must exhibit four properties called automicity,consistency,isolation and 
durability (ACID) properties,to qualify a transaction...
1)Automicity:-if the transaction has many operations that all should be committed.it means All or NONE.it manages by TRANSACTION MANAGER.
2)Consistency:-Example 2 bank accounts...cutting from A and send to B must gets completed....not cut from A and then chain breaks
3)Isolation:-The operations that are performed must be isolated from the other operations on the same server or on the same database..it
means each transaction must be executed without knowing what is happening to other transactions
4)Durability:-The operations that are performed on the database must be saved and stored in the database permenantly..


States of transaction as follow
active -->PARTIALLY COMMITTED or failed(then ABORTED and END) -->after partially committed goes to COMMITTED and END

WHEN A TRANSACTION is started on a connection,all TransactSQL statements are executed on the same connection and are a part of the
connection until the transaction ends...BUT transactoins are managed at the connection level...IT happens By setting the isolation
level to read uncommitted -->as by default its read committed...

syntax to change settings:- 'SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED'...
*/

--TRY & CATCH WITH TRANSACTION
use abc;
select * from fam;

begin try
begin transaction
INSERT INTO fam (name,gender,city,salary) values ('bno','female','karachi',1000)
INSERT INTO fam (name,gender,city,salary) values ('ghi123456789748743878347437843784378373874387383748378374387438738743','male','multan',3000)
INSERT INTO fam (name,gender,city,salary) values ('fok','male','lahore',2000)
commit transaction;
print 'insertion successful';
end try
begin catch
rollback transaction;
	select
	ERROR_NUMBER() as [Number Of Errors],
	ERROR_SEVERITY() as [Error Severity],
	ERROR_STATE() as [Error state Number],
	ERROR_PROCEDURE() as [Sp Name],
	ERROR_LINE() as [Error On Line],
	ERROR_MESSAGE() as [Error Message]
end catch

--delete from fam where id >=13;