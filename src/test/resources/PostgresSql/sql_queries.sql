-- What is a Database?
-- A container that stores data.
-- Relational Database?
-- Data is related to one another.
-- How data is stored?
-- Data is stored in tables. Tables is like Excel rows and columns.

create table products (
	product_code int,
	product_name varchar(50),
	price float,
	released_date date
);
select * from products;
insert into products (product_code, product_name, price, released_date)
values (1, 'Samsung A40', 1099.5, to_date('05-02-2021', 'dd-mm-yyyy'));
insert into products (product_code, product_name, price, released_date)
values (1, 'Samsung MO4', 1000, to_date('25-07-2022', 'dd-mm-yyyy'));
insert into products (product_code, product_name, price, released_date)
values (1, 'Samsung Galaxy', 2000, to_date('01-02-2023', 'dd-mm-yyyy'));
insert into products (product_code, product_name, price, released_date)
values (1, 'Realme C3', 1099.5, to_date('05-02-2020', 'dd-mm-yyyy'));
Select * from Products;
Select * from Products where price > 1000;
Select * from Products where to_char(released_date, 'yyyy') = '2022';
Select * from Products where extract (year from released_date) = '2021';
Select product_name as Product_model from Products where price > 1000;
Select count(*) from Products;
Select sum(price) from Products;
Select avg(price) from Products;
Update Products set price = 1000 where released_date = to_date('25-07-2022', 'dd-mm-yyyy');
Update Products set price = 2599 where product_name like '%Galaxy';
Update Products set price = 1100 where product_name not like '%Samsung%';
Delete from Products where price = 1100;
Delete from Products;
Truncate table products;
Create table products_backup as select * from products;
Select * from products_backup;
Create table products_backup2 as select * from products where 1 = 2;
Select * from products_backup2;
Drop table products_backup;
Drop table if exists products_backup2;
Alter table products_backup rename to products_bkp;
Alter table products_bkp rename column product_code to product_id;
Alter table products_bkp alter column product_id type varchar(10);
create table products (
	product_code int primary key,
	product_name varchar(50),
	price float,
	released_date date
);
create table products (
	product_code int,
	product_name varchar(50),
	price float,
	released_date date,
	constraint pk_prod_cd primary key (product_code)
);
create table products (
	product_code int,
	product_name varchar(50),
	price float,
	released_date date,
	constraint pk_prod_dtl primary key (product_code, product_name)
);
create table products (
	product_code int generated always as identity,
	product_name varchar(50),
	price float,
	released_date date,
	constraint pk_prod_dtl primary key (product_code, product_name)
);
insert into products (product_code, product_name, price, released_date)
values (default, 'Samsung A40', 1099.5, to_date('05-02-2021', 'dd-mm-yyyy'));
insert into products (product_code, product_name, price, released_date)
values (default, 'Samsung MO4', 1000, to_date('25-07-2022', 'dd-mm-yyyy'));
create table sales_order (
	order_id int primary key generated always as identity,
	order_date date,
	quantity int,
	product_code int,
	status varchar(30)
);
insert into sales_order (order_id, order_date, quantity, product_code, status)
values (default, to_date('02-02-2024', 'dd-mm-yyyy'), 2, 1, 'Completed');
insert into sales_order (order_id, order_date, quantity, product_code, status)
values (default, to_date('05-04-2024', 'dd-mm-yyyy'), 1, 2, 'Pending');
insert into sales_order (order_id, order_date, quantity, product_code, status)
values (default, to_date('07-08-2024', 'dd-mm-yyyy'), 1, 15, 'Completed');
