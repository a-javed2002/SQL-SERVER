create database aptech;
use aptech;

create table students(
student_id int identity primary key,
std_name varchar(20),
age int
);

create table subjects(
subject_id int identity primary key,
sub_name varchar(20),
teacher varchar(20),
);

create table detail(
student_id int,
subject_id int,
marks int,
FOREIGN KEY (student_id) REFERENCES students(student_id),
FOREIGN KEY (subject_id) REFERENCES subjects(subject_id)
);


insert into students values('Akon',17);
insert into students values('Bkon',18);
insert into students values('Ckon',17);
insert into students values('Dkon',18);


insert into subjects values('java','Mr.J');
insert into subjects values('C++','Miss C');
insert into subjects values('C#','Mr C Hash');
insert into subjects values('Php','Mr. P H P');


insert into detail values(1,1,98);
insert into detail values(1,2,78);
insert into detail values(2,1,76);
insert into detail values(3,2,88);

--11--
select * from detail as A inner join students as B on A.student_id=B.student_id;
select * from detail as A inner join students as B on A.student_id=B.student_id where B.std_name='akon';
select B.std_name,sum(A.marks) from detail as A inner join students as B on A.student_id=B.student_id group by B.std_name having B.std_name='akon';

--12--
select B.std_name from detail as A inner join students as B on A.student_id=B.student_id where marks=(select max(marks) from detail)

--13--
select * from detail as A inner join subjects as B on A.subject_id=B.subject_id where B.sub_name='php';

--14--
select count(A.student_id) as [Student/teacher] from detail as A inner join subjects as B on A.subject_id=B.subject_id where B.teacher='MR.J';

--15--
select B.std_name,C.sub_name,C.teacher,A.marks from detail as A inner join students as B on A.student_id=B.student_id inner join subjects as C on A.subject_id=C.subject_id;

--16--

