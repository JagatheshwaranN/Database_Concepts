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

select * from JEmployee;
select * from JDepartment;
select * from JManager;
select * from JProjects;

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


