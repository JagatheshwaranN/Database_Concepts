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
