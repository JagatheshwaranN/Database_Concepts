create table if not exists JEmployee
(
	emp_id			varchar(20),
	emp_name		varchar(50),
	salary			int,
	dept_id			varchar(20),
	manager_id		varchar(20)
);
insert into JEmployee values
('E1', 'Rahul', 15000, 'D1', 'M1'),
('E2', 'Manoj', 15000, 'D1', 'M1'),
('E3', 'James', 55000, 'D2', 'M2'),
('E4', 'Michael', 25000, 'D2', 'M2'),
('E5', 'Ali', 20000, 'D10', 'M3'),
('E6', 'Robin', 35000, 'D10', 'M3');

create table if not exists JDepartment
(
	dept_id			varchar(20),
	dept_name		varchar(50)
);
insert into JDepartment values
('D1', 'IT'),
('D2', 'HR'),
('D3', 'Finance'),
('D4', 'Admin');

create table if not exists JManager
(
	manager_id			varchar(20),
	manager_name		varchar(50),
	dept_id				varchar(20)
);
insert into JManager values
('M1', 'Prem', 'D3'),
('M2', 'Shripadh', 'D4'),
('M3', 'Nick', 'D1'),
('M4', 'Cory', 'D1');

create table if not exists JProjects
(
	project_id			varchar(20),
	project_name		varchar(100),
	team_member_id		varchar(20)
);
insert into JProjects values
('P1', 'Data Migration', 'E1'),
('P1', 'Data Migration', 'E2'),
('P1', 'Data Migration', 'M3'),
('P2', 'ETL Tool', 'E1'),
('P2', 'ETL Tool', 'M4');

create table JCompany
(
	company_id		varchar(10),
	company_name	varchar(50),
	location		varchar(20)
);
insert into JCompany values
('C001', 'tech Solutions', 'Kuala Lumpur');

CREATE TABLE family
(
    member_id     VARCHAR(10),
    name          VARCHAR(50),
    age           INT,
    parent_id     VARCHAR(10)
);
insert into family values
  ('F1', 'David', 4, 'F5'),
  ('F2', 'Carol', 10, 'F5'),
  ('F3', 'Michael', 12, 'F5'),
  ('F4', 'Johnson', 36, ''),
  ('F5', 'Maryam', 40, 'F6'),
  ('F6', 'Stewart', 70, ''),
  ('F7', 'Rohan', 6, 'F4'),
  ('F8', 'Asha', 8, 'F4');

select * from JEmployee;
select * from JDepartment;
select * from JManager;
select * from JProjects;
select * from JCompany;
select * from family;

-- INNER JOIN / JOIN
-- 1) Fetch the employee name and department name they belong to.
select emp_name, dept_name
from JEmployee e
join JDepartment d
on e.dept_id = d.dept_id;

-- LEFT JOIN [INNER JOIN + Any additional records in the left table]
-- 2) Fetch all the employee name and their department name they belong to.
select emp_name, dept_name
from JEmployee e
left join JDepartment d
on e.dept_id = d.dept_id;

-- RIGHT JOIN [INNER JOIN + Any additional records in the right table]
-- 3) Fetch all the department name and the employee name they belong to.
select emp_name, dept_name
from JEmployee e
right join JDepartment d
on e.dept_id = d.dept_id;

-- 4) Fetch the details of all employees, their manager, their department and the
-- projects they work on.
select e.emp_name, d.dept_name, m.manager_name, p.project_name
from JEmployee e
left join JDepartment d on e.dept_id = d.dept_id
join JManager m on m.manager_id = e.manager_id
left join JProjects p on p.team_member_id = e.emp_id;

-- FULL OUTER JOIN / FULL JOIN
-- Full Join = Inner Join + All remaining records from Right table + All remaining
-- 			   records from Left table.
select e.emp_name, d.dept_name
from JEmployee e
full join JDepartment d 
on d.dept_id = e.dept_id;

-- CROSS JOIN [Cartesian Product]

-- 5) Write a query to fetch the employee name and their corresponding department name.
-- Also make sure to display the company name and the company location corresponding to
-- each employee.
select e.emp_name, d.dept_name, c.company_name, c.location
from JEmployee e
join JDepartment d
on e.dept_id = d.dept_id
cross join JCompany c;

-- NATURAL JOIN [SQL will decide what the join condition] - Highly Not Recommended
select e.emp_name, d.dept_name
from JEmployee e
natural join JDepartment d;

-- SELF JOIN [When we join a table to itself]

-- 6) Write a query to fetch the child name and their age corresponding to their parent
-- name and parent age.
select child.name as child_name, child.age as child_age,
parent.name as parent_name, parent.age as parent_age
from family as child
join family as parent 
on child.parent_id = parent.member_id;




