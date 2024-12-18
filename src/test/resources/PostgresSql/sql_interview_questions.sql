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

-- Convert the column level array data to row level text data
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

-- Problem Statement 7
-- Data set
drop table weather;

create table weather
(
id int,
city varchar(50),
temperature int,
day date
);

delete from weather;

insert into weather values
(1, 'London', -1, to_date('2021-01-01','yyyy-mm-dd')),
(2, 'London', -2, to_date('2021-01-02','yyyy-mm-dd')),
(4, 'London', 1, to_date('2021-01-04','yyyy-mm-dd')),
(5, 'London', -2, to_date('2021-01-05','yyyy-mm-dd')),
(6, 'London', -5, to_date('2021-01-06','yyyy-mm-dd')),
(8, 'London', 5, to_date('2021-01-08','yyyy-mm-dd')),
(9, 'London', 7, to_date('2021-01-09','yyyy-mm-dd')),
(10, 'London', -4, to_date('2021-01-10','yyyy-mm-dd')),
(11, 'London', -2, to_date('2021-01-11','yyyy-mm-dd')),
(12, 'London', -4, to_date('2021-01-12','yyyy-mm-dd'));


select * from weather;

-- Type 1: SQL Query to fetch "N" consecutive records when temperature is below 0.

-- Fetch the temperature below 0.
select * from weather where temperature < 0;

-- Add a unique row number to the data
select *, row_number() over(order by id) as rn
from weather
where temperature < 0;

-- Logic to group the data
select *, row_number() over(order by id) as rn,
(id - row_number() over(order by id)) as difference
from weather
where temperature < 0;

-- Final query using with clause
with t1 as
		(select *, row_number() over(order by id) as rn,
		id - (row_number() over(order by id)) as difference
		from weather
		where temperature < 0),
	 t2 as
		(select *, count(*) over(partition by difference) as no_of_records
		from t1)
select id, city, temperature, day
from t2
where no_of_records = 3;

-- Data set
create view vw_weather as select city, temperature from weather;

select * from vw_weather;

-- Type 2: SQL Query to fetch "N" consecutive records when temperature is below 0 and also
-- table doesn't have id column.

with w as
		(select *, row_number() over() as id 
		from vw_weather),
	t1 as
		(select *, row_number() over(order by id) as rn,
		id - (row_number() over(order by id)) as difference
		from w
		where temperature < 0),
	t2 as
		(select *, count(*) over(partition by difference) as no_of_records
		from t1)
select id, city, temperature
from t2
where no_of_records = 3;

-- Data set
create table orders 
(
	order_id varchar primary key,
	order_date date
);

insert into orders values ('ORD1001', to_date('2023-01-01', 'yyyy-mm-dd'));
insert into orders values ('ORD1002', to_date('2023-02-01', 'yyyy-mm-dd'));
insert into orders values ('ORD1003', to_date('2023-02-02', 'yyyy-mm-dd'));
insert into orders values ('ORD1004', to_date('2023-02-03', 'yyyy-mm-dd'));
insert into orders values ('ORD1005', to_date('2023-03-01', 'yyyy-mm-dd'));
insert into orders values ('ORD1006', to_date('2023-06-01', 'yyyy-mm-dd'));
insert into orders values ('ORD1007', to_date('2023-12-25', 'yyyy-mm-dd'));
insert into orders values ('ORD1008', to_date('2023-12-26', 'yyyy-mm-dd'));

select * from orders;

-- Type 3: Fetch the records from table where there are orders for 3 consecutive days

select *, row_number() over(order by order_id) as rn 
from orders;

with t1 as 
		(select *, row_number() over(order by order_id) as rn , 
		order_date - cast (row_number() over(order by order_id)as int) as difference
		from orders),
	 t2 as
	 	(select *, count(*) over(partition by difference) as no_of_records
		 from t1)
select order_id, order_date
from t2
where no_of_records = 3;

-- Problem Statement 8

-- Data set
drop table if exists batch;
drop table if exists orders;

