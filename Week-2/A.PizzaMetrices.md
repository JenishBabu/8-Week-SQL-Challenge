# Pizza Runner

## A.Pizza Metrices

### How many pizzas were ordered?

````sql
SELECT 
    COUNT(order_id) AS Pizzas_Ordered
FROM
    temp_customer_orders;
````

### How many unique customer orders were made?

````sql
SELECT 
    COUNT(DISTINCT order_id) AS Unique_customer_orders
FROM
    temp_customer_orders;
````

### How many successful orders were delivered by each runner?

````sql
SELECT 
    runner_id, COUNT(order_id) AS successful_orders
FROM
    temp_runner_orders
WHERE
    cancellation IS NULL
GROUP BY runner_id;
````

### How many of each type of pizza was delivered?

````sql
SELECT 
    p.pizza_name, COUNT(c.pizza_id) AS sucessful_delivery
FROM
    temp_customer_orders c
        JOIN
    pizza_names p ON c.pizza_id = p.pizza_id
        JOIN
    temp_runner_orders r ON c.order_id = r.order_id
WHERE
    r.cancellation IS NULL
GROUP BY c.pizza_id;
````

### How many Vegetarian and Meatlovers were ordered by each customer?

````sql
SELECT 
    c.customer_id,
    p.pizza_name,
    COUNT(p.pizza_id) AS Pizzas_ordered
FROM
    temp_customer_orders c
        JOIN
    pizza_names p ON c.pizza_id = p.pizza_id
GROUP BY 1 , 2
ORDER BY 1;
````

### What was the maximum number of pizzas delivered in a single order?

````sql
SELECT 
    c.order_id, COUNT(c.order_id) AS Pizza_in_single_order
FROM
    temp_customer_orders c
        JOIN
    temp_runner_orders r ON c.order_id = r.order_id
WHERE
    r.cancellation IS NULL
GROUP BY c.order_id
ORDER BY 2 DESC
LIMIT 1;
````

### For each customer, how many delivered pizzas had at least 1 change and how many had no changes?

````sql
select c.customer_id ,sum(
case when c.exclusions is not null then 1
when c.extras is not null then 1
end) as Changes,
sum(case when c.exclusions is null and c.extras is null then 1
end) as No_Changes  from temp_customer_orders c join temp_runner_orders r
on c.order_id = r.order_id where r.cancellation is null group by customer_id;
````

### How many pizzas were delivered that had both exclusions and extras?

````sql
SELECT 
    COUNT(c.pizza_id) AS Delivered_Changed_pizzas
FROM
    temp_customer_orders c
        JOIN
    temp_runner_orders r ON c.order_id = r.order_id
WHERE
    c.exclusions IS NOT NULL
        AND c.extras IS NOT NULL
        AND r.cancellation IS NULL;
````

### What was the total volume of pizzas ordered for each hour of the day?

````sql
SELECT 
    HOUR(order_time) AS Hour_of_day,
    COUNT(order_id) AS Num_of_orders
FROM
    temp_customer_orders
GROUP BY 1
ORDER BY 1; 
````

### What was the volume of orders for each day of the week?

````sql
SELECT 
    DAYNAME(order_time) as Weekday, COUNT(order_id) as PizzasOrdered
FROM
    temp_customer_orders
GROUP BY 1
ORDER BY 1;
````

