## CLEANING CUSTOMER ORDERS TABLE.

````sql
create temporary table temp_customer_orders 
select order_id , customer_id , pizza_id , 
case when exclusions ='' or exclusions like 'null' then null
else exclusions 
end as exclusions ,
case when extras = '' or extras like 'null' then null
else extras 
end as extras,
order_time from customer_orders;
````

## CLEANING TABLE RUNNER TABLE.

````sql
create temporary table temp_runner_orders 
select order_id , runner_id, 
case when pickup_time = '' or pickup_time like 'null' then null
else pickup_time
end as pickup_time,
case when distance = '' or distance like 'null' then null
when distance like '%km' then trim('km' from distance)
else distance
end as distance,
case when duration = '' or duration like 'null' then null 
when duration like '%mins' then trim('mins' from duration)
when duration like '%minute' then trim('minute' from duration)
when duration like '%minutes' then trim('minutes' from duration)
else duration 
end as duration,
case when cancellation = '' or cancellation like 'null' then null
else cancellation
end as cancellation
from runner_orders;   
````
