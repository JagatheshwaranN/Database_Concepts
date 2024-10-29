-- Sub Queries
create table department
(
	dept_id		int ,
	dept_name	varchar(50) PRIMARY KEY,
	location	varchar(100)
);
insert into department values (1, 'Admin', 'Bangalore');
insert into department values (2, 'HR', 'Bangalore');
insert into department values (3, 'IT', 'Bangalore');
insert into department values (4, 'Finance', 'Mumbai');
insert into department values (5, 'Marketing', 'Bangalore');
insert into department values (6, 'Sales', 'Mumbai');

CREATE TABLE EMPLOYEE
(
    EMP_ID      INT PRIMARY KEY,
    EMP_NAME    VARCHAR(50) NOT NULL,
    DEPT_NAME   VARCHAR(50) NOT NULL,
    SALARY      INT,
    constraint fk_emp foreign key(dept_name) references department(dept_name)
);
insert into employee values(101, 'Mohan', 'Admin', 4000);
insert into employee values(102, 'Rajkumar', 'HR', 3000);
insert into employee values(103, 'Akbar', 'IT', 4000);
insert into employee values(104, 'Dorvin', 'Finance', 6500);
insert into employee values(105, 'Rohit', 'HR', 3000);
insert into employee values(106, 'Rajesh',  'Finance', 5000);
insert into employee values(107, 'Preet', 'HR', 7000);
insert into employee values(108, 'Maryam', 'Admin', 4000);
insert into employee values(109, 'Sanjay', 'IT', 6500);
insert into employee values(110, 'Vasudha', 'IT', 7000);
insert into employee values(111, 'Melinda', 'IT', 8000);
insert into employee values(112, 'Komal', 'IT', 10000);
insert into employee values(113, 'Gautham', 'Admin', 2000);
insert into employee values(114, 'Manisha', 'HR', 3000);
insert into employee values(115, 'Chandni', 'IT', 4500);
insert into employee values(116, 'Satya', 'Finance', 6500);
insert into employee values(117, 'Adarsh', 'HR', 3500);
insert into employee values(118, 'Tejaswi', 'Finance', 5500);
insert into employee values(119, 'Cory', 'HR', 8000);
insert into employee values(120, 'Monica', 'Admin', 5000);
insert into employee values(121, 'Rosalin', 'IT', 6000);
insert into employee values(122, 'Ibrahim', 'IT', 8000);
insert into employee values(123, 'Vikram', 'IT', 8000);
insert into employee values(124, 'Dheeraj', 'IT', 11000);

create table sales
(
	store_id  		int,
	store_name  	varchar(50),
	product_name	varchar(50),
	quantity		int,
	price	     	int
);
insert into sales values
(1, 'Apple Store 1','iPhone 13 Pro', 1, 1000),
(1, 'Apple Store 1','MacBook pro 14', 3, 6000),
(1, 'Apple Store 1','AirPods Pro', 2, 500),
(2, 'Apple Store 2','iPhone 13 Pro', 2, 2000),
(3, 'Apple Store 3','iPhone 12 Pro', 1, 750),
(3, 'Apple Store 3','MacBook pro 14', 1, 2000),
(3, 'Apple Store 3','MacBook Air', 4, 4400),
(3, 'Apple Store 3','iPhone 13', 2, 1800),
(3, 'Apple Store 3','AirPods Pro', 3, 750),
(4, 'Apple Store 4','iPhone 12 Pro', 2, 1500),
(4, 'Apple Store 4','MacBook pro 16', 1, 3500);


select * from employee;
select * from department;

-- Problem Solving

-- 1) Find the employees whose salary is more than the avg salary earned by all employees.

select *   -- Main / Outer Query
from employee
where salary > (select avg(salary) from employee -- Sub / Inner Query
);

-- We have 3 types of Sub Queries in SQL.
-- Scalar
-- Multiple Row
-- Correlated

-- Scalar SubQuery
-- It will return one row and one column. It can be used in from and where clauses.
-- Above query is modified to have subquery in from clause.

select avg(salary) sal from employee;

select e.*
from employee e
join (select avg(salary) sal from employee) avg_sal
on e.salary > avg_sal.sal;

-- Multiple Row SubQuery
-- Subquery which returns multiple rows and columns.
-- Subquery which returns single column and multiple rows.

-- 2) Find the employees who earn the highesh salary in each department.

-- Multiple rows and columns
select dept_name, max(salary) 
from employee 
group by dept_name;

select * 
from employee
where (dept_name, salary) in ( select dept_name, max(salary) 
from employee 
group by dept_name
);

-- 3) Find the department who do not have any employees.

-- Single column and multiple rows
select distinct dept_name from employee;

select *  
from department
where dept_name not in (select distinct dept_name from employee
);

-- Correlated SubQuery
-- A Subquery which is related to the outer query.

-- 4) Find the employees in each department who earn more than the average salary
-- in that department.

select avg(salary) from employee where dept_name = "specific_department";

select * 
from employee e1
where salary > ( select avg(salary) 
				 from employee e2
				 where e2.dept_name = e1.dept_name);

-- Sub Queries can be used in 4 clauses as below.
-- SELECT
-- FROM
-- WHERE
-- HAVING

-- 5) Find the department who do not have any employees using Correlated SubQueries.

select * 
from department d
where not exists (
select 1 
from employee e 
where e.dept_name = d.dept_name);

-- Nested Sub Queries

-- 6) Find the stores whose sales is better than the average sales across all stores.

select *
from ( select store_name, sum(price) as total_sales
	   from sales
	   group by store_name) sales
join ( select avg(total_sales) as avg_sales
	   from ( select store_name, sum(price) as total_sales
	   from sales
	   group by store_name)) as avg_sales
on sales.total_sales > avg_sales.avg_sales;

-- With clause is used to replace the sub queries which is used in multiple places.
with sales as ( select store_name, sum(price) as total_sales
	   from sales
	   group by store_name )
select *
from sales
join ( select avg(total_sales) as avg_sales
       from sales ) avg_sales
on sales.total_sales > avg_sales.avg_sales;

-- Not Recommended [Using Sub Query in Select Clause]

-- 7) Fetch all the employee details and add remarks to those employees who earn more
-- than the average pay.

select *,
(case when salary > (select avg(salary) from employee)
 			then 'higher than average'
 		else null
 end) as remarks
from employee;

-- Modifying above query

select *,
(case when salary > avg_sal.sal
 			then 'higher than average'
 		else null
 end) as remarks
from employee
cross join (select avg(salary) sal from employee) avg_sal; 

