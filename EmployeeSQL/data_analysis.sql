--
--
--
--set search_path to test;
--
select * from employees;
--select max(length(first_name)), max(length(last_name)) from employees;
select * from salaries;
select * from departments;
select * from titles;
select * from 
--
-- (1) To list each employee with their salary....
select 
	 e.emp_no "Employee Number"
	,last_name "Last Name"
	,first_name "First Name"
	,sex "Sex"
	,salary "Salary"
from employees e
	left join salaries s on s.emp_no = e.emp_no
order by e.emp_no;
--
-- (2) To list all employees who were hired in 1986
--
select 
	 first_name "First Name"
	,last_name "Last Name"
	,hire_date "Hire Date"
from employees 
where extract(year from hire_date) = '1986'
order by hire_date,first_name,last_name;
-- curious to see ...
select extract(year from hire_date),count(*) cnt
from employees 
group by extract(year from hire_date) 
order by cnt desc;
--
-- (3) To list managers of each department
--
select 
	 dm.dept_no "Dept. Number"
	,dept_name "Dept. Name"
	,e.emp_no "Employee Number"
	,last_name "Last Name"
	,first_name "First Name"
from employees e
	join dept_manager dm on dm.emp_no = e.emp_no
	join departments d on dm.dept_no = d.dept_no
order by dm.dept_no,last_name,first_name;
--
-- (4) To list employees by department
--
select 
	e.emp_no  "Employee Number"
	,last_name "Last Name"
	,first_name "First Name"
	,dept_name "Dept. Name"
from employees e
	join dept_emp de on de.emp_no = e.emp_no
	join departments d on de.dept_no = d.dept_no
order by dept_name,last_name,first_name;
--
-- (5) To list employees by given filter
--
select 
	 first_name  "First Name" 
	,last_name "Last Name"
	,sex "Sex"
from employees
where first_name = 'Hercules'
  and last_name like 'B%'
order by last_name;
--
-- (6) To list employees in the sales department
--
select 
	e.emp_no  "Employee Number"
	,last_name "Last Name"
	,first_name "First Name"
	,dept_name "Dept. Name"
from employees e
	join dept_emp de on de.emp_no = e.emp_no
	join departments d on de.dept_no = d.dept_no
where dept_name = 'Sales'
order by last_name,first_name;
--
-- (7) To list employees in the sales and Development department
--
select 
	e.emp_no  "Employee Number"
	,last_name "Last Name"
	,first_name "First Name"
	,dept_name "Dept. Name"
from employees e
	join dept_emp de on de.emp_no = e.emp_no
	join departments d on de.dept_no = d.dept_no
where dept_name in ('Sales','Development')
order by dept_name,last_name,first_name;
--
-- (8) To list count of employees share their last name
--
select 
	last_name "Last Name"
	,count(*) cnt
from employees
group by last_name
order by cnt desc;
--