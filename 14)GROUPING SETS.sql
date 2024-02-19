/*
1)GROUPING SETS operator allows you to group together multiple grouping of columns followed by an optional grand total row..
denoted by parantheses '()'..
2)it ius more efficient to use GROUPING SETS operators instead of multiple GROUP BY with UNION/UNION-ALL clauses bcz the latter adds more
processing overhead on the database server...
*/

use abc;

select city,gender,sum(salary) as TOTAL_SALARY 
from fam
group by cube(city,gender);
--OR--
select city,gender,sum(salary) as TOTAL_SALARY 
from fam
group by
grouping sets
(
(city,gender),
(city),
(gender),
()
);



--ORDERING GIVES SAME RESULT BUT IN DIFFREENT ORDER AS WE SET--
select city,gender,sum(salary) as TOTAL_SALARY 
from fam
group by
grouping sets
(
(city,gender),
(city),
(gender),
()
)
order by grouping(city),grouping(gender) asc;





--GROUPING/CUBE IS BETTER THEN USING UNION/UNION_ALL --> A LONG QUERY--
select city,gender,sum(salary) as TOTAL_SALARY 
from fam
group by city,gender
UNION ALL
select city,NULL as [MALE / FEMALE],sum(salary) as TOTAL_SALARY 
from fam
group by city
UNION ALL
select NULL,gender as [MALE / FEMALE],sum(salary) as TOTAL_SALARY 
from fam
group by gender
UNION ALL
select NULL,NULL as [MALE / FEMALE],sum(salary) as TOTAL_SALARY 
from fam
group by ()