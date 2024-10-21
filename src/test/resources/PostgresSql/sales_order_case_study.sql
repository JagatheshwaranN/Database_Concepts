SELECT * FROM products;
SELECT * FROM customers;
SELECT * FROM employees;
SELECT * FROM sales_order;

-- 1) Identify the total number of products sold.
select sum(quantity) from sales_order;

-- 2) Other than Completed, display the available delivery status.
select status from sales_order where status <> 'Completed';
select status from sales_order where status != 'Completed';
select status from sales_order where status not in ('Completed', 'completed');
select status from sales_order where lower(status) <> 'completed';
select status from sales_order where upper(status) <> 'COMPLETED';