create table batch (batch_id varchar(10), quantity integer);
create table bat_orders (order_number varchar(10), quantity integer);


insert into batch values ('B1', 5);
insert into batch values ('B2', 12);
insert into batch values ('B3', 8);

insert into bat_orders values ('O1', 2);
insert into bat_orders values ('O2', 8);
insert into bat_orders values ('O3', 2);
insert into bat_orders values ('O4', 5);
insert into bat_orders values ('O5', 9);
insert into bat_orders values ('O6', 5);

select * from batch;
select * from bat_orders;

-- Imagine a Warehouse where items are stored in different batches as indicated in the Batch table. 
-- Customers can purchase multiple items in a single order as indicated in Orders table. Write an 
-- SQL query to determine items for each order are taken from which Batch. Assume that items are 
-- sequentially taken from each Batch starting from the first batch.

-- The first thing to get the result for the above query, the Batch and Orders table has expanded.

-- Expanding the table values
with recursive batch_split as 
	(select batch_id, 1 as quantity from batch
	union all
	select b.batch_id, (cte.quantity+1) as quantity
	from batch_split cte
	join batch b
	on b.batch_id = cte.batch_id
	and b.quantity > cte.quantity)
select batch_id, 1 as quantity 
from batch_split;

with recursive orders_split as 
	(select order_number, 1 as quantity from bat_orders
	union all
	select b.order_number, (cte.quantity+1) as quantity
	from orders_split cte
	join bat_orders b
	on b.order_number = cte.order_number
	and b.quantity > cte.quantity)
select order_number, 1 as quantity 
from orders_split

-- Adding the row numbers
select *, row_number() over(order by batch_id) as rn
from 
(with recursive batch_split as 
	(select batch_id, 1 as quantity from batch
	union all
	select b.batch_id, (cte.quantity+1) as quantity
	from batch_split cte
	join batch b
	on b.batch_id = cte.batch_id
	and b.quantity > cte.quantity)
select batch_id, 1 as quantity 
from batch_split) x;

select *, row_number() over(order by order_number) as rn
from 
(with recursive orders_split as 
	(select order_number, 1 as quantity from bat_orders
	union all
	select b.order_number, (cte.quantity+1) as quantity
	from orders_split cte
	join bat_orders b
	on b.order_number = cte.order_number
	and b.quantity > cte.quantity)
select order_number, 1 as quantity 
from orders_split) x;

-- Final Query to join the tables
with batch_cte as 
		(select *, row_number() over(order by batch_id) as rn
		from 
		(with recursive batch_split as 
			(select batch_id, 1 as quantity from batch
			union all
			select b.batch_id, (cte.quantity+1) as quantity
			from batch_split cte
			join batch b
			on b.batch_id = cte.batch_id
			and b.quantity > cte.quantity)
		select batch_id, 1 as quantity 
		from batch_split) x),
	order_cte as
		(select *, row_number() over(order by order_number) as rn
		from 
		(with recursive orders_split as 
			(select order_number, 1 as quantity from bat_orders
			union all
			select b.order_number, (cte.quantity+1) as quantity
			from orders_split cte
			join bat_orders b
			on b.order_number = cte.order_number
			and b.quantity > cte.quantity)
		select order_number, 1 as quantity 
		from orders_split) x)
select o.order_number, b.batch_id, sum(b.quantity) as quantity
from order_cte o
left join batch_cte b on b.rn = o.rn
group by o.order_number, b.batch_id
order by o.order_number, b.batch_id;

-- Problem Statement 9

-- Write a SQL query to find the family members

-- Data set
drop table family_members;

create table family_members
(
	person_id		varchar(20),
	relative_id1	varchar(20),
	relative_id2	varchar(20)
);

insert into family_members values('ATR-1', null, null);
insert into family_members values('ATR-2', 'ATR-1', null);
insert into family_members values('ATR-3', 'ATR-2', null);
insert into family_members values('ATR-4', 'ATR-3', null);
insert into family_members values('ATR-5', 'ATR-4', null);

