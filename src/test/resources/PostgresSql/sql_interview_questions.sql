-- Problem Statement 1

-- Find the distance travelled by each car per day.

-- Suppose you have a car travelling certain distance and the data is presented
-- as follows:
-- Day 1 - 50 Kms
-- Day 2 - 100 Kms
-- Day 3 - 200 Kms

-- Now the distance is a cumulative sum as in:
-- Row 2 = (Kms travelled by car on that day + Row 1 kms)

-- How should we create a table in the form of Kms travelled by the car on a 
-- given day and not the sum of the total distance?

select * from car_travels

select *, 
(cumulative_distance - lag(cumulative_distance, 1, 0)
	over (partition by cars order by cars))
as distance_travelled
from car_travels;

-- Dataset
drop table emp_input;
create table emp_input
(
id      int,
name    varchar(40)
);
insert into emp_input values (1, 'Emp1');
insert into emp_input values (2, 'Emp2');
insert into emp_input values (3, 'Emp3');
insert into emp_input values (4, 'Emp4');
insert into emp_input values (5, 'Emp5');
insert into emp_input values (6, 'Emp6');
insert into emp_input values (7, 'Emp7');
insert into emp_input values (8, 'Emp8');

select * from emp_input;

-- Problem Statement 2

-- Convert the Row level data to Column level data. Also, Combine the data of pair of rows
-- using comma.

select *, 
ntile(4) over(order by id) as buckets
from emp_input;

select concat(id,' ', name) as name,
ntile(4) over(order by id) as buckets
from emp_input;

with cte as
(select concat(id,' ', name) as name,
ntile(4) over(order by id) as buckets
from emp_input)
select string_agg(name, ', ') as final_result
from cte
group by buckets
order by 1;

-- Leet Code Problem [Problem Statement 3]

-- Table: Tree
-- +-------------+------+
-- | Column Name | Type |
-- +-------------+------+
-- | id          | int  |
-- | p_id        | int  |
-- +-------------+------+
-- id is the column with unique values for this table.
-- Each row of this table contains information about the id of a node and the id of its parent 
-- node in a tree.
-- The given structure is always a valid tree.
 
-- Each node in the tree can be one of three types:

-- "Leaf": if the node is a leaf node.
-- "Root": if the node is the root of the tree.
-- "Inner": If the node is neither a leaf node nor a root node.
-- Write a solution to report the type of each node in the tree.

-- Return the result table in any order.

-- The result format is in the following example.

-- Example 1:

-- Input: 
-- Tree table:
-- +----+------+
-- | id | p_id |
-- +----+------+
-- | 1  | null |
-- | 2  | 1    |
-- | 3  | 1    |
-- | 4  | 2    |
-- | 5  | 2    |
-- +----+------+
-- Output: 
-- +----+-------+
-- | id | type  |
-- +----+-------+
-- | 1  | Root  |
-- | 2  | Inner |
-- | 3  | Leaf  |
-- | 4  | Leaf  |
-- | 5  | Leaf  |
-- +----+-------+
-- Explanation: 
-- Node 1 is the root node because its parent node is null and it has child nodes 2 and 3.
-- Node 2 is an inner node because it has parent node 1 and child node 4 and 5.
-- Nodes 3, 4, and 5 are leaf nodes because they have parent nodes and they do not have child nodes.

-- Example 2:
-- Input: 
-- Tree table:
-- +----+------+
-- | id | p_id |
-- +----+------+
-- | 1  | null |
-- +----+------+
-- Output: 
-- +----+-------+
-- | id | type  |
-- +----+-------+
-- | 1  | Root  |
-- +----+-------+
-- Explanation: If there is only one node on the tree, you only need to output its root attributes.

-- Dataset
drop table tree;

create table tree
(
id      int,
p_id    int
);

insert into tree values (1, null);
insert into tree values (2, 1);
insert into tree values (3, 1);
insert into tree values (4, 2);
insert into tree values (5, 2);

select * from tree;

select *,
case when p_id is null then 'Root'
	 when p_id is not null and id in (select distinct p_id from tree) then 'Inner'
	 else 'Leaf'
end as type
from tree;

-- Problem Statement 4

-- Dataset PostgreSQL
drop table files;

create table files
(
id              int primary key,
date_modified   date,
file_name       varchar(50)
);

insert into files values (1	,   to_date('2021-06-03','yyyy-mm-dd'), 'thresholds.svg');
insert into files values (2	,   to_date('2021-06-01','yyyy-mm-dd'), 'redrag.py');
insert into files values (3	,   to_date('2021-06-03','yyyy-mm-dd'), 'counter.pdf');
insert into files values (4	,   to_date('2021-06-06','yyyy-mm-dd'), 'reinfusion.py');
insert into files values (5	,   to_date('2021-06-06','yyyy-mm-dd'), 'tonoplast.docx');
insert into files values (6	,   to_date('2021-06-01','yyyy-mm-dd'), 'uranian.pptx');
insert into files values (7	,   to_date('2021-06-03','yyyy-mm-dd'), 'discuss.pdf');
insert into files values (8	,   to_date('2021-06-06','yyyy-mm-dd'), 'nontheologically.pdf');
insert into files values (9	,   to_date('2021-06-01','yyyy-mm-dd'), 'skiagrams.py');
insert into files values (10,   to_date('2021-06-04','yyyy-mm-dd'), 'flavors.py');
insert into files values (11,   to_date('2021-06-05','yyyy-mm-dd'), 'nonv.pptx');
insert into files values (12,   to_date('2021-06-01','yyyy-mm-dd'), 'under.pptx');
insert into files values (13,   to_date('2021-06-02','yyyy-mm-dd'), 'demit.csv');
insert into files values (14,   to_date('2021-06-02','yyyy-mm-dd'), 'trailings.pptx');
insert into files values (15,   to_date('2021-06-04','yyyy-mm-dd'), 'asst.py');
insert into files values (16,   to_date('2021-06-03','yyyy-mm-dd'), 'pseudo.pdf');
insert into files values (17,   to_date('2021-06-03','yyyy-mm-dd'), 'unguarded.jpeg');
insert into files values (18,   to_date('2021-06-06','yyyy-mm-dd'), 'suzy.docx');
insert into files values (19,   to_date('2021-06-06','yyyy-mm-dd'), 'anitsplentic.py');
insert into files values (20,   to_date('2021-06-03','yyyy-mm-dd'), 'tallies.py');

