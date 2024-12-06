drop table if exists ex_cars;
create table if not exists ex_cars
(
    id      int,
    model   varchar(50),
    brand   varchar(40),
    color   varchar(30),
    make    int
);
insert into ex_cars values (1, 'Model S', 'Tesla', 'Blue', 2018);
insert into ex_cars values (2, 'EQS', 'Mercedes-Benz', 'Black', 2022);
insert into ex_cars values (3, 'iX', 'BMW', 'Red', 2022);
insert into ex_cars values (4, 'Ioniq 5', 'Hyundai', 'White', 2021);
insert into ex_cars values (5, 'Model S', 'Tesla', 'Silver', 2018);
insert into ex_cars values (6, 'Ioniq 5', 'Hyundai', 'Green', 2021);

-- Scenario 1: Data duplicated based on SOME of the columns.

-- Write a query to Delete duplicate data from Cars table.
-- Duplicate record is identified based on the model and brand name.

select * from ex_cars;

-- Solution 1: Delete using Unique Identifier.
select model, brand, count(*)
from ex_cars
group by model, brand
having count(*) > 1;

select model, brand, max(id)
from ex_cars
group by model, brand
having count(*) > 1;

delete from ex_cars 
where id in
(select max(id)
from ex_cars
group by model, brand
having count(*) > 1);

-- Solution 2: Using Self join.
select *
from ex_cars c1 
join ex_cars c2
on c1.model = c2.model and c1.brand = c2.brand
where c1.id < c2.id;

select c2.*
from ex_cars c1 
join ex_cars c2
on c1.model = c2.model and c1.brand = c2.brand
where c1.id < c2.id;

delete from ex_cars
where id in 
(select c2.id
from ex_cars c1 
join ex_cars c2
on c1.model = c2.model and c1.brand = c2.brand
where c1.id < c2.id);

-- Solution 3: Using Window function.
select *, 
row_number() over(partition by model, brand) as rn
from ex_cars;

select id
from 
(select *, 
row_number() over(partition by model, brand) as rn
from ex_cars ) x
where x.rn > 1;

delete from ex_cars
where id in 
(select id
from 
(select *, 
row_number() over(partition by model, brand) as rn
from ex_cars ) x
where x.rn > 1);

-- Solution 4: Using Min function. This delete even multiple duplicate records.
select min(id) 
from ex_cars
group by model, brand;

delete from ex_cars
where id not in
(select min(id) 
from ex_cars
group by model, brand);

-- Solution 5: Using backup table.

-- The below statement create the backup table as per the ex_cars table without the data.
create table ex_cars_bkp 
as select * 
from ex_cars 
where 1=2;

select * from ex_cars_bkp;

insert into ex_cars_bkp
select *
from ex_cars
where id in (
select min(id)
from ex_cars
group by model, brand);

drop table ex_cars;

alter table ex_cars_bkp rename to ex_cars;

select * from ex_cars;

-- Solution 6: Using backup table without dropping the original table.

-- The below statement create the backup table as per the ex_cars table without the data.
create table ex_cars_bkp 
as select * 
from ex_cars 
where 1=2;

select * from ex_cars_bkp;

insert into ex_cars_bkp
select *
from ex_cars
where id in (
select min(id)
from ex_cars
group by model, brand);

truncate table ex_cars;

insert into ex_cars
select * from ex_cars_bkp;

drop table ex_cars_bkp;

select * from ex_cars;

-- ##### Delete the records even if the Id is duplicate. ##### --

truncate table ex_cars;

insert into ex_cars values (1, 'Model S', 'Tesla', 'Blue', 2018);
insert into ex_cars values (2, 'EQS', 'Mercedes-Benz', 'Black', 2022);
insert into ex_cars values (3, 'iX', 'BMW', 'Red', 2022);
insert into ex_cars values (4, 'Ioniq 5', 'Hyundai', 'White', 2021);
insert into ex_cars values (1, 'Model S', 'Tesla', 'Blue', 2018);
insert into ex_cars values (4, 'Ioniq 5', 'Hyundai', 'White', 2021);

select * from ex_cars;

-- Solution 1: Delete using CTID [CTID available in Postgres SQL / ROWID available in Oracle]

-- The above solution will not work in MySQL and Microsoft SQL Server.

select *, ctid 
from ex_cars;

delete from ex_cars 
where ctid in (
select max(ctid) 
from ex_cars
group by model, brand
having count(*) > 1);

select * from ex_cars order by model, brand;

-- Solution 2: By creating a temporary unique id column
alter table ex_cars add column row_num int generated always as identity;

select * from ex_cars order by model, brand;

select max (row_num)
from ex_cars
group by model, brand
having count(*) > 1;

delete from ex_cars
where row_num in
(select max (row_num)
from ex_cars
group by model, brand
having count(*) > 1);

select * from ex_cars order by model, brand;

alter table ex_cars drop column row_num;

-- Solution 3: By creating a backup table

create table ex_cars_bkp as
select distinct * from ex_cars;

select * from ex_cars_bkp;

drop table ex_cars;

alter table ex_cars_bkp rename to ex_cars;

select * from ex_cars;

-- Solution 4: By creating a backup table without dropping the original table

create table ex_cars_bkp as
select distinct * from ex_cars;

select * from ex_cars_bkp;

truncate table ex_cars;

insert into ex_cars
select * from ex_cars_bkp;

drop table ex_cars_bkp;

select * from ex_cars;