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

-- 3) Display the order id, order date, and product name for all the completed orders.
select order_id, order_date, name
from sales_order so inner join products p on p.id = so.prod_id 
where lower(so.status) = 'completed';

-- 4) Sort the above query to show the earliest orders at the top. Also display the
-- customer who purchased these orders.
select order_id, order_date, p.name, c.name
from sales_order so 
inner join products p on p.id = so.prod_id 
inner join customers c on so.customer_id = c.id
where lower(so.status) = 'completed'
order by order_date asc;

-- 5) Display the total number of orders corresponding to each delivery status.
select status, count(*)
from sales_order
group by status



