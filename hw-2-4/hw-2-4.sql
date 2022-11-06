--a.     Попробуйте вывести не просто самую высокую зарплату во всей команде, а вывести именно фамилию сотрудника с самой высокой зарплатой.

select 
"name" 
from staff 
where salary = (select 
max(salary) 
from staff s )
;

--b.     Попробуйте вывести фамилии сотрудников в алфавитном порядке
select 
"name" 
from staff 
order by 1;

--c. Рассчитайте средний стаж для каждого уровня сотрудников

with expirience_days as (
select 
level,
current_date - date_employ experience
from staff s 
)
select distinct 
s.level,
round((avg(experience) over (partition by s."level")), 2)  
from staff s join expirience_days ed on s."level" = ed."level"
order by 2;

--d.     Выведите фамилию сотрудника и название отдела, в котором он работает
select 
s."name",
department 
from staff s 
order by 2;

--e.     Выведите название отдела и фамилию сотрудника с самой высокой зарплатой в данном отделе и саму зарплату также.
with max_s as (
select distinct 
department ,
max(salary) over (partition by s.department) 
from staff s )
select 
"name",
s2.department ,
s2.salary
from staff s2 join max_s ms on s2.department = ms.department
and s2.salary = ms.max;

--f.      *Выведите название отдела, сотрудники которого получат наибольшую премию по итогам года. 
--Как рассчитать премию можно узнать в последнем задании предыдущей домашней работы
with coef as (
select 
s.id_employee ,
department ,
s."name" ,
m.mark,
case 
	when m.mark = 'A' then 1.2
	when m.mark = 'B' then 1.1
	when m.mark = 'D' then -1.1
	when m.mark = 'E' then -1.2
end coef_mark
from 
staff s join marks m on s.id_employee = m.id_employee )
select 
department ,
sum(coef_mark) 
from coef
group by 1
order by 2 desc
limit 1; -- у данного отдела наибольший суммарный коэффициент


--g.    *Проиндексируйте зарплаты сотрудников с учетом коэффициента премии. 
--Для сотрудников с коэффициентом премии больше 1.2 – размер индексации составит 20%, 
--для сотрудников с коэффициентом премии от 1 до 1.2 размер индексации составит 10%. 
--Для всех остальных сотрудников индексация не предусмотрена.
alter table staff add column coef decimal;
alter table staff add column new_salary int;

update staff set coef = mark
from (select mark, name from (with coef as (
select 
s.id_employee ,
s."name" ,
m.mark,
case 
	when m.mark = 'A' then 0.2
	when m.mark = 'B' then 0.1
	when m.mark = 'D' then -0.1
	when m.mark = 'E' then -0.2
end coef_mark
from 
staff s join marks m on s.id_employee = m.id_employee )
select 
id_employee, 
name,
sum(coef_mark) + 1 mark
from coef
group by 1,2
order by 3 desc) t2) t3
where staff."name" = t3.name;

update staff set new_salary = round(salary * 1.2) where coef > 1.2;
update staff set new_salary = round(salary * 1.1) where coef between 1 and 1.2;
update staff set new_salary = salary where coef is null;