insert into family_members values('BTR-1', null, null);
insert into family_members values('BTR-2', null, 'BTR-1');
insert into family_members values('BTR-3', null, 'BTR-2');
insert into family_members values('BTR-4', null, 'BTR-3');
insert into family_members values('BTR-5', null, 'BTR-4');

insert into family_members values('CTR-1', null, 'CTR-3');
insert into family_members values('CTR-2', 'CTR-1', null);
insert into family_members values('CTR-3', null, null);

insert into family_members values('DTR-1', 'DTR-3', 'ETR-2');
insert into family_members values('DTR-2', null, null);
insert into family_members values('DTR-3', null, null);

insert into family_members values('ETR-1', null, 'DTR-2');
insert into family_members values('ETR-2', null, null);

insert into family_members values('FTR-1', null, null);
insert into family_members values('FTR-2', null, null);
insert into family_members values('FTR-3', null, null);

insert into family_members values('GTR-1', 'GTR-1', null);
insert into family_members values('GTR-2', 'GTR-1', null);
insert into family_members values('GTR-3', 'GTR-1', null);

insert into family_members values('HTR-1', 'GTR-1', null);
insert into family_members values('HTR-2', 'GTR-1', null);
insert into family_members values('HTR-3', 'GTR-1', null);

insert into family_members values('ITR-1', null, null);
insert into family_members values('ITR-2', 'ITR-3', 'ITR-1');
insert into family_members values('ITR-3', null, null);

select * from family_members;

-- Stepwise Breakdown

-- Grouping all the relatives together
select relative_id1 as relatives from family_members
where relative_id1 is not null
union
select relative_id2 as relatives from family_members
where relative_id2 is not null
order by 1;

-- Adding relatives into the family
select relative_id1 as relatives, substring(person_id, 1, 3) as fam_grp from family_members
where relative_id1 is not null
union
select relative_id2 as relatives, substring(person_id, 1, 3) as fam_grp from family_members
where relative_id2 is not null
order by 1;

-- Final Query
with recursive related_fam_members as 
		(select * from base_query
		 union
		 select fam.person_id, r.fam_grp
		 from related_fam_members r
		 join family_members fam
		 on fam.relative_id1 = r.relatives
		 or fam.relative_id2 = r.relatives),
base_query as 	
(select relative_id1 as relatives, substring(person_id, 1, 3) as fam_grp from family_members
where relative_id1 is not null
union
select relative_id2 as relatives, substring(person_id, 1, 3) as fam_grp from family_members
where relative_id2 is not null
order by 1),
no_relatives as
(select person_id from
family_members fam
where relative_id1 is null and relative_id2 is null
and person_id not in (select relatives from base_query))
select concat('F_', row_number() over(order by relatives)) as family_id,
relatives from
	(select distinct String_agg(relatives, ', ' order by relatives) as relatives
	from related_fam_members
	group by fam_grp
	union
	select * from no_relatives) x;

-- Problem Statement 10

-- Julia conducted a 15 days of learning SQL contest. The start date of the contest was March 01, 2016
-- and the end date was March 15, 2016. Write a query to print total number of unique hackers who made
-- at least 1 submission each day (starting on the first day of the contest), and find the hacker_id 
-- and name of the hacker who made maximum number of submissions each day. If more than one such hacker
-- has a maximum number of submissions, print the lowest hacker_id. The query should print this 
-- information for each day of the contest, sorted by the date.

-- Data set

drop table hackers;
drop table submissions;

create table hackers (hacker_id int, name varchar(40));
create table submissions (submission_date date, submission_id int, hacker_id int, score int);


insert into hackers values (15758, 'Rose');
insert into hackers values (20703, 'Angela');
insert into hackers values (36396, 'Frank');
insert into hackers values (38289, 'Patrick');
insert into hackers values (44065, 'Lisa');
insert into hackers values (53473, 'Kimberly');
insert into hackers values (62529, 'Bonnie');
insert into hackers values (79722, 'Michael');

