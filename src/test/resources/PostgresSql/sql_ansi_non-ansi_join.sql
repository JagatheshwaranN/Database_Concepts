-- ANSI VS NON-ANSI JOIN
select * from employee;
select * from department;

-- ANSI Form
-- 1.	ANSI Join uses the Join Key word.
-- 2.	In ANSI Join, the join condition is provided under On clause.
-- 3.	In ANSI Join, the filter condition is provided under Where clause.
-- 4.	In PostgreSQL, we can write Outer Join only with ANSI Form.

-- NON-ANSI Form
-- 1.	NON-ANSI Join don’t use the Join Key word.
-- 2.	In NON-ANSI Join, the join condition and filter condition are provided under Where clause.
-- 3.	In PostgreSQL, we can’t write Outer Join with NON-ANSI Form whereas its possible with Oracle.
-- 4. 	In Oracle, the (+) operator is used to denote the Left / Right Outer Join based on where we
-- place the operator.

-- 1) Write a query to fetch the employee name and the department they belong to.

-- ANSI FORM
-- INNER JOIN
select e.emp_name, d.dept_name
from employee e
join department d 
on d.dept_name = e.dept_name
where d.dept_name = 'HR';

-- NON-ANSI FORM
-- INNER JOIN
select e.emp_name, d.dept_name
from employee e, department d 
where d.dept_name = e.dept_name
and d.dept_name = 'HR';

-- 2) Write a query to fetch all the employee name and the department they belong to.

-- ANSI FORM
-- OUTER JOIN
select e.emp_name, d.dept_name
from employee e
left join department d 
on d.dept_name = e.dept_name;

-- NON-ANSI FORM
-- OUTER JOIN [Not supported in PostgreSQL. The format is Oracle format.]
select e.emp_name, d.dept_name
from employee e, department d 
where d.dept_name (+) = e.dept_name;

-- 3) Write a query to fetch details of all the employees, managers, their department and the projects.

-- ANSI FORM
-- OUTER JOIN
select e.emp_name, d.dept_name, m.manager_name, p.project_name
from employee e
left join department d on d.dept_id = e.dept_id
right join manager m on m.manager_id = e.manager_id
left join projects p on p.team_member_id = e.emp_id;

-- NON-ANSI FORM
-- OUTER JOIN
select e.emp_name, d.dept_name, m.manager_name, p.project_name
from employee e, department d, manager m, projects p
where d.dept_id (+) = e.dept_id
and m.manager_id = e.manager_id (+)
and p.team_member_id (+) = e.emp_id;


-- ANSI Way Advantages
-- 1. Queries will be shorter, cleaner, and easier to read, understand and debug.
-- 2. Join condition and the Filter condition can be separated.
-- 3. Avoid accidental Cross Joins.
-- 4. ANSI is universally accepted by all RDBMS and Systems.

