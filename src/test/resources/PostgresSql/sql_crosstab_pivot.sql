-- CrossTab / Pivot

/*
write a query to fetch the results into a desired format.
Solve the problem using CASE statement, PIVOT table and CROSSTAB function.
*/

drop table sales_data;
create table sales_data
    (
        sales_date      date,
        customer_id     varchar(30),
        amount          varchar(30)
    );

insert into sales_data values (to_date('01-Jan-2023','dd-mon-yyyy'), 'Cust-1', '50$');
insert into sales_data values (to_date('02-Jan-2023','dd-mon-yyyy'), 'Cust-1', '50$');
insert into sales_data values (to_date('03-Jan-2023','dd-mon-yyyy'), 'Cust-1', '50$');
insert into sales_data values (to_date('01-Jan-2023','dd-mon-yyyy'), 'Cust-2', '100$');
insert into sales_data values (to_date('02-Jan-2023','dd-mon-yyyy'), 'Cust-2', '100$');
insert into sales_data values (to_date('03-Jan-2023','dd-mon-yyyy'), 'Cust-2', '100$');
insert into sales_data values (to_date('01-Feb-2023','dd-mon-yyyy'), 'Cust-2', '-100$');
insert into sales_data values (to_date('02-Feb-2023','dd-mon-yyyy'), 'Cust-2', '-100$');
insert into sales_data values (to_date('03-Feb-2023','dd-mon-yyyy'), 'Cust-2', '-100$');
insert into sales_data values (to_date('01-Mar-2023','dd-mon-yyyy'), 'Cust-3', '1$');
insert into sales_data values (to_date('01-Apr-2023','dd-mon-yyyy'), 'Cust-3', '1$');
insert into sales_data values (to_date('01-May-2023','dd-mon-yyyy'), 'Cust-3', '1$');
insert into sales_data values (to_date('01-Jun-2023','dd-mon-yyyy'), 'Cust-3', '1$');
insert into sales_data values (to_date('01-Jul-2023','dd-mon-yyyy'), 'Cust-3', '-1$');
insert into sales_data values (to_date('01-Aug-2023','dd-mon-yyyy'), 'Cust-3', '-1$');
insert into sales_data values (to_date('01-Sep-2023','dd-mon-yyyy'), 'Cust-3', '-1$');
insert into sales_data values (to_date('01-Oct-2023','dd-mon-yyyy'), 'Cust-3', '-1$');
insert into sales_data values (to_date('01-Nov-2023','dd-mon-yyyy'), 'Cust-3', '-1$');
insert into sales_data values (to_date('01-Dec-2023','dd-mon-yyyy'), 'Cust-3', '-1$');

select * from sales_data;


-- Notes:
-- 1. In PostgresSQL, we don't have pivot function.
-- 2. We have to use the tablefunc extension.
-- 3. Crosstab function takes 2 arguments. 
	-- 1. First argument is base query
	-- 2. Second argument is list of values

create extension tablefunc;

select customer_id as customer,
			to_char(sales_date, 'Mon-YY') as sales_order,
			sum(cast(replace(amount, '$', '') as int)) as amount
			from sales_data
			group by customer_id, to_char(sales_date, 'Mon-YY')
			order by 1;

-- Note: The base query should at least have 3 columns.
-- 1.	First column should be the unique identifier.
-- 2.	Second column should provide the list of categories.
-- 3.	Third column value should be loaded into each of the category mentioned in column 2.

-- Reason for Order By 1. The Customer Id in base query are not in proper order.
-- With this, when PostgresSQL process these records inside the Crosstab function
-- As soon as the PostgresSQL finds the unique records for customer_ids it will
-- create one record for those combination of records from output of base query.
-- This way, without Order by, Crosstab will create multiple records for customers.
-- To avoid this, we need to use the Order By clause.

