-- With Clause [CTE / SQF]
-- Common Table Expression / Sub Query Factoring

-- Whenever we are using the with clause, it should be before the select statement.
-- syntax: with alias_name (list_of_columns) as (query)
-- 		   selec * from table where clause.

-- The query inside the with clause is executed first and then the data is stored
-- in temp memory / table and that can be referenced by alias.
-- The temp table is not actually temp table, its kindof and its scope is until
-- execution of query.

-- 1) Fetch employees who earn more than average salary of all employees.
with average_salary (avg_sal) as
					(select cast (avg(salary) as int) from employee)
select *
from employee e, average_salary av
where e.salary > av.avg_sal;

-- 2) Find stores who's sales where better than the average sales across all stores.

''' --- Without With Clause ---
-- i) Total sales per each store -- Total_Sales
select s.store_id, sum(s.price * s.quantity) as total_sales
from sales s
group by s.store_id;

-- ii) Find the average sales with respect to all the stores. -- Avg_Sales
select cast( avg(total_sales_per_store) as int) as avg_Sales_for_all_stores
from (select s.store_id, sum(s.price * s.quantity) as total_sales_per_store
from sales s
group by s.store_id) x;

-- iii) Find the stores where Total_Sales > Avg_Sales of all stores.
select * 
from (select s.store_id, sum(s.price * s.quantity) as total_sales_per_store
from sales s
group by s.store_id) as total_sales
join ( select cast( avg(total_sales_per_store) as int) as avg_Sales_for_all_stores
from (select s.store_id, sum(s.price * s.quantity) as total_sales_per_store
from sales s
group by s.store_id) x) as avg_sales
on total_sales.total_sales_per_store >avg_sales.avg_Sales_for_all_stores;
'''
with Total_Sales (store_id, total_sales_per_store) 
as (select s.store_id, sum(s.price * s.quantity) as total_sales_per_store
from sales s
group by s.store_id),
	Avg_Sales (avg_sales_for_all_stores) 
as (select cast( avg(total_sales_per_store) as int) as avg_sales_for_all_stores
from Total_Sales)
select *
from Total_Sales ts
join Avg_Sales avs
on ts.total_sales_per_store > avs.avg_sales_for_all_stores;





