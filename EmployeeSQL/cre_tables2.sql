--set search_path to test;
-----  alter user <username> SET search_path to test;
CREATE TABLE "departments" (
    "dept_no" varchar(4)   NOT NULL,
    "dept_name" varchar(50)   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "titles" (
    "title_id" varchar(5)   NOT NULL,
    "title" varchar(50)   NOT NULL,
    CONSTRAINT "pk_titles" PRIMARY KEY (
        "title_id"
     )
);

CREATE TABLE "employees" (
    "emp_no" int4   NOT NULL,
    "emp_title_id" varchar(5)   NOT NULL references titles(title_id),
    "birth_date" date   NOT NULL,
    "first_name" varchar(50)   NOT NULL,
    "last_name" varchar(50)   NOT NULL,
    "sex" varchar(1)   check(sex in ('F','I','M')),
    "hire_date" date   check(hire_date > birth_date),
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "dept_emp" (
    "emp_no" int4   NOT NULL references employees(emp_no),
    "dept_no" varchar(4)   NOT NULL references departments(dept_no)
);

CREATE TABLE "dept_manager" (
    "dept_no" varchar(4)   NOT NULL references departments(dept_no),
    "emp_no" int4   NOT NULL references employees(emp_no)
);

CREATE TABLE "salaries" (
    "emp_no" int4   NOT NULL references employees(emp_no),
    "salary" numeric  check(salary >0) 
);

--alter table employees drop CONSTRAINT employees_check;
select count(*) from departments;  	--9 rows
select count(*) from titles;		--7 rows
select count(*) from employees;		--300,024 rows
select count(*) from salaries;		--300,024 rows
select count(*) from dept_emp;		--331,603 rows
select count(*) from dept_manager;	--24 rows

select emp_no,dept_no,count(*) cnt from dept_emp
group by emp_no, dept_no having count(*) > 1
order by cnt desc;
--
select emp_no,count(*) cnt from dept_emp
group by emp_no having count(*) > 1
order by cnt desc;
--
    