with pivot_data as
		(select * 
		from crosstab('select customer_id as customer,
					to_char(sales_date, ''Mon-YY'') as sales_order,
					sum(cast(replace(amount, ''$'', '''') as int)) as amount
					from sales_data
					group by customer_id, to_char(sales_date, ''Mon-YY'')
					order by 1',
					'values (''Jan-23''),(''Feb-23''),(''Mar-23''),(''Apr-23''),(''May-23''),(''Jun-23''),
					(''Jul-23''),(''Aug-23''),(''Sep-23''),(''Oct-23''),(''Nov-23''),(''Dec-23'')')
			as (customer varchar, Jan_23 bigint, Feb_23 bigint, Mar_23 bigint, Apr_23 bigint, May_23 bigint, Jun_23 bigint,
				Jul_23 bigint, Aug_23 bigint, Sep_23 bigint, Oct_23 bigint, Nov_23 bigint, Dec_23 bigint)
		union
		select * 
		from crosstab('select ''Total'' as customer,
					to_char(sales_date, ''Mon-YY'') as sales_order,
					sum(cast(replace(amount, ''$'', '''') as int)) as amount
					from sales_data
					group by to_char(sales_date, ''Mon-YY'')
					order by 1',
					'values (''Jan-23''),(''Feb-23''),(''Mar-23''),(''Apr-23''),(''May-23''),(''Jun-23''),
					(''Jul-23''),(''Aug-23''),(''Sep-23''),(''Oct-23''),(''Nov-23''),(''Dec-23'')')
			as (customer varchar, Jan_23 bigint, Feb_23 bigint, Mar_23 bigint, Apr_23 bigint, May_23 bigint, Jun_23 bigint,
				Jul_23 bigint, Aug_23 bigint, Sep_23 bigint, Oct_23 bigint, Nov_23 bigint, Dec_23 bigint)
		order by 1), 
		final_data as
		(select customer,
		-- Actual code which transforms Null into 0
		coalesce(Jan_23, 0) as Jan_23,
		coalesce(Feb_23, 0) as Feb_23,
		coalesce(Mar_23, 0) as Mar_23,
		coalesce(Apr_23, 0) as Apr_23,
		coalesce(May_23, 0) as May_23,
		coalesce(Jun_23, 0) as Jun_23,
		coalesce(Jul_23, 0) as Jul_23,
		coalesce(Aug_23, 0) as Aug_23,
		coalesce(Sep_23, 0) as Sep_23,
		coalesce(Oct_23, 0) as Oct_23,
		coalesce(Nov_23, 0) as Nov_23,
		coalesce(Dec_23, 0) as Dec_23
		from pivot_data)
select customer,
case when Jan_23 < 0 then '(' || Jan_23 * -1 ||')$' else Jan_23 || '$' end as "Jan_23",
case when Feb_23 < 0 then '(' || Feb_23 * -1 ||')$' else Feb_23 || '$' end as "Feb_23",
case when Mar_23 < 0 then '(' || Mar_23 * -1 ||')$' else Mar_23 || '$' end as "Mar_23",
case when Apr_23 < 0 then '(' || Apr_23 * -1 ||')$' else Apr_23 || '$' end as "Apr_23",
case when May_23 < 0 then '(' || May_23 * -1 ||')$' else May_23 || '$' end as "May_23",
case when Jun_23 < 0 then '(' || Jun_23 * -1 ||')$' else Jun_23 || '$' end as "Jun_23",
case when Jul_23 < 0 then '(' || Jul_23 * -1 ||')$' else Jul_23 || '$' end as "Jul_23",
case when Aug_23 < 0 then '(' || Aug_23 * -1 ||')$' else Aug_23 || '$' end as "Aug_23",
case when Sep_23 < 0 then '(' || Sep_23 * -1 ||')$' else Sep_23 || '$' end as "Sep_23",
case when Oct_23 < 0 then '(' || Oct_23 * -1 ||')$' else Oct_23 || '$' end as "Oct_23",
case when Nov_23 < 0 then '(' || Nov_23 * -1 ||')$' else Nov_23 || '$' end as "Nov_23",
case when Dec_23 < 0 then '(' || Dec_23 * -1 ||')$' else Dec_23 || '$' end as "Dec_23",
case when customer = 'Total' then ''
	else case when (Jan_23+Feb_23+Mar_23+Apr_23+May_23+Jun_23+Jul_23+Aug_23+Sep_23+Oct_23+Nov_23+Dec_23) < 0
				then '(' || (Jan_23+Feb_23+Mar_23+Apr_23+May_23+Jun_23+Jul_23+Aug_23+Sep_23+Oct_23+Nov_23+Dec_23) * -1 || ')$'
			  else 	(Jan_23+Feb_23+Mar_23+Apr_23+May_23+Jun_23+Jul_23+Aug_23+Sep_23+Oct_23+Nov_23+Dec_23)||'$'
		 end  
end as Total		 
from final_data;
						
-- ORACLE FORMAT --
-- With Clause is used to transform the NULL values into 0 for calculation of sum
-- amount for the each customer for 12 months.
-- with pivot_data as
-- 	(select *
-- 		from
-- 		(
-- 			-- Base Query -- Provides Raw Data
-- 			select customer_id as customer,
-- 			to_char(sales_date, 'Mon-YY') as sales_order,
-- 			cast(replace(amount, '$', '') as int) as amount
-- 			from sales_data
-- 		)
-- 		pivot
-- 			(	
-- 			-- Here, SQL will do sum(amount) using aggregate function --
-- 			-- SQL will create multiple columns based on the value that returned 
-- 			-- from sales_date and what we have mentioned here for sales_date.
-- 			-- Also, each of the below values are correspond to the base query's 
-- 			-- sales_date column
-- 			-- The aggregation of the amount is happening based on each customer.
-- 				sum(amount)
-- 				for sales_date in ('Jan-21' as Jan_21, 'Feb-21' as Feb_21, 'Mar-21' as Mar_21,
-- 				'Apr-21' as Apr_21, 'May-21' as May_21, 'Jun-21' as Jun_21, 'Jul-21' as Jul_21,
-- 				'Aug-21' as Aug_21, 'Sep-21' as Sep_21, 'Oct-21' as Oct_21, 'Nov-21' as Nov_21,
-- 				'Dec-21' as Dec_21)
-- 			)
-- 		-- Union is used to merge the specific customer rows with the below Total row
-- 		UNION
-- 		select *
-- 		from
-- 		(
-- 			-- Here instead of customer_id, its replaced by 'Total' because we need
-- 			-- the total amount irrespective of the customers.
-- 			select 'Total' as customer,
-- 			to_char(sales_date, 'Mon-YY') as sales_order,
-- 			cast(replace(amount, '$', '') as int) as amount
-- 			from sales_data
-- 		)
-- 		pivot
-- 			(	
-- 			-- Here, SQL will do sum(amount) using aggregate function --
-- 			-- SQL will create multiple columns based on the value that returned 
-- 			-- from sales_date and what we have mentioned here for sales_date.
-- 			-- Also, each of the below values are correspond to the base query's 
-- 			-- sales_date column
-- 			-- The aggregation of the amount is happening based on each customer.
-- 				sum(amount)
-- 				for sales_date in ('Jan-21' as Jan_21, 'Feb-21' as Feb_21, 'Mar-21' as Mar_21,
-- 				'Apr-21' as Apr_21, 'May-21' as May_21, 'Jun-21' as Jun_21, 'Jul-21' as Jul_21,
-- 				'Aug-21' as Aug_21, 'Sep-21' as Sep_21, 'Oct-21' as Oct_21, 'Nov-21' as Nov_21,
-- 				'Dec-21' as Dec_21)
-- 			),
-- 	final_data as
-- 		(select customer,
-- 		-- Actual code which transforms Null into 0
-- 		NVL(Jan_21, 0) as Jan_21,
-- 		NVL(Feb_21, 0) as Feb_21,
-- 		NVL(Mar_21, 0) as Mar_21,
-- 		NVL(Apr_21, 0) as Apr_21,
-- 		NVL(May_21, 0) as May_21,
-- 		NVL(Jun_21, 0) as Jun_21,
-- 		NVL(Jul_21, 0) as Jul_21,
-- 		NVL(Aug_21, 0) as Aug_21,
-- 		NVL(Sep_21, 0) as Sep_21,
-- 		NVL(Oct_21, 0) as Oct_21,
-- 		NVL(Nov_21, 0) as Nov_21,
-- 		NVL(Dec_21, 0) as Dec_21
-- 		from pivot_data)
-- select customer,
-- case when Jan_21 < 0 then '(' || Jan_21 * -1 ||')$' else Jan_21 || '$' end as "Jan_21",
-- case when Feb_21 < 0 then '(' || Feb_21 * -1 ||')$' else Feb_21 || '$' end as "Feb_21",
-- case when Mar_21 < 0 then '(' || Mar_21 * -1 ||')$' else Mar_21 || '$' end as "Mar_21",
-- case when Apr_21 < 0 then '(' || Apr_21 * -1 ||')$' else Apr_21 || '$' end as "Apr_21",
-- case when May_21 < 0 then '(' || May_21 * -1 ||')$' else May_21 || '$' end as "May_21",
-- case when Jun_21 < 0 then '(' || Jun_21 * -1 ||')$' else Jun_21 || '$' end as "Jun_21",
-- case when Jul_21 < 0 then '(' || Jul_21 * -1 ||')$' else Jul_21 || '$' end as "Jul_21",
-- case when Aug_21 < 0 then '(' || Aug_21 * -1 ||')$' else Aug_21 || '$' end as "Aug_21",
-- case when Sep_21 < 0 then '(' || Sep_21 * -1 ||')$' else Sep_21 || '$' end as "Sep_21",
-- case when Oct_21 < 0 then '(' || Oct_21 * -1 ||')$' else Oct_21 || '$' end as "Oct_21",
-- case when Nov_21 < 0 then '(' || Nov_21 * -1 ||')$' else Nov_21 || '$' end as "Nov_21",
-- case when Dec_21 < 0 then '(' || Dec_21 * -1 ||')$' else Dec_21 || '$' end as "Dec_21",
-- case when customer = 'Total' then ''
-- 	else case when (Jan_21+Feb_21+Mar_21+Apr_21+May_21+Jun_21+Jul_21+Aug_21+Sep_21+Oct_21+Nov_21+Dec_21) < 0
-- 				then '(' || (Jan_21+Feb_21+Mar_21+Apr_21+May_21+Jun_21+Jul_21+Aug_21+Sep_21+Oct_21+Nov_21+Dec_21) * -1 || ')$'
-- 			  else 	(Jan_21+Feb_21+Mar_21+Apr_21+May_21+Jun_21+Jul_21+Aug_21+Sep_21+Oct_21+Nov_21+Dec_21)||'$'
-- 		 end  
-- end as Total		 
-- from final_data;