-- View [Database Object]
-- It is created over an Sql query. 
-- View represents the data which is returned by the Sql query.
-- View doesn't store any data and whenever its called it executes the uderlying query.
-- View is a like virtual table.

create table if not exists tb_customer_data (
    cust_id         varchar(10) primary key,
    cust_name       varchar(50) not null,
    phone           bigint,
    email           varchar(50),
    address         varchar(250)
);

create table if not exists tb_product_info (
    prod_id         varchar(10) primary key,
    prod_name       varchar(50) not null,
    brand           varchar(50) not null,
    price           int
);

create table if not exists tb_order_details (
    ord_id          bigint primary key,
    prod_id         varchar(10) references tb_product_info(prod_id),
    quantity        int,
    cust_id         varchar(10) references tb_customer_data(cust_id),
    disc_percent    int,
    date            date
);

insert into tb_customer_data values
('C1', 'Mohan Kumar', 9900807090, 'mohan@demo.com', 'Bangalore'),
('C2', 'James Xavier', 8800905544, 'james@demo.com', 'Mumbai'),
('C3', 'Priyanka Verma', 9900223333, 'priyanka@demo.com', 'Chennai'),
('C4', 'Eshal Maryam', 9900822111, 'eshal@demo.com', 'Delhi');

insert into tb_product_info values
('P1', 'Samsung S22', 'Samsung', 800),
('P2', 'Google Pixel 6 Pro', 'Google', 900),
('P3', 'Sony Bravia TV', 'Sony', 600),
('P4', 'Dell XPS 17', 'Dell', 2000),
('P5', 'iPhone 13', 'Apple', 800),
('P6', 'Macbook Pro 16', 'Apple', 5000);

insert into tb_order_details values
(1, 'P1', 2, 'C1', 10, '01-01-2020'),
(2, 'P2', 1, 'C2', 0, '01-01-2020'),
(3, 'P2', 3, 'C3', 20, '02-01-2020'),
(4, 'P3', 1, 'C1', 0, '02-01-2020'),
(5, 'P3', 1, 'C1', 0, '03-01-2020'),
(6, 'P3', 4, 'C1', 25, '04-01-2020'),
(7, 'P3', 1, 'C1', 0, '05-01-2020'),
(8, 'P5', 1, 'C2', 0, '02-01-2020'),
(9, 'P5', 1, 'C3', 0, '03-01-2020'),
(10, 'P6', 1, 'C2', 0, '05-01-2020'),
(11, 'P6', 1, 'C3', 0, '06-01-2020'),
(12, 'P6', 5, 'C1', 30, '07-01-2020');

select * from tb_customer_data;
select * from tb_product_info;
select * from tb_order_details;

-- 1) Fetch the order summary (to be given to client / vendor)
create view order_summary as
select od.ord_id, od.date, pi.prod_name, cd.cust_name,
(pi.price * od.quantity) - ((pi.price * od.quantity) * disc_percent::float/100) as cost
from tb_customer_data cd
join tb_order_details od on od.cust_id = cd.cust_id
join tb_product_info pi on pi.prod_id = od.prod_id;

select * from order_summary;

-- What is the main purpose of using a view / advantages of view.
-- 1) Security
-- 2) To simplify the complex sql queries.

-- Create User
create role john
login
password 'john';

-- Provide Access to Order Summary View
grant select on order_summary to john;

-- 1) Security
-- In this scenario, we have created a new user 'John' and gave him the read access
-- to the order summary view. By hiding the query used to generate the view.

-- 2) To simplify the complex sql queries.
-- i. Sharing a view is better than sharing a complex query.
-- ii. Avoid rewriting the same complex query multiple times.

-- Create or Replace View
-- Whenever we are using the Create or Replace View command, We have to follow below rules.
-- Cannot change the column name.
-- Cannot change the column data type.
-- Cannot change the order of columns. But we can add new column at the end.

create or replace view order_summary as
select od.ord_id, od.date, pi.prod_name, cd.cust_name,
(pi.price * od.quantity) - ((pi.price * od.quantity) * disc_percent::float/100) as cost
from tb_customer_data cd
join tb_order_details od on od.cust_id = cd.cust_id
join tb_product_info pi on pi.prod_id = od.prod_id;

-- Alter View
alter view order_summary rename column date to order_date;
alter view order_summary rename to order_summary_2;

-- Drop View
drop view order_summary_2;







