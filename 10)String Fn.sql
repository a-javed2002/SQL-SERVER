select ascii('A');
select ascii('a');

print ascii('A');
print ascii('a');
print ascii(';');

--	select --> output a cell--
--	print --> output a line--

select char(65);

declare @i int
set @i=65
while(@i<=90)
begin
--select ascii(@i)--
print char(@i);
set @i=@i+1
end

/*
ascii()
char()
ltrim()
rtrim()
reverse()
len()
lower()
upper()
*/

select len(emp_name) form tmp;