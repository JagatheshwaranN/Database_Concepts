CREATE TABLE Product_Details (
    Product_Category VARCHAR(50) NOT NULL,          -- Category of the product (e.g., Electronics, Clothing)
    Brand VARCHAR(50) NOT NULL,                     -- Brand of the product
    Product_Name VARCHAR(100) NOT NULL,             -- Name of the product
    Price NUMERIC(10, 2) NOT NULL                   -- Price with two decimal precision
);

INSERT INTO Product_Details (Product_Category, Brand, Product_Name, Price) VALUES
    ('Phone', 'Apple', 'iPhone 13', 1099.99),
	('Phone', 'Apple', 'iPhone 14 pro', 1299.99),
	('Phone', 'Samsung', 'Galaxy S5', 899.99),
	('Phone', 'Samsung', 'Galaxy S8', 999.99),
    ('Phone', 'OnePlus', 'OnePlus 10', 829.99),
	('Phone', 'OnePlus', 'OnePlus 11', 929.99);
INSERT INTO Product_Details (Product_Category, Brand, Product_Name, Price) VALUES
    ('Laptop', 'Apple', 'MacBook Pro 2', 1399.99),
    ('Laptop', 'Dell', 'XPS 15', 1099.99),
    ('Laptop', 'Microsoft', 'Surface Valve', 1499.99);
INSERT INTO Product_Details (Product_Category, Brand, Product_Name, Price) VALUES
    ('Earphone', 'Apple', 'AirPods', 199.99),
    ('Earphone', 'Samsung', 'Galaxy Buds', 149.99),
    ('Earphone', 'Sony', 'WF-1000XM4', 279.99);
INSERT INTO Product_Details (Product_Category, Brand, Product_Name, Price) VALUES
    ('Headphone', 'Apple', 'AirPods Max', 549.99),
    ('Headphone', 'Samsung', 'Level On', 229.99),
    ('Headphone', 'Microsoft', 'Surface Headphones', 249.99);
INSERT INTO Product_Details (Product_Category, Brand, Product_Name, Price) VALUES
    ('Smartwatch', 'Apple', 'Apple Watch', 399.99),
    ('Smartwatch', 'Samsung', 'Galaxy Watch', 299.99),
    ('Smartwatch', 'OnePlus', 'OnePlus Watch', 159.99);

select * from product_details;

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
-- Rank will skip a value for every duplicate record whereas Dense Rank will not
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
-- Here, 0 denotes the default value, for null values it will be replaced as 0.
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

-- First_Value
-- 4) Write a query to display the most expensive product under each category
-- (corresponding to each record)
select *,
first_value(product_name) over (partition by product_category order by price desc)
as most_exp_prod
from product_details;

-- Last Value
-- 5) Write a query to display the least expensive product under each category 
-- (corresponding to each record)
select *,
first_value(product_name) over (partition by product_category order by price desc)
as most_exp_prod,
last_value(product_name) over (partition by product_category order by price desc)
as least_exp_prod
from product_details;

-- Frame Clause
	-- Whenever we are using a window function, it creates a window / partition and it
	-- applies that window functions to each of the paritions. Inside each of these 
	-- partitions again we create a subset records called as Frames.
	-- So, basically a frame is a subset of a partition.
select *,
first_value(product_name) over (partition by product_category order by price desc)
as most_exp_prod,
last_value(product_name) over (partition by product_category order by price desc
range between unbounded preceding and current row) -- Default Frame Clause
as least_exp_prod
from product_details;

-- Default Frame Clause
-- Though we mention this 'range between unbounded preceding and current row' or not.
-- Sql will consider it by default.
-- range - tells what is the range of records this last value window function to consider.
-- unbounded preceding - means it basically the rows preceding to the current row.
-- unbounded basically means the very first row of the partition.

-- Fix
select *,
first_value(product_name) over (partition by product_category order by price desc)
as most_exp_prod,
last_value(product_name) over (partition by product_category order by price desc
range between unbounded preceding and unbounded following) -- Custom Frame Clause
as least_exp_prod
from product_details;

select *,
first_value(product_name) over (partition by product_category order by price desc)
as most_exp_prod,
last_value(product_name) over (partition by product_category order by price desc
rows between unbounded preceding and unbounded following)
as least_exp_prod
from product_details
where product_category = 'Phone';

select *,
first_value(product_name) over (partition by product_category order by price desc)
as most_exp_prod,
last_value(product_name) over (partition by product_category order by price desc
rows between unbounded preceding and current row)
as least_exp_prod
from product_details
where product_category = 'Phone';

select *,
first_value(product_name) over (partition by product_category order by price desc)
as most_exp_prod,
last_value(product_name) over (partition by product_category order by price desc
range between 2 preceding and 2 following)
as least_exp_prod
from product_details
where product_category = 'Phone';