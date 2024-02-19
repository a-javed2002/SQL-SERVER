/*
CUBE AND ROLLUP ARE AGGREGATE OPERATORS
WE USE 'CUBE' AND 'ROLLUP' COMMANDS WIRH 'GROUP BY' COMMAND
*/

use abc;
create table fam(
id int primary key identity(1,1),
name varchar(30),
gender varchar(30),
city varchar(30),
salary int
)

insert into fam values ('abd','male','karachi',1000);
insert into fam values ('xyz','female','lahore',2000);
insert into fam values ('sara','male','karachi',3000);
insert into fam values ('sana','female','karachi',1000);
insert into fam values ('hina','male','lahore',4000);
insert into fam values ('fizza','female','multan',1000);
insert into fam values ('mno','female','karachi',2000);
insert into fam values ('pqr','male','lahore',1000);
insert into fam values ('jkl','female','multan',3000);

select * from fam;

select city,sum(salary) as 'TOTAL_SALARY/CITY' from fam
group by city;

select city,gender,sum(salary) as 'TOTAL_SALARY/GENDER' from fam
group by city,gender;

select city,gender,sum(salary) as 'TOTAL_SALARY/GENDER' from fam
group by cube(city,gender);
--OR--
select city,gender,sum(salary) as 'TOTAL_SALARY/GENDER' from fam
group by city,gender with cube;


--	order of grouping columns effects result...--
select city,gender,sum(salary) as 'TOTAL_SALARY/GENDER' from fam
group by cube(gender,city);
--SEE DIFFERENCE--
select city,gender,sum(salary) as 'TOTAL_SALARY/GENDER' from fam
group by cube(gender,city);

/*
CUBE produces super-aggregate row...
it also provides the summary of the rows that the GROUP BY clause generates
*/

--ROLLUP --> it takes care of hierarchy order--
select city,gender,sum(salary) as 'TOTAL_SALARY/GENDER' from fam
group by rollup(city,gender);
--OR--
select city,gender,sum(salary) as 'TOTAL_SALARY/GENDER' from fam
group by city,gender with rollup;

/*
roll-up works like cube but not efficient...dose not produces super-aggregate row...
it arranges the result in asc order....lowest to highest..
follow hierarchcal order

*/

--	group hierarchry in the result is dependent on the order in which the columns that are grouped are specified--
select city,gender,sum(salary) as 'TOTAL_SALARY/GENDER' from fam
group by city,gender with rollup;

select gender,city,sum(salary) as 'TOTAL_SALARY/GENDER' from fam
group by gender,city with rollup;




--OVER CLAUSE WITH PARTITOIN--

select * from fam;
select gender,count(*) as 'TOTAL GENDER' from fam
group by gender;

--GENERATES ERROR
select name,gender,count(*) as 'TOTAL GENDER' from fam
group by gender;


--To OVERCOME THIS ERROR
--TWO WAYS
-->	1)INNER JOIN		2)OVER CLAUSE WITH PARTITOIN

--INNER JOIN--
select name,salary,fam.gender,g.grand_Total
from fam
INNER JOIN
(select gender,count(*) as grand_Total from fam
group by gender) as g
on fam.gender=g.gender;


--OVER CLAUSE WITH PARTITOIN--
select name,salary,gender,count(gender) over (partition by gender) as Grand_Total
from fam;








--Another Example--
select gender,count(*) as Grand_Total,max(salary) as max_salary,min(salary) as min_salary,avg(salary) as avg_salary from fam
group by gender;


--INNER JOIN--
select name,salary,fam.gender,g.grand_Total,g.max_salary,g.min_salary,g.avg_salary
from fam
INNER JOIN
(select gender,count(*) as grand_Total,max(salary) as max_salary,min(salary) as min_salary,avg(salary) as avg_salary from fam
group by gender) as g
on fam.gender=g.gender;


--OVER CLAUSE WITH PARTITOIN--
select name,salary,gender,
count(gender) over (partition by gender) as Grand_Total,
max(salary) over (partition by gender) as max_salary,
min(salary) over (partition by gender) as min_salary,
avg(salary) over (partition by gender) as avg_salary
from fam;

/*
*)The over clause with PARTITION BY is used to split data into partitions.the specified Fn operates for each partition.
*)we can use many aggregate Fn....
*)NON-AGGREGATE COLUMNS CAN BE SHOWN WITH 'GROUP BY' WITH THE HELP OF 'OVER CLAUSE WITH PARTITOIN'...
*)Windowing in sql in done by the over clause that was introduced in sql server 2005...
*)windowing of data in sql server or the window Fn is applied to a set of row(partitioned data based upon some column known
  as a window) to rank or aggregate values in the window or partion set..matlab apnay result may eik window/columns constant hain..
*)windowing basically craetes a window of records for every record..that window is then used for making computations...
*)in contrast,using windowed aggregate Fn instaed of 'GROUP BY',you can retrieve both aggregated & non-aggregated values...
*/