insert into submissions values (to_date('2016-03-01', 'yyyy-MM-dd'),  8494,   20703,	 0	);
insert into submissions values (to_date('2016-03-01', 'yyyy-MM-dd'), 22403, 	53473,	 15	);
insert into submissions values (to_date('2016-03-01', 'yyyy-MM-dd'), 23965, 	79722,	 60	);
insert into submissions values (to_date('2016-03-01', 'yyyy-MM-dd'), 30173, 	36396,	 70	);
insert into submissions values (to_date('2016-03-02', 'yyyy-MM-dd'), 34928, 	20703,	 0	);
insert into submissions values (to_date('2016-03-02', 'yyyy-MM-dd'), 38740, 	15758,	 60	);
insert into submissions values (to_date('2016-03-02', 'yyyy-MM-dd'), 42769, 	79722,	 25	);
insert into submissions values (to_date('2016-03-02', 'yyyy-MM-dd'), 44364, 	79722,	 60	);
insert into submissions values (to_date('2016-03-03', 'yyyy-MM-dd'), 45440, 	20703,	 0	);
insert into submissions values (to_date('2016-03-03', 'yyyy-MM-dd'), 49050, 	36396,	 70	);
insert into submissions values (to_date('2016-03-03', 'yyyy-MM-dd'), 50273, 	79722,	 5	);
insert into submissions values (to_date('2016-03-04', 'yyyy-MM-dd'), 50344, 	20703,	 0	);
insert into submissions values (to_date('2016-03-04', 'yyyy-MM-dd'), 51360, 	44065,	 90	);
insert into submissions values (to_date('2016-03-04', 'yyyy-MM-dd'), 54404, 	53473,	 65	);
insert into submissions values (to_date('2016-03-04', 'yyyy-MM-dd'), 61533, 	79722,	 45	);
insert into submissions values (to_date('2016-03-05', 'yyyy-MM-dd'), 72852, 	20703,	 0	);
insert into submissions values (to_date('2016-03-05', 'yyyy-MM-dd'), 74546, 	38289,	 0	);
insert into submissions values (to_date('2016-03-05', 'yyyy-MM-dd'), 76487, 	62529,	 0	);
insert into submissions values (to_date('2016-03-05', 'yyyy-MM-dd'), 82439, 	36396,	 10	);
insert into submissions values (to_date('2016-03-05', 'yyyy-MM-dd'), 90006, 	36396,	 40	);
insert into submissions values (to_date('2016-03-06', 'yyyy-MM-dd'), 90404, 	20703,	 0	);

select * from hackers;
select * from submissions;

-- base query
select distinct submission_date, hacker_id
from submissions
where submission_date = (select min(submission_date) from submissions);

-- recursive query

--  print total number of unique hackers who made at least 1 submission each day 
-- (starting on the first day of the contest),
with recursive cte as
	(select distinct submission_date, hacker_id
	from submissions
	where submission_date = (select min(submission_date) from submissions)
	union
	select s.submission_date, s.hacker_id 
	from submissions s
	join cte on cte.hacker_id = s.hacker_id
	where s.submission_date = (select min(submission_date) from submissions
								where submission_date > cte.submission_date)),
	unique_hackers as							
		(select submission_date, count(1) as no_of_hackers 
		from cte
		group by submission_date);

-- find the hacker_id and name of the hacker who made maximum number of submissions each day
-- If more than one such hacker has a maximum number of submissions, print the lowest hacker_id.
with submission_count as
	(select submission_date, hacker_id, count(1) as no_of_submission
	from submissions
	group by submission_date, hacker_id
	order by 1),
	max_submission as 
		(select submission_date, max(no_of_submission) as max_submission
		from submission_count
		group by submission_date)
select c.submission_date, min(c.hacker_id) as hacker_id
from max_submission m
join submission_count c
on c.submission_date = m.submission_date
and c.no_of_submission = m.max_submission
group by c.submission_date;

