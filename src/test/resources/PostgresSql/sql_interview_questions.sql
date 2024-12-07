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

-- Leet Code Problem

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