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

Insert into p_products values ('p1', 'Iphone 13 Max Pro', 1000, 5, 95);

create table p_sales(
order_id int primary key generated always as identity, 
order_date date, 
prod_code varchar(20), 
qty_ordered int, 
sale_price int);

Insert into p_sales values (default, to_date('05-02-2023', 'dd-mm-yyyy'), 'p1', 10, 10000);
Insert into p_sales values (default, to_date('10-08-2023', 'dd-mm-yyyy'), 'p1', 5, 5000);
Insert into p_sales values (default, to_date('11-12-2023', 'dd-mm-yyyy'), 'p1', 6, 6000);

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

