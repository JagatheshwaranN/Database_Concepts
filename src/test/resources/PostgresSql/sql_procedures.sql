-- Procedures
-- Procedure is a block of code which is given a name and stored in
-- the database.

-- Procedure can include:
-- 1. SQL queries
-- 2. DML, DDL, DCL, and TCL commands
-- 3. Collection Types
-- 4. Cursors
-- 5. Loop & If Else statements
-- 6. Variables
-- 7. Exception Handling, etc.

-- What is the purpose of using a Procedure?
-- Procedures are generally used to do things which is not possible in SQL 
-- queries.

-- Depending on the project requirement, we can bundle multiple queries into
-- Procedures or We may build entire software logic inside Procedure which may 
-- include validation checks, processing and quering of data, and much more.

-- Syntax for Procedure Creation
-- create or replace procedure pr_name(p_name varchar, p_age int)
-- language plpgsql
-- as $$ -- It is used to print the values with single quotes without using escape chars.
-- declare
-- 	variable
-- begin
-- 	procedure body - All logics
-- end;
-- $$

-- Oracle Procedure Creation
-- create or replace procedure pr_name(p_name varchar, p_age int)
-- 	variable
-- begin
-- 	procedure body - All logics
-- end;

create table p_products(
prod_code varchar(20) primary key, 
prod_name varchar(100), 
price int, 
qty_remaining int, 
qty_sold int);

insert into p_products values ('p1', 'Iphone 13 Max Pro', 1000, 5, 95);
insert into p_products values ('P2', 'AirPods Pro', 279, 10, 90);
insert into p_products values ('P3', 'MacBook Pro 16', 5000, 2, 48);
insert into p_products values ('P4', 'iPad Air', 650, 1, 9);

create table p_sales(
order_id int primary key generated always as identity, 
order_date date, 
prod_code varchar(20), 
qty_ordered int, 
sale_price int);

insert into p_sales values (default, to_date('05-02-2023', 'dd-mm-yyyy'), 'p1', 10, 10000);
insert into p_sales values (default, to_date('10-08-2023', 'dd-mm-yyyy'), 'p1', 5, 5000);
insert into p_sales values (default, to_date('11-12-2023', 'dd-mm-yyyy'), 'p1', 6, 6000);
insert into p_sales values (default, to_date('15-01-2023','dd-mm-yyyy'), 'p2', 50, 13950);
insert into p_sales values (default, to_date('25-03-2023','dd-mm-yyyy'), 'p2', 40, 11160);
insert into p_sales values (default, to_date('25-02-2023','dd-mm-yyyy'), 'p3', 10, 50000);
insert into p_sales values (default, to_date('15-03-2023','dd-mm-yyyy'), 'p3', 10, 50000);
insert into p_sales values (default, to_date('25-03-2023','dd-mm-yyyy'), 'p3', 20, 100000);
insert into p_sales values (default, to_date('21-04-2023','dd-mm-yyyy'), 'p3', 8, 40000);
insert into p_sales values (default, to_date('27-04-2023','dd-mm-yyyy'), 'p4', 9, 5850);

select * from p_products;
select * from p_sales;

-- Simple Procedure Sample
-- For every iPhone 13 Max Pro sales, modify the database tables accordingly
create or replace procedure pr_buy_product()
language plpgsql
as $$
declare
	v_prod_code varchar(20);
	v_price int;
begin
	select prod_code, price 
	into v_prod_code, v_price
	from p_products
	where prod_name = 'Iphone 13 Max Pro';
	
	insert into p_sales(order_date, prod_code, qty_ordered, sale_price)
	values (current_date, v_prod_code, 1, (v_price * 1));
	
	update p_products 
	set qty_remaining = (qty_remaining - 1),
	qty_sold = (qty_sold + 1)
	where prod_code = v_prod_code;
	
	raise notice 'Product Sold!';
end;
$$

call pr_buy_product();

--- Procedure in Oracle
-- create or replace procedure pr_buy_product
-- as 
-- 	v_prod_code varchar(20);
-- 	v_price int;
-- begin
-- 	select prod_code, price 
-- 	into v_prod_code, v_price
-- 	from p_products
-- 	where prod_name = 'Iphone 13 Max Pro';
	
-- 	insert into p_sales(order_date, prod_code, qty_ordered, sale_price)
-- 	values (current_date, v_prod_code, 1, (v_price * 1));
	
-- 	update p_products 
-- 	set qty_remaining = (qty_remaining - 1),
-- 	qty_sold = (qty_sold + 1)
-- 	where prod_code = v_prod_code;
	
-- 	dbms_output.put_line ('Product Sold!');
-- end;

-- exec pr_buy_products;

-- Procedures with Parameters
-- For every given product and the quantity,
-- 	1) Check if product is available based on the required quantity.
-- 	2) If available then modify the database tables accordingly.

-- Note
-- By default, if we don't mention the type of input, then it will be
-- treated as IN parameter. If its OUT parameter, then it has to be
-- mentioned explicitly.

create or replace procedure pr_buy_products(IN p_prod_name varchar, IN p_quantity int)
language plpgsql
as $$
declare
	v_prod_code varchar(20);
	v_price int;
	v_count int;
begin
	select count(1)
	into v_count
	from p_products
	where prod_name = p_prod_name
	and qty_remaining >= p_quantity;

	if v_count > 0 then
		select prod_code, price 
		into v_prod_code, v_price
		from p_products
		where prod_name = p_prod_name;
		
		insert into p_sales(order_date, prod_code, qty_ordered, sale_price)
		values (current_date, v_prod_code, p_quantity, (v_price * p_quantity));
		
		update p_products 
		set qty_remaining = (qty_remaining - p_quantity),
		qty_sold = (qty_sold + p_quantity)
		where prod_code = v_prod_code;
		raise notice 'Product Sold!';
	else
		raise notice 'Insufficient Quantity!';
	end if;	
end;
$$

call pr_buy_products('iPad Air', 1);

-- Procedure in Oracle
-- create or replace procedure pr_buy_products(p_prod_name varchar, p_quantity int)
-- as
--     v_cnt           int;
--     v_prod_code  varchar(20);
--     v_price         int;
-- begin

--     select count(*)
--     into v_cnt
--     from products
--     where prod_name = p_prod_name
--     and qty_remaining >= p_quantity;

--     if v_cnt > 0
--     then
--         select prod_code, price
--         into v_prod_code, v_price
--         from p_products
--         where prod_name = p_prod_name
--         and qty_remaining >= p_quantity;

--         insert into p_sales (order_date,prod_code,qty_ordered,sale_price)
-- 			values (current_date, v_prod_code, p_quantity, (v_price * p_quantity));

--         update p_products
--         set qty_remaining = (qty_remaining - p_quantity)
--         , qty_sold = (qty_sold + p_quantity)
--         where prod_code = v_prod_code;
--         dbms_output.put_line('Product sold!');
--     else
--         dbms_output.put_line('Insufficient Quantity!');
--     end if;
-- end;