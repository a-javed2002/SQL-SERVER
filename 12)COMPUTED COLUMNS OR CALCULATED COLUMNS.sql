/*
with the help of other columns calculation performs
computed column can also be a expression
we can use 4 things to compute a column:-
i)non-computed columns
ii)constant
iii)function
iv)operators

TWO TYPES OF COMPUTED COLUMNS
1)PERSISTED
2)NON-PERSISTED

PERSISTED columns save the calculated data in column..while in NON-PERSISTED data is calculated when u run the SELECT COMMAND...
HENCE PERSISTED COLUMNS CONSUME SPACE FOR DATA...AS IT"S VALUE STORED PHYSICALLY
TO MAKE PERSISTED COMPUTED COLUMN WE HAVE TO USE WORD 'PERSISTED'....

COMPUTED COLUMNS UPDATED IF WE UPDATE COLUMNS THAT ARE PRESENT IN COMPUTED COLUMNS...

computed columns can be used in:-
1)SELECT LIST
2)WHERE CLAUSE
3)ORDER BY CLAUSE

CANNOT BE THE TARGET TO INSERT OR UPDATE STATEMENT...
COMPUTED COLUMNS CAN ADD BY ALTER AND DELETE BY DROP...
WE CANNOT CREATE ANOTHER COMPUTED COLUMN FROM ONE COMPUTED COLUMN...
*/

create table xyz(
id int,
name varchar(30),
house_rent_allowance int,
convence_allowance int,
medical_allowance int,
gross_pay as house_rent_allowance + convence_allowance + medical_allowance --non-persisted computed columns--
--gross_pay as house_rent_allowance + convence_allowance + medical_allowance persisted-- --persisted computed columns--
)

alter table xyz add company_name as 'ABC COMPANY';
alter table xyz add date as getDate();

select * FROM xyz;

--we can check computed columns in table design mode...--

alter table xyz add bonus as gross_pay + 2000; --gives error--

alter table xyz drop column gross_pay;


--CREATEING INDEX ON COMPUTED COLUMNS...--

/*
only persisted computed columns have index...
if you put index on non-peristed column..so that column automatically becomes persisted as index needs values...
we can use all types of indexes we have learnt previously
*/