-- final query
with recursive cte as
	(select distinct submission_date, hacker_id
	from submissions
	where submission_date = (select min(submission_date) from submissions)
	union
	select s.submission_date, s.hacker_id 
	from submissions s
	join cte on cte.hacker_id = s.hacker_id
	where s.submission_date = (select min(submission_date) from submissions
								where submission_date > cte.submission_date)),
	unique_hackers as							
		(select submission_date, count(1) as no_of_hackers 
		from cte
		group by submission_date),
	submission_count as
		(select submission_date, hacker_id, count(1) as no_of_submission
		from submissions
		group by submission_date, hacker_id
		order by 1),
	max_submission as 
		(select submission_date, max(no_of_submission) as max_submission
		from submission_count
		group by submission_date),
	final_hackers as
		(select c.submission_date, min(c.hacker_id) as hacker_id
		from max_submission m
		join submission_count c
		on c.submission_date = m.submission_date
		and c.no_of_submission = m.max_submission
		group by c.submission_date)
select uh.submission_date, uh.no_of_hackers, fh.hacker_id, hk.name as hacker_name
from unique_hackers uh
join final_hackers fh
on fh.submission_date = uh.submission_date
join hackers hk on hk.hacker_id = fh.hacker_id
order by 1;

-- Problem Statement 11 [FAANG]

-- We want to generate an inventory age report which would show the distribution of remaining inventory
-- across the length of time the inventory has been sitting at the warehouse. We are trying to classify
-- the inventory on hand across the below 4 buckets to denote the time the inventory has been lying the 
-- warehouse.

-- 0-90 days old 
-- 91-180 days old
-- 181-270 days old
-- 271 – 365 days old

-- For example, the warehouse received 100 units yesterday and shipped 30 units today, then there are 70 
-- units which are a day old.

-- The warehouses use FIFO (first in first out) approach to manage inventory, i.e., the inventory that comes
-- first will be sent out first. 
 
-- For example, on 20th May 2019, 250 units were inbounded into the FC. On 22nd May 2019, 8 units were shipped 
-- out (outbound) from the FC, reducing inventory on hand to 242 units. On 31st December, 120 units were further
-- inbounded into the FC increasing the inventory on hand from 242 to 362.On 29th January 2020, 27 units were 
-- shipped out reducing the inventory on hand to 335 units.

-- On 29th January, of the 335 units on hands, 120 units were 0-90 days old (29 days old) and 215 units were 
-- 181-270 days old (254 days old).

-- Columns:
-- ID of the log entry
-- OnHandQuantity: Quantity in warehouse after an event
-- OnHandQuantityDelta: Change in on-hand quantity due to an event
-- event_type: Inbound – inventory being brought into the warehouse; Outbound – inventory being sent out of 
-- warehouse
-- event_datetime: date- time of event
-- The data is sorted with latest entry at top.

-- Data set
drop table warehouse;

create table warehouse
(
	Id						varchar(10),
	OnHandQuantity			int,
	OnHandQuantityDelta		int,
	event_type				varchar(10),
	event_datetime			timestamp
);

insert into warehouse values
('SH0013', 278,   99 ,   'OutBound', '2020-05-25 0:25'), 
('SH0012', 377,   31 ,   'InBound',  '2020-05-24 22:00'),
('SH0011', 346,   1  ,   'OutBound', '2020-05-24 15:01'),
('SH0010', 346,   1  ,   'OutBound', '2020-05-23 5:00'),
('SH009',  348,   102,   'InBound',  '2020-04-25 18:00'),
('SH008',  246,   43 ,   'InBound',  '2020-04-25 2:00'),
('SH007',  203,   2  ,   'OutBound', '2020-02-25 9:00'),
('SH006',  205,   129,   'OutBound', '2020-02-18 7:00'),
('SH005',  334,   1  ,   'OutBound', '2020-02-18 8:00'),
('SH004',  335,   27 ,   'OutBound', '2020-01-29 5:00'),
('SH003',  362,   120,   'InBound',  '2019-12-31 2:00'),
('SH002',  242,   8  ,   'OutBound', '2019-05-22 0:50'),
('SH001',  250,   250,   'InBound',  '2019-05-20 0:45');

