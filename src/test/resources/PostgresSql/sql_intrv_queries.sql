--- Q1: Delete Duplicate Records --- 
drop table if exists cars;
create table cars
(
	model_id		int primary key,
	model_name		varchar(100),
	color			varchar(100),
	brand			varchar(100)
);

insert into cars values(1,'Leaf', 'Black', 'Nissan');
insert into cars values(2,'Leaf', 'Black', 'Nissan');
insert into cars values(3,'Model S', 'Black', 'Tesla');
insert into cars values(4,'Model X', 'White', 'Tesla');
insert into cars values(5,'Ioniq 5', 'Black', 'Hyundai');
insert into cars values(6,'Ioniq 5', 'Black', 'Hyundai');
insert into cars values(7,'Ioniq 6', 'White', 'Hyundai');

select * from cars;

-- select min(model_id) from cars group by model_name, brand;
-- Solution 1
delete from cars
where model_id not in (select min(model_id)
from cars
group by model_name, brand);

-- Solution 2
-- Note:
-- ctid - Kind of unique identifier which is present in PostgresSQL by default.

-- select max(ctid) from cars group by model_name, brand having count(1) > 1;
delete from cars
where ctid in (select max(ctid) 
from cars
group by model_name, brand
having count(1) > 1);

-- Solution 3
-- select model_id from (select * , row_number() over (partition by model_name, 
-- brand order by model_id) as rn from cars)x where x.rn > 1;
delete from cars
where model_id in (select model_id 
from (select * , row_number() over (partition by model_name, brand order by model_id)
as rn from cars) x 
where x.rn > 1);

--- Q2: Display highest and lowest salary --- 
select * from employee;

-- Solution
select *,
max (salary) over (partition by dept_name order by salary desc) as higest_salary,
min (salary) over (partition by dept_name order by salary desc
range between unbounded preceding and unbounded following) as lowest_salary
from employee;

--- Q3 : Find Actual Distance --- 
drop table car_travels;
create table car_travels
(
    cars                    varchar(40),
    days                    varchar(10),
    cumulative_distance     int
);

insert into car_travels values ('Car1', 'Day1', 50);
insert into car_travels values ('Car1', 'Day2', 100);
insert into car_travels values ('Car1', 'Day3', 200);
insert into car_travels values ('Car2', 'Day1', 0);
insert into car_travels values ('Car3', 'Day1', 0);
insert into car_travels values ('Car3', 'Day2', 50);
insert into car_travels values ('Car3', 'Day3', 50);
insert into car_travels values ('Car3', 'Day4', 100);

select * from car_travels;

-- Solution
select *, 
cumulative_distance - lag(cumulative_distance, 1, 0)
over (partition by cars order by days) as distance_travelled
from car_travels;

--- Q4 : Convert the Given Input to Expected Output --- 
drop table src_dest_distance;

create table src_dest_distance
(
    source          varchar(20),
    destination     varchar(20),
    distance        int
);

insert into src_dest_distance values ('Bangalore', 'Hyderbad', 400);
insert into src_dest_distance values ('Hyderbad', 'Bangalore', 400);
insert into src_dest_distance values ('Mumbai', 'Delhi', 400);
insert into src_dest_distance values ('Delhi', 'Mumbai', 400);
insert into src_dest_distance values ('Chennai', 'Pune', 400);
insert into src_dest_distance values ('Pune', 'Chennai', 400);

select * from src_dest_distance;

-- Solution
with cte as 
	(select *,
	 row_number() over() as rn 
	 from src_dest_distance)
select t1.source, t1.destination, t1.distance 
from cte t1
join cte t2
on t1.rn < t2.rn
and t1.source = t2.destination
and t1.destination = t2.source;

--- Q5 : Ungroup the Given Input Data --- 
drop table travel_items;

create table travel_items
(
	id              int,
	item_name       varchar(50),
	total_count     int
);

insert into travel_items values (1, 'Water Bottle', 2);
insert into travel_items values (2, 'Tent', 1);
insert into travel_items values (3, 'Apple', 4);

select * from travel_items;

-- Solution
with recursive cte as
	(select id, item_name, total_count, 1 as level -- Base Query
	from travel_items
	union all
	select cte.id, cte.item_name, cte.total_count - 1, level + 1 as level -- Recursive Query
	from cte
	join travel_items t
	on t.item_name = cte.item_name
	and t.id = cte.id
	where cte.total_count > 1)
select id, item_name, level 
from cte
order by 3;

--- Q6 : IPL Matches --- 
drop table teams;

create table teams
    (
        team_code       varchar(10),
        team_name       varchar(40)
    );

insert into teams values ('RCB', 'Royal Challengers Bangalore');
insert into teams values ('MI', 'Mumbai Indians');
insert into teams values ('CSK', 'Chennai Super Kings');
insert into teams values ('DC', 'Delhi Capitals');
insert into teams values ('RR', 'Rajasthan Royals');
insert into teams values ('SRH', 'Sunrisers Hyderbad');
insert into teams values ('PBKS', 'Punjab Kings');
insert into teams values ('KKR', 'Kolkata Knight Riders');
insert into teams values ('GT', 'Gujarat Titans');
insert into teams values ('LSG', 'Lucknow Super Giants');

select * from teams;

-- Solution for Q1: Each team plays with every other team Just Once.

with matches as
	(select row_number() over(order by team_name) as id, t.*
	from teams t)
select team.team_name as team, opponent.team_name as opponent
from matches team
join matches opponent on team.id < opponent.id
order by team;

