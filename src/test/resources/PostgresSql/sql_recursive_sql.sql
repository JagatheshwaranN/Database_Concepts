DROP TABLE emp_details;
CREATE TABLE emp_details
    (
        id           int PRIMARY KEY,
        name         varchar(100),
        manager_id   int,
        salary       int,
        designation  varchar(100)

    );

INSERT INTO emp_details VALUES (1,  'Shripadh', NULL, 10000, 'CEO');
INSERT INTO emp_details VALUES (2,  'Satya', 5, 1400, 'Software Engineer');
INSERT INTO emp_details VALUES (3,  'Jia', 5, 500, 'Data Analyst');
INSERT INTO emp_details VALUES (4,  'David', 5, 1800, 'Data Scientist');
INSERT INTO emp_details VALUES (5,  'Michael', 7, 3000, 'Manager');
INSERT INTO emp_details VALUES (6,  'Arvind', 7, 2400, 'Architect');
INSERT INTO emp_details VALUES (7,  'Asha', 1, 4200, 'CTO');
INSERT INTO emp_details VALUES (8,  'Maryam', 1, 3500, 'Manager');
INSERT INTO emp_details VALUES (9,  'Reshma', 8, 2000, 'Business Analyst');
INSERT INTO emp_details VALUES (10, 'Akshay', 8, 2500, 'Java Developer');

Select * from emp_details;

-- Recursive SQL Syntax
WITH [RECURSIVE] CTE_Name AS
	(SELECT query (Non Recursive query or the Base query)
	 UNION [ALL]
	 SELECT query (Recursive query using CTE_Name [with a termination condition])
	)
SELECT * FROM CTE_Name;

-- Things we need for Recursive SQL query,
-- 1. With clause
-- 2. Recursive keyword
-- 3. Base Query
-- 4. UNION [ALL] operator
-- 5. Recursive query 
-- 6. Terminate condition
-- 7. Main query.

-- Notes
-- As soon as the recursive SQL query got executed. The first thing, the SQL will
-- do is, it will come to know that its a Recursive SQL query, then it will find
-- for the base query and execute the same. Since, its a Recursive SQL query, the
-- same query will be executed multiple times until the termination condition met.
-- On the very first iteration, the base query will get executed and the output of 
-- the base query comes from the first iteration will become the input for the 
-- Recursive query defined. In the second iteration of the query, the Recursive
-- part of the query will get executed, here it will use the data retrieved from
-- the previous iteration and also it checks for the termination condition. If the
-- termination condition not met, then the next iteration will execute by taking the
-- output of the previous iteration.

-- Queries
-- 1) Display number from 1 to 10 without using any built in functions.
with recursive numbers as
	(select 1 as num_list
	union 
	select num_list + 1
	from numbers where num_list < 10)
select * from numbers;
	
-- 2) Find the hierarchy of employees under a given manager "Asha".
with recursive employee_hierarchy as
	(select id, name, manager_id, designation, 1 as org_level
	 from emp_details where name = 'Asha'
	 union
	 select e.id, e.name, e.manager_id, e.designation, h.org_level+1 as org_level
	 from employee_hierarchy h
	 join emp_details e on h.id = e.manager_id
	)
select * from employee_hierarchy;

-- To get Manager Detail along with above details
with recursive employee_hierarchy as
	(select id, name, manager_id, designation, 1 as org_level
	 from emp_details where name = 'Asha'
	 union
	 select e.id, e.name, e.manager_id, e.designation, h.org_level+1 as org_level
	 from employee_hierarchy h
	 join emp_details e on h.id = e.manager_id
	)
select h2.id as emp_id, h2.name as emp_name, e2.name as manage_name, h2.org_level
from employee_hierarchy h2
join emp_details e2 on e2.id=h2.manager_id;

-- In Oracle / MySQL
-- with employee_hierarchy as
-- 	(select id, name, manager_id, designation, 1 as org_level
-- 	 from emp_details where name = 'Asha'
-- 	 union all
-- 	 select e.id, e.name, e.manager_id, e.designation, h.org_level+1 as org_level
-- 	 from employee_hierarchy h
-- 	 join emp_details e on h.id = e.manager_id
-- 	)
-- select * from employee_hierarchy;

-- Microsoft SQL Server / Oracle 
-- with employee_hierarchy (id, name, manager_id, designation, org_level) as
-- 	(select id, name, manager_id, designation, 1 as org_level
-- 	 from emp_details where name = 'Asha'
-- 	 union all
-- 	 select e.id, e.name, e.manager_id, e.designation, h.org_level+1 as org_level
-- 	 from employee_hierarchy h
-- 	 join emp_details e on h.id = e.manager_id
-- 	)
-- select * from employee_hierarchy;


-- 3) Find the hierarchy of managers for a given employee "David".
with recursive employee_hierarchy as
	(select id, name, manager_id, designation, 1 as org_level
	 from emp_details where name = 'David'
	 union
	 select e.id, e.name, e.manager_id, e.designation, h.org_level+1 as org_level
	 from employee_hierarchy h
	 join emp_details e on h.manager_id = e.id
	)
select h2.id as emp_id, h2.name as emp_name, e2.name as manage_name, h2.org_level
from employee_hierarchy h2
join emp_details e2 on e2.id=h2.manager_id;




