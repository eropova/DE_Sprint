/*1. ������� ������� � �������� ����������� � �����������: 
 * ���, ���� ��������, ���� ������ ������, ���������, ������� ���������� (jun, middle, senior, lead), ������� ��������, 
 * ������������� ������, �������/���������� ����(True/False). ��� ���� � ������� ����������� ������ ���� ���������� ����� ��� ������� ����������.*/

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

/*���������� �� �����*/
copy 
staff (name, date_birth, date_employ, position, level, salary, department, driving_licence) 
from './staff.csv' with (format csv);

select * from staff 

/*2. ��� ������� ������� ��������� ��������� ��� ������� ��� ���� ������� � ����������� �� �������.
 � ������� ������ ���� ������������� ��� ������� ������, �������� ������ (��������. ������������� ��� IT �����), ��� ������������ � ���������� �����������.*/	

create table departaments (
	id_department serial PRIMARY KEY,
	name varchar(100),
	chief_name varchar(150),
	size_department int);

/*���������� �� �����*/
copy 
departaments (name, chief_name, size_department) 
from './departaments.csv' with (format csv);


select * from departaments;

/*3.�� ���� ����� ���� � ���������� ����������� ����������� ������. 
 ������ ����� ������������� �� ���������� �������, ������� ���������� �������� � ������ �������� ����. 
 �������� �������, � ������� ��� ������� ���������� ����� ��� ������ �� ������ �������. �������� ������ �� A � ����� �������, �� E � ����� ������.*/

create table marks (
	id_employee int,	
	qr_number int2,	
	year int2,	
	mark varchar(1));

/*���������� �� �����*/

copy 
marks (id_employee, qr_number, year, mark) 
from './marks.csv' with (format csv);

select * from marks m ;


/*5. ���� ������� ����������� � ����������� ������������� ������� ����� ����� � ����� ����������������� ������� ������. 
 * �� ��������� ����� � ������� ������ ������ ������������ ������ � ���� �����������. �������� ����������� ���������� � ��������������� �������.*/

insert into departaments("name", chief_name, size_department  ) values ('intelect_AD', '�������� �.�', 3);

insert into 
	staff(name, date_birth, date_employ, position, level, salary, department, driving_licence)
values 
	('�������� �.�.','22.03.1978','06.11.2022','chief','senior',150, 'intelect_AD',FALSE), 
	('���������� �.�.','30.01.1985','06.11.2022','DA', 'middle',150, 'intelect_AD',TRUE),
	('�������� �.�.','17.10.1982','06.11.2022','DA', 'middle',150, 'intelect_AD',FALSE);



/*6. ������ ������ ���� ������������� ���� ������ � �������� ������� ��� ��������� ��������� ����������:*/

--o   ���������� ����� ����������, ��� ��� � ���� ������ � ��� ���� ����������� ��������
select 
id_employee,
"name" ,
current_date - date_employ as experience
from staff s ;

--o   ���������� ����� ����������, ��� ��� � ���� ������ � ������ ������ 3-� �����������
select 
id_employee,
"name" ,
current_date - date_employ as experience
from staff s 
limit 3;

--o   ���������� ����� ����������� - ���������
select 
id_employee
from staff s 
where driving_licence is true ;

--o   �������� ������ �����������, ������� ���� �� �� 1 ������� �������� ������ D ��� E
select distinct s.id_employee
from staff s join marks m on s.id_employee = m.id_employee 
where m.mark in ('D', 'E');

--o   �������� ����� ������� �������� � ��������.
select 
max(salary) 
from staff s ;

--o   * �������� �������� ������ �������� ������
select 
"name" 
from departaments d  
where size_department = (select max(size_department) from departaments);

--o   * �������� ������ ����������� �� ����� ������� �� ����� ���������
select 
id_employee
from staff s 
order by date_employ;

--o   * ����������� ������� �������� ��� ������� ������ �����������
select distinct 
s.level,
round((avg(salary) over (partition by "level")), 2)  
from staff s
order by 2; 

--o �������� ������� � ����������� � ������������ ������� ������ � �������� �������. ����������� �������������� �� ����� �����: 
--������� �������� ������������ � 1, ������ ������ ��������� �� ����������� ���:
--�         � � ����� 20%
--�         D � ����� 10%
--�         � � ��� ���������
--�         B � ���� 10%
--�         A � ���� 20%
--��������������, ��������� � �������� �, �, �, D � ������ �������� ����������� 1.2.

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


















