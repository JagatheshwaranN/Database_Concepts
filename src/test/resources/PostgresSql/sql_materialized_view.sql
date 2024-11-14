-- Materialized View
-- It is an database object.
-- It is created over an query.
-- Whenever we create MView, it will do 2 things.
-- 1. Store the SQL query used to create it.
-- 2. Store the data returned by the SQL query.

-- Whenever we execute/call MView, it will not execute the query instead it 
-- will return the data it stores, this way it improves the performance.

-- Scenario for MView
create table random_tab (id int, val decimal);

insert into random_tab
select 1, random() from generate_series(1, 10000000);
insert into random_tab
select 2, random() from generate_series(1, 10000000);

select id, avg(val), count(*)
from random_tab
group by id;

create materialized view mv_random_tab
as
select id, avg(val), count(*)
from random_tab
group by id;

select * from mv_random_tab;

-- Note
-- The materialized view data won't be updated automatically. It has to be 
-- updated manually. So, whenever any update is done on the base table, to
-- have that change on the MView, we need to refresh it.

-- Let's consider below scenario
-- Deleting one of the record from the random_tab.
delete from random_tab where id = 1;

-- After deletion, base table has only one record.
-- MView still has 2 records.

-- To update MView, have to refresh it.
refresh materialized view mv_random_tab;

-- MView vs View
-- When we create a view internally it stores the query. So, whenever
-- we execute it, it will run the query and fetch the data.

-- As we know, when we create a MView internally it stores the query and 
-- the data. So, whenever we execute it, it will fetch the stored data.