-- Solution for Q2: Each team plays with every other team twice.
with matches as
	(select row_number() over(order by team_name) as id, t.*
	from teams t)
select team.team_name as team, opponent.team_name as opponent
from matches team
join matches opponent on team.id <> opponent.id
order by team;

--- Q8: Find the hierarchy --- 

drop table emp_details;

create table emp_details
    (
        id           int PRIMARY KEY,
        name         varchar(100),
        manager_id   int,
        salary       int,
        designation  varchar(100)
    );
	
insert into emp_details values (1,  'Shripadh', NULL, 10000, 'CEO');
insert into emp_details values (2,  'Satya', 5, 1400, 'Software Engineer');
insert into emp_details values (3,  'Jia', 5, 500, 'Data Analyst');
insert into emp_details values (4,  'David', 5, 1800, 'Data Scientist');
insert into emp_details values (5,  'Michael', 7, 3000, 'Manager');
insert into emp_details values (6,  'Arvind', 7, 2400, 'Architect');
insert into emp_details values (7,  'Asha', 1, 4200, 'CTO');
insert into emp_details values (8,  'Maryam', 1, 3500, 'Manager');
insert into emp_details values (9,  'Reshma', 8, 2000, 'Business Analyst');
insert into emp_details values (10, 'Akshay', 8, 2500, 'Java Developer');

select * from emp_details;

-- Solution
with recursive cte as
	(select * from emp_details
	where name = 'Asha'
	union
	select e.*
	from cte
	join emp_details e 
	on e.manager_id = cte.id)
select * from cte;

--- Q9: Find difference in average sales --- 

drop table sales_order_detail;

create table sales_order_detail
(
    order_number        bigserial primary key,
    quantity_ordered    int check (quantity_ordered > 0),
    price_each          float,
    sales               float,
    order_date          date,
    status              varchar(15),
    qtr_id              int check (qtr_id between 1 and 4),
    month_id            int check (month_id between 1 and 12),
    year_id             int,
    Product             varchar(20) ,
    customer            varchar(20) ,
    deal_size           varchar(10) check (deal_size in ('Small', 'Medium', 'Large'))
);

alter table sales_order_detail add constraint chk_ord_sts
check (status in ('Cancelled', 'Disputed', 'In Process', 'On Hold', 'Resolved', 'Shipped'));

select * from sales_order_detail;

-- Solution
with cte as 
	(select year_id, month_id, to_char(order_date, 'MON') as mon, avg(sales) as avg_sales_per_mon
	from sales_order_detail sod 
	where year_id in (2003, 2004)
	group by year_id, month_id, to_char(order_date, 'MON'))
select year2k3.mon, round(abs(year2k4.avg_sales_per_mon - year2k3.avg_sales_per_mon)::decimal, 2)
as sales_difference
from cte year2k3
join cte year2k4
on year2k3.mon = year2k4.mon
where year2k3.year_id = 2003
and year2k4.year_id = 2004
order by year2k3.month_id;

--- Q10: Pizza Delivery Status --- 

-- A pizza company is taking orders from customers, and each pizza ordered is added to their 
-- database as a separate order. Each order has an associated status, "CREATED or SUBMITTED 
-- or DELIVERED'. 	
-- An order's Final_ Status is calculated based on status as follows:	
-- 	1. When all orders for a customer have a status of DELIVERED, that customer's order has 
-- 	a Final_Status of COMPLETED.
-- 	2. If a customer has some orders that are not DELIVERED and some orders that are DELIVERED,
-- 	the Final_ Status is IN PROGRESS.
-- 	3. If all of a customer's orders are SUBMITTED, the Final_Status is AWAITING PROGRESS.
-- 	4. Otherwise, the Final Status is AWAITING SUBMISSION.

-- Write a query to report the customer_name and Final_Status of each customer's arder. Order the
-- results by customer	name.	

drop table cust_orders;

create table cust_orders
(
cust_name   varchar(50),
order_id    varchar(10),
status      varchar(50)
);

insert into cust_orders values ('John', 'J1', 'DELIVERED');
insert into cust_orders values ('John', 'J2', 'DELIVERED');
insert into cust_orders values ('David', 'D1', 'SUBMITTED');
insert into cust_orders values ('David', 'D2', 'DELIVERED');
insert into cust_orders values ('David', 'D3', 'CREATED');
insert into cust_orders values ('Smith', 'S1', 'SUBMITTED');
insert into cust_orders values ('Krish', 'K1', 'CREATED');

select * from cust_orders;

-- Solution
select distinct cust_name as customer, 'COMPLETED' as status
from cust_orders co
where co.status = 'DELIVERED'
and not exists (select 1 from cust_orders co2
				where co2.cust_name = co.cust_name
				and co2.status in ('SUBMITTED', 'CREATED'))
union
select distinct cust_name as customer, 'IN PROGRESS' as status
from cust_orders co
where co.status = 'DELIVERED'
and exists (select 1 from cust_orders co2
				where co2.cust_name = co.cust_name
				and co2.status in ('SUBMITTED', 'CREATED'))
union
select distinct cust_name as customer, 'AWAITING PROGRESS' as status
from cust_orders co
where co.status = 'SUBMITTED'
and not exists (select 1 from cust_orders co2
				where co2.cust_name = co.cust_name
				and co2.status in ('DELIVERED'))
union
select distinct cust_name as customer, 'AWAITING SUBMISSION' as status
from cust_orders co
where co.status = 'CREATED'
and not exists (select 1 from cust_orders co2
				where co2.cust_name = co.cust_name
				and co2.status in ('SUBMITTED', 'DELIVERED'));

