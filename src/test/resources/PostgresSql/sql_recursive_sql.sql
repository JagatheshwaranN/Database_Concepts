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
	
-- 2) Find the hierarchy of employees under a given manager.
-- 3) Find the hierarchy of managers for a given employee.


