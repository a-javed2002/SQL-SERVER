/*
1)introduced in SQL SERVER 2008
2)merge statement allow to insert,update and delete in one statement using a 'common column'...this means we do not have to use multiple statements
3)merge statement allows you to maintain a target table based on certain join conditions on a source tableusing a single statement
4)Source Table:- contains the changes that need to be applied to the target table
5)Target Table:- The Table that require changes(insert,update & delete)

Things we can do..
1)insert a new row from the source table,if the row is missing in the target table..
2)update a target row if a record already exists in the source table...
3)delete a target row if the row is missing in the source table...
*/

merge tb_1 as T
using tb_2 as S
on T.id=S.id
when matched then
update set T.name=S.name,T.gender=S.gender,T.salary=S.salary
when not matched by target then
insert (id,name,gender,salary) values (S.name,S.gender,S.salary)
when not matched by source then
Delete; --terminator(;) is must..!!!--


--WE CAN USE SINGLE,DUAL OR ALL 3 Conditions--