select * from warehouse order by event_datetime desc;

-- Get the Day 1 data
with WH as 
		(select * from warehouse order by event_datetime desc),
	 days as
	 	(select *
		 from WH limit 1)
select * from days;

-- Get the 90 Days / 180 Days / 270 Days / 365 Days date
with WH as 
		(select * from warehouse order by event_datetime desc),
	 days as
	 	(select onhandquantity, event_datetime,
		 (event_datetime - interval '90 DAY') as day90,
		 (event_datetime - interval '180 DAY') as day180,
		 (event_datetime - interval '270 DAY') as day270,
		 (event_datetime - interval '365 DAY') as day365
		 from WH limit 1)
select * from days;

-- Final Query
with WH as 
		(select * from warehouse order by event_datetime desc),
	 days as
	 	(select onhandquantity, event_datetime,
		 (event_datetime - interval '90 DAY') as day90,
		 (event_datetime - interval '180 DAY') as day180,
		 (event_datetime - interval '270 DAY') as day270,
		 (event_datetime - interval '365 DAY') as day365
		 from WH limit 1),
	 inv_90_days as 
	 	(select coalesce(sum(onhandquantitydelta), 0) as DaysOld_90
		 from WH cross join days d
		 where event_type = 'InBound'
		 and WH.event_datetime >= d.day90),
	 inv_90_days_final as
	 	(select case when DaysOld_90 > d.onhandquantity then d.onhandquantity
		 			 else DaysOld_90
				end DaysOld_90
		 from inv_90_days
		 cross join days d),
	 inv_180_days as 
	 	(select coalesce(sum(onhandquantitydelta), 0) as DaysOld_180
		 from WH cross join days d
		 where event_type = 'InBound'
		 and WH.event_datetime between d.day180 and d.day90),
	 inv_180_days_final as
	 	(select case when DaysOld_180 > (d.onhandquantity - DaysOld_90) then (d.onhandquantity - DaysOld_90)
		 			 else DaysOld_180
				end DaysOld_180
		 from inv_180_days
		 cross join days d
		 cross join inv_90_days_final),
	 inv_270_days as 
	 	(select coalesce(sum(onhandquantitydelta), 0) as DaysOld_270
		 from WH cross join days d
		 where event_type = 'InBound'
		 and WH.event_datetime between d.day270 and d.day180),
	 inv_270_days_final as
	 	(select case when DaysOld_270 > (d.onhandquantity - (DaysOld_90 + DaysOld_180)) then (d.onhandquantity - (DaysOld_90 + DaysOld_180))
		 			 else DaysOld_270
				end DaysOld_270
		 from inv_270_days
		 cross join days d
		 cross join inv_90_days_final
		 cross join inv_180_days_final),
	 inv_365_days as 
	 	(select coalesce(sum(onhandquantitydelta), 0) as DaysOld_365
		 from WH cross join days d
		 where event_type = 'InBound'
		 and WH.event_datetime between d.day365 and d.day270),
	 inv_365_days_final as
	 	(select case when DaysOld_365 > (d.onhandquantity - (DaysOld_90 + DaysOld_180 + DaysOld_270)) then (d.onhandquantity - (DaysOld_90 + DaysOld_180 + DaysOld_270))
		 			 else DaysOld_365
				end DaysOld_365
		 from inv_365_days
		 cross join days d
		 cross join inv_90_days_final
		 cross join inv_180_days_final
		 cross join inv_270_days_final)
select DaysOld_90 as "0-90 days old" ,
DaysOld_180 as "91-180 days old",
DaysOld_270 as "181-270 days old",
DaysOld_365 as "270-365 days old"
from inv_90_days_final
cross join inv_180_days_final
cross join inv_270_days_final
cross join inv_365_days_final;
