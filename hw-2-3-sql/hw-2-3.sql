/*1. Создать таблицу с основной информацией о сотрудниках: 
 * ФИО, дата рождения, дата начала работы, должность, уровень сотрудника (jun, middle, senior, lead), уровень зарплаты, 
 * идентификатор отдела, наличие/отсутствие прав(True/False). При этом в таблице обязательно должен быть уникальный номер для каждого сотрудника.*/

create table staff (
	id_employee serial PRIMARY KEY,
	name varchar(150),
	date_birth date,	
	date_employ date,	
	position varchar(50),	
	level varchar(10),	
	salary int,	
	department varchar(50),	
	driving_licence bool);

/*заполнение из файла*/
copy 
staff (name, date_birth, date_employ, position, level, salary, department, driving_licence) 
from './staff.csv' with (format csv);

select * from staff 

/*2. Для будущих отчетов аналитики попросили вас создать еще одну таблицу с информацией по отделам.
 В таблице должен быть идентификатор для каждого отдела, название отдела (например. Бухгалтерский или IT отдел), ФИО руководителя и количество сотрудников.*/	

create table departaments (
	id_department serial PRIMARY KEY,
	name varchar(100),
	chief_name varchar(150),
	size_department int);

/*заполнение из файла*/
copy 
departaments (name, chief_name, size_department) 
from './departaments.csv' with (format csv);


select * from departaments;

/*3.На кону конец года и необходимо выплачивать сотрудникам премию. 
 Премия будет выплачиваться по совокупным оценкам, которые сотрудники получают в каждом квартале года. 
 Создайте таблицу, в которой для каждого сотрудника будут его оценки за каждый квартал. Диапазон оценок от A – самая высокая, до E – самая низкая.*/

create table marks (
	id_employee int,	
	qr_number int2,	
	year int2,	
	mark varchar(1));

/*заполнение из файла*/

copy 
marks (id_employee, qr_number, year, mark) 
from './marks.csv' with (format csv);

select * from marks m ;


/*5. Ваша команда расширяется и руководство запланировало открыть новый отдел – отдел Интеллектуального анализа данных. 
 * На начальном этапе в команду наняли одного руководителя отдела и двух сотрудников. Добавьте необходимую информацию в соответствующие таблицы.*/

insert into departaments("name", chief_name, size_department  ) values ('intelect_AD', 'Голубева М.Н', 3);

insert into 
	staff(name, date_birth, date_employ, position, level, salary, department, driving_licence)
values 
	('Голубева М.Н.','22.03.1978','06.11.2022','chief','senior',150, 'intelect_AD',FALSE), 
	('Голубчиков Н.П.','30.01.1985','06.11.2022','DA', 'middle',150, 'intelect_AD',TRUE),
	('Голубцов П.Р.','17.10.1982','06.11.2022','DA', 'middle',150, 'intelect_AD',FALSE);



/*6. Теперь пришла пора анализировать наши данные – напишите запросы для получения следующей информации:*/

--o   Уникальный номер сотрудника, его ФИО и стаж работы – для всех сотрудников компании
select 
id_employee,
"name" ,
current_date - date_employ as experience
from staff s ;

--o   Уникальный номер сотрудника, его ФИО и стаж работы – только первых 3-х сотрудников
select 
id_employee,
"name" ,
current_date - date_employ as experience
from staff s 
limit 3;

--o   Уникальный номер сотрудников - водителей
select 
id_employee
from staff s 
where driving_licence is true ;

--o   Выведите номера сотрудников, которые хотя бы за 1 квартал получили оценку D или E
select distinct s.id_employee
from staff s join marks m on s.id_employee = m.id_employee 
where m.mark in ('D', 'E');

--o   Выведите самую высокую зарплату в компании.
select 
max(salary) 
from staff s ;

--o   * Выведите название самого крупного отдела
select 
"name" 
from departaments d  
where size_department = (select max(size_department) from departaments);

--o   * Выведите номера сотрудников от самых опытных до вновь прибывших
select 
id_employee
from staff s 
order by date_employ;

--o   * Рассчитайте среднюю зарплату для каждого уровня сотрудников
select distinct 
s.level,
round((avg(salary) over (partition by "level")), 2)  
from staff s
order by 2; 

--o Добавьте столбец с информацией о коэффициенте годовой премии к основной таблице. Коэффициент рассчитывается по такой схеме: 
--базовое значение коэффициента – 1, каждая оценка действует на коэффициент так:
--·         Е – минус 20%
--·         D – минус 10%
--·         С – без изменений
--·         B – плюс 10%
--·         A – плюс 20%
--Соответственно, сотрудник с оценками А, В, С, D – должен получить коэффициент 1.2.

with coef as (
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
sum(coef_mark)+1 
from coef
group by 1,2
order by 3 desc;


















