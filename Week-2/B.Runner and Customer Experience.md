# Pizza Runner

## B.Runner and Customer Experience

### How many runners signed up for each 1 week period? (i.e. week starts 2021-01-01)?

```sql
SELECT 
    WEEK(registration_date), COUNT(runner_id)
FROM
    runners
GROUP BY 1;
```

### What was the average time in minutes it took for each runner to arrive at the Pizza Runner HQ to pickup the order?

```sql
SELECT 
    r.runner_id,
    ROUND(AVG(TIMESTAMPDIFF(MINUTE,
                c.order_time,
                r.pickup_time)),
            2) AS avg_time
FROM
    temp_runner_orders r
        JOIN
    temp_customer_orders c ON r.order_id = c.order_id
WHERE
    r.cancellation IS NULL
GROUP BY r.runner_id; 
```
### What was the average distance travelled for each customer?

```sql
SELECT 
    c.customer_id,
    SUM(r.distance) / COUNT(c.order_id) AS distance_travelled
FROM
    temp_customer_orders c
        JOIN
    temp_runner_orders r ON c.order_id = r.order_id
WHERE
    r.cancellation IS NULL
GROUP BY c.customer_id;
```

### What was the difference between the longest and shortest delivery times for all orders?

```sql
SELECT 
    MAX(duration) - MIN(duration) AS diff_between_longest_and_shortest_delivery
FROM
    temp_runner_orders;
```

### What was the average speed for each runner for each delivery and do you notice any trend for these values?

```sql
with cte as 
(select order_id,runner_id,distance,(duration/60) as d from temp_runner_orders where cancellation is null)
select order_id,runner_id,
round(avg(distance/d),2) as km_per_hr from cte group by order_id 
order by 2;
```

### What is the successful delivery percentage for each runner?

```sql
SELECT 
    runner_id,
    COUNT(*) AS no_of_orders,
    ROUND(100 * COUNT(distance) / COUNT(*), 0) AS sucess_delivery_percentage
FROM
    temp_runner_orders
GROUP BY runner_id;
```

### Is there any relationship between the number of pizzas and how long the order takes to prepare?

```sql
WITH cte AS
  (SELECT r.order_id,
          COUNT(r.order_id) AS pizzas_ordered,
          TIMESTAMPDIFF(MINUTE, c.order_time, r.pickup_time) AS prep_time
   FROM temp_runner_orders r
   JOIN temp_customer_orders c on r.order_id = c.order_id
   WHERE cancellation IS NULL
   GROUP BY r.order_id)
SELECT pizzas_ordered,
       round(avg(prep_time), 2)
FROM cte
GROUP BY pizzas_ordered;
```