select * from files;

-- A DB contains a list of filenames including their extensions and the dates they were last
-- modified. For each date that a modification was made, return the date, the extension(s) 
-- of the files that were modified the most, and the number of files modified that date. If
-- more than one file extension ties for the most modifications, return them as a comma
-- delimited list in reverse order.

select * from files order by 2;

-- Problem Breakdown
-- 1. Fetch the file extension
select * , position('.' in file_name)
from files;

select date_modified, substring(file_name, (position('.' in file_name)+1)) as file_ext
from files;

-- 2. For each day, how many times each file extension was modified
select date_modified, substring(file_name, (position('.' in file_name)+1)) as file_ext, count(1) as cnt
from files
group by date_modified, file_ext
order by 1;

-- 3. For each day, fetch the most modified file extension from #2
with cte as 
(select date_modified, substring(file_name, (position('.' in file_name)+1)) as file_ext, count(1) as cnt
from files
group by date_modified, file_ext
order by 1)
select * 
from cte c1
where cnt = (select max(cnt) from cte c2
where c2.date_modified = c1.date_modified);

-- 4. If there is tie, then concatenate the multiple file extension
with cte as 
(select date_modified, substring(file_name, (position('.' in file_name)+1)) as file_ext, count(1) as cnt
from files
group by date_modified, file_ext
order by 1)
select date_modified, 
string_agg(file_ext, ', ' order by file_ext desc) as extension,
max(cnt) as count
from cte c1
where cnt = (select max(cnt) from cte c2
where c2.date_modified = c1.date_modified)
group by date_modified;

-- Problem Statement 5

-- Dataset
create table emp_hierarchy
(emp_id int,
reporting_id int);

insert into emp_hierarchy values (1, null);
insert into emp_hierarchy values (2, 1);
insert into emp_hierarchy values (3, 1);
insert into emp_hierarchy values (4, 2);
insert into emp_hierarchy values (5, 2);
insert into emp_hierarchy values (6, 3);
insert into emp_hierarchy values (7, 3);
insert into emp_hierarchy values (8, 4);
insert into emp_hierarchy values (9, 4);

select * from emp_hierarchy;

-- Find the hierarchy of employees

-- For each employee, showcase all the employee's working under them (including themselves)
-- Such that, when the child tree expands i.e. every new employee should be dynamically 
-- assigned to their managers till the top level hierarchy.

Recursive SQL syntax
with recursive cte as
	(base query 
	union all
	recursive part of the query
	termination / exit condition)
select *
from cte;

with recursive cte as 
	(select emp_id, emp_id as employee_hierarchy
	from emp_hierarchy
	union all
	select cte.emp_id, eh.emp_id as employee_hierarchy
	from cte
	join emp_hierarchy eh on cte.employee_hierarchy = eh.reporting_id)
select * 
from cte
order by emp_id, employee_hierarchy;

-- 1st Iteration
select emp_id, emp_id as employee_hierarchy
from emp_hierarchy where emp_id = 1;

-- 2nd Iteration
select cte.emp_id, eh.emp_id as employee_hierarchy
	from (select emp_id, emp_id as employee_hierarchy
			from emp_hierarchy where emp_id = 1) cte
	join emp_hierarchy eh on cte.employee_hierarchy = eh.reporting_id;

-- 3rd Iteration
select cte.emp_id, eh.emp_id as employee_hierarchy
	from (select cte.emp_id, eh.emp_id as employee_hierarchy
			from (select emp_id, emp_id as employee_hierarchy
					from emp_hierarchy where emp_id = 1) cte
			join emp_hierarchy eh on cte.emp_id = eh.reporting_id)cte
	join emp_hierarchy eh on cte.employee_hierarchy = eh.reporting_id;


-- Problem Statement 6
-- Data set
drop table arbitrary_values;

CREATE TABLE arbitrary_values (
    val VARCHAR[]
);

insert into arbitrary_values (val) values (Array['a1', 'a2', 'a3', 'a4', 'a5', 'a6', 'a7', 'a8', 'a9', 'a10', 'a11', 'a12', 'a13', 'a14', 'a15', 'a16', 'a17', 'a18', 'a19', 'a20', 'a21']);

select * from arbitrary_values;

-- Given is a list of abritary values. They can either be comma separated values in a single
-- row column or they could be values spread across multiple rows. Write an SQL Query to group
-- these arbitrary values as per the expected output.

-- Step by Step approach

-- Convert the column level data to row level data
select unnest(val) from arbitrary_values;

-- Adding unique identifier with ordinality
select x.*
from arbitrary_values
cross join unnest(val) with ordinality x(val, index);

with recursive cte as
	(select *, 1 as iterator, max(index) over() as max_index
	from cte_values where index = 1
	union
	select cv.*, (iterator+1), max(cv.index) over() as max_index
	from cte
	join cte_values cv on cv.index between max_index+1 and max_index+1+iterator
	),
cte_values as
	(select x.*
	from arbitrary_values
	cross join unnest(val) with ordinality x(val, index))
select iterator as grp, string_agg(val, ' , ') as values 
from cte
group by iterator
order by iterator;




