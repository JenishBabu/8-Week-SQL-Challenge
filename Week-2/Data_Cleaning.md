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

## ATTAINING 1NF IN pizza_recipes TABLE

```sql
CREATE TABLE PizzaRecipies (
    pizza_id INT,
    topping INT
);


INSERT INTO PizzaRecipies (pizza_id, topping)
SELECT pizza_id, TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(toppings, ',', numbers.n), ',', -1)) + 0 AS topping
FROM pizza_recipes
JOIN (
    SELECT 1 n UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4
    UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8
    UNION ALL SELECT 9 UNION ALL SELECT 10
    UNION ALL SELECT 11 UNION ALL SELECT 12
) numbers ON CHAR_LENGTH(toppings) - CHAR_LENGTH(REPLACE(toppings, ',', '')) >= numbers.n - 1
ORDER BY pizza_id, topping;
```
