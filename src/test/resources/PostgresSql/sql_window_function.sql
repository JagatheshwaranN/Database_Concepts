select *
from employee;

select max(salary) as max_salary
from employee;

select dept_name, max(salary) as max_salary
from employee
group by dept_name;

-- Window Function
-- max(salary) - basically, its an aggregate function.
-- Over clause is also used. Since, Over clause is used, SQL will treat the
-- max(salary) as Window Function and not as aggregate function.
-- Over() is specifically used to inform SQL to create a window of records.
-- When we don't specify any column inside the Over() clause, SQL will create 
-- one window for all the records in the resultset, and it will apply the 
-- aggregate function max(salary). So, it will look for max salary from table 
-- and that value will shown to each record in the resultset.
select e.*, max(salary)
over() as max_salary
from employee e;

-- If we need to get the max salary corresponds to each department, then we need
-- to use the clause "partition by" followed by column name.
select e.*, max(salary)
over(partition by dept_name) as max_salary
from employee e;

-- Row Number
-- row_number - It is used to generate / add unique value to each records.
select e.*,
row_number() over() as row_num
from employee e;

-- To generate row_number based on department.
select e.*,
row_number() over(partition by dept_name) as row_num
from employee e;

-- 1) Fetch the first 2 employees from each department to join the company.
select * 
from ( select e.*, row_number() over (partition by dept_name order by emp_id) as row_num
from employee e) x
where x.row_num < 3;

-- Rank
-- 2) Fetch the top 3 employees in each department earning the max salary.
select *
from (select e.*, rank() over (partition by dept_name order by salary desc) as rank_order
from employee e) x
where x.rank_order < 4;

-- Dense Rank
-- Rank will skip a value for every duplicate records whereas Dense Rank will not
-- skip a value.
select *
from (select e.*, rank() over (partition by dept_name order by salary desc) as rank_order,
dense_rank() over (partition by dept_name order by salary desc) as dense_rank_order
from employee e) x
where x.rank_order < 4;

-- Lag
-- 3) Fetch a query to display if the salary of an employee is higher / lower /
-- equal to the previous employee.
select e.*,
lag (salary) over (partition by dept_name order by emp_id) as prev_emp_salary
from employee e;

-- lag(salary, 2, 0)
-- Here, 2 denotes the level, which means it will show the salary of employee
-- whose is 2 level above the current employee.
-- Here, 0 denotes the default value, for null values it will be replaces as 0.
select e.*,
lag (salary, 2, 0) over (partition by dept_name order by emp_id) as prev_emp_salary
from employee e;

-- Lead (Exact opposite of Lag)
select e.*,
lead (salary) over (partition by dept_name order by emp_id) as next_emp_salary
from employee e;

select e.*,
lead (salary, 2, 0) over (partition by dept_name order by emp_id) as next_emp_salary
from employee e;

-- Use Case
select e.*,
lag (salary) over (partition by dept_name order by emp_id) as prev_emp_salary,
case 
when e.salary > lag(salary) over (partition by dept_name order by emp_id)
then 'Salary Higher than previous employee'
when e.salary < lag(salary) over (partition by dept_name order by emp_id)
then 'Salary lower than previous employee'
when e.salary = lag(salary) over (partition by dept_name order by emp_id)
then 'Salary same as previous employee'
end sal_range
from employee e;


