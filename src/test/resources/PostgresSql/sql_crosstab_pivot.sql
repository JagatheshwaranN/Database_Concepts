-- CrossTab / Pivot
-- Note: The base query should at least have 3 columns.
-- 1.	First column should be the unique identifier.
-- 2.	Second column should provide the list of categories.
-- 3.	Third column value should be loaded into each of the category mentioned in column 2.

-- With Clause is used to transform the NULL values into 0 for calculation of sum
-- amount for the each customer for 12 months.
with pivot_data as
	(select *
		from
		(
			-- Base Query -- Provides Raw Data
			select customer_id as customer,
			format(sales_date, 'MMM-yy') as sales_order,
			cast(replace(amount, '$', '') as int) as amount
			from sales_data
		) as sales_data
		pivot
			(	
			-- Here, SQL will do sum(amount) using aggregate function --
			-- SQL will create multiple columns based on the value that returned 
			-- from sales_date and what we have mentioned here for sales_date.
			-- Also, each of the below values are correspond to the base query's 
			-- sales_date column
			-- The aggregation of the amount is happening based on each customer.
				sum(amount)
				for sales_date in ([Jan-21], [Feb-21], [Mar-21], [Apr-21], [May-21],
				[Jun-21], [Jul-21], [Aug-21], [Sep-21], [Oct-21], [Nov-21], [Dec-21])
			) as pivot_table
		-- Union is used to merge the specific customer rows with the below Total row
		UNION
		select *
		from
		(
			-- Here instead of customer_id, its replaced by 'Total' because we need
			-- the total amount irrespective of the customers.
			select 'Total' as customer,
			format(sales_date, 'MMM-yy') as sales_order,
			cast(replace(amount, '$', '') as int) as amount
			from sales_data
		) as sales_data
		pivot
			(	
			-- Here, SQL will do sum(amount) using aggregate function --
			-- SQL will create multiple columns based on the value that returned 
			-- from sales_date and what we have mentioned here for sales_date.
			-- Also, each of the below values are correspond to the base query's 
			-- sales_date column
			-- The aggregation of the amount is happening based on each customer.
				sum(amount)
				for sales_date in ([Jan-21], [Feb-21], [Mar-21], [Apr-21], [May-21],
				[Jun-21], [Jul-21], [Aug-21], [Sep-21], [Oct-21], [Nov-21], [Dec-21])
			) as pivot_table,
	final_data as
		(select customer_id,
		-- Actual code which transforms Null into 0
		coalesce([Jan-21], 0) as Jan_21,
		coalesce([Feb-21], 0) as Feb_21,
		coalesce([Mar-21], 0) as Mar_21,
		coalesce([Apr-21], 0) as Apr_21,
		coalesce([May-21], 0) as May_21,
		coalesce([Jun-21], 0) as Jun_21,
		coalesce([Jul-21], 0) as Jul_21,
		coalesce([Aug-21], 0) as Aug_21,
		coalesce([Sep-21], 0) as Sep_21,
		coalesce([Oct-21], 0) as Oct_21,
		coalesce([Nov-21], 0) as Nov_21,
		coalesce([Dec-21], 0) as Dec_21
		from pivot_data)
select customer,
case when Jan_21 < 0 then concat('(', Jan_21 * -1, ')$') else concat (Jan_21, '$') 
end as "Jan_21",
case when Feb_21 < 0 then concat('(', Feb_21 * -1, ')$') else concat (Feb_21, '$') 
end as "Feb_21",
case when Mar_21 < 0 then concat('(', Mar_21 * -1, ')$') else concat (Mar_21, '$') 
end as "Mar_21",
case when Apr_21 < 0 then concat('(', Apr_21 * -1, ')$') else concat (Apr_21, '$') 
end as "Apr_21",
case when May_21 < 0 then concat('(', May_21 * -1, ')$') else concat (May_21, '$') 
end as "May_21",
case when Jun_21 < 0 then concat('(', Jun_21 * -1, ')$') else concat (Jun_21, '$') 
end as "Jun_21",
case when Jul_21 < 0 then concat('(', Jul_21 * -1, ')$') else concat (Jul_21, '$') 
end as "Jul_21",
case when Aug_21 < 0 then concat('(', Aug_21 * -1, ')$') else concat (Aug_21, '$') 
end as "Aug_21",
case when Sep_21 < 0 then concat('(', Sep_21 * -1, ')$') else concat (Sep_21, '$') 
end as "Sep_21",
case when Oct_21 < 0 then concat('(', Oct_21 * -1, ')$') else concat (Oct_21, '$') 
end as "Oct_21",
case when Nov_21 < 0 then concat('(', Nov_21 * -1, ')$') else concat (Nov_21, '$') 
end as "Nov_21",
case when Dec_21 < 0 then concat('(', Dec_21 * -1, ')$') else concat (Dec_21, '$') 
end as "Dec_21",
case when customer = 'Total' then ''
	else case when (Jan_21+Feb_21+Mar_21+Apr_21+May_21+Jun_21+Jul_21+Aug_21+Sep_21+Oct_21+Nov_21+Dec_21) < 0
				then concat('(',(Jan_21+Feb_21+Mar_21+Apr_21+May_21+Jun_21+Jul_21+Aug_21+Sep_21+Oct_21+Nov_21+Dec_21) * -1,')$')
			  else 	concat('(',(Jan_21+Feb_21+Mar_21+Apr_21+May_21+Jun_21+Jul_21+Aug_21+Sep_21+Oct_21+Nov_21+Dec_21),')$')
		 end  
end as Total		 
from final_data;