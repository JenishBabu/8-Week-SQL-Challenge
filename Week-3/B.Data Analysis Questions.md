# Foodie-Fi

## B.Data Analysis Questions

### Case Study Questions
1. How many customers has Foodie-Fi ever had?
2. What is the monthly distribution of trial plan start_date values for our dataset - use the start of the month as the group by value
3. What plan start_date values occur after the year 2020 for our dataset? Show the breakdown by count of events for each plan_name
4. What is the customer count and percentage of customers who have churned rounded to 1 decimal place?
5. How many customers have churned straight after their initial free trial - what percentage is this rounded to the nearest whole number?
6. What is the number and percentage of customer plans after their initial free trial?
7. What is the customer count and percentage breakdown of all 5 plan_name values at 2020-12-31?
8. How many customers have upgraded to an annual plan in 2020?
9. How many days on average does it take for a customer to an annual plan from the day they join Foodie-Fi?
10. Can you further breakdown this average value into 30 day periods (i.e. 0-30 days, 31-60 days etc)
11. How many customers downgraded from a pro monthly to a basic monthly plan in 2020?

***

### How many customers has Foodie-Fi ever had?

```sql
SELECT 
    COUNT(DISTINCT customer_id) AS no_of_customers
FROM
    subscriptions;
```

#### Result
![image](https://github.com/JenishBabu/8-Week-SQL-Challenge/assets/110540665/dd8d05bb-7cd4-4809-b881-794ac9b3bbdb)

***

### What is the monthly distribution of trial plan start_date values for our dataset - use the start of the month as the group by value

```sql
SELECT 
    MONTH(start_date) AS month_, COUNT(*) AS no_of_subscribers
FROM
    subscriptions
WHERE
    plan_id = 0
GROUP BY 1
ORDER BY 1;
```

#### Result
![image](https://github.com/JenishBabu/8-Week-SQL-Challenge/assets/110540665/1c272ec1-d85c-4c81-9405-cd072321c62b)

***

### What plan start_date values occur after the year 2020 for our dataset? Show the breakdown by count of events for each plan_name

```sql
SELECT 
    p.plan_id,
    p.plan_name,
    COUNT(s.customer_id) AS no_of_customers
FROM
    plans p
        JOIN
    subscriptions s ON p.plan_id = s.plan_id
WHERE
    YEAR(s.start_date) > 2020
GROUP BY 1 , 2
ORDER BY 1;
```

#### Result
![image](https://github.com/JenishBabu/8-Week-SQL-Challenge/assets/110540665/4c436f56-d84b-4162-b29f-e42e7a4807bb)

***

### What is the customer count and percentage of customers who have churned rounded to 1 decimal place?

```sql
SELECT 
    COUNT(s.customer_id) AS no_of_costomers,
    ROUND((COUNT(s.customer_id) / (SELECT 
                    COUNT(DISTINCT customer_id)
                FROM
                    subscriptions)) * 100,
            1) AS percentage
FROM
    subscriptions s
        JOIN
    plans p ON s.plan_id = p.plan_id
WHERE
    p.plan_name = 'Churn';
```

#### Result
![image](https://github.com/JenishBabu/8-Week-SQL-Challenge/assets/110540665/0d54c5ae-ffde-4499-aa48-4dff86a46281)

***

### How many customers have churned straight after their initial free trial - what percentage is this rounded to the nearest whole number?

```sql
select count(*) as churn_count, 
round(count(*)/10,0) as churn_percent from
              (
                     select *, lead(plan_id) over() as next_month_pln 
              from subscriptions
              ) as A
where plan_id = 0 and next_month_pln = 4;
```

#### Result
![image](https://github.com/JenishBabu/8-Week-SQL-Challenge/assets/110540665/eccec60d-5811-4345-b1fc-0743297d0038)

***

### What is the number and percentage of customer plans after their initial free trial?

```sql
SELECT 
    p.plan_id,
    p.plan_name,
    COUNT(s.customer_id) AS No_of_subs,
    ROUND((COUNT(s.customer_id) / (SELECT COUNT(DISTINCT customer_id)
                FROM
                    subscriptions)) * 100,1) AS Subs_percent
FROM
    plans p
        JOIN
    subscriptions s ON p.plan_id = s.plan_id
WHERE
    p.plan_id != 0
GROUP BY 1 , 2;
```

#### Result
![image](https://github.com/JenishBabu/8-Week-SQL-Challenge/assets/110540665/8130b501-db14-40e4-8d98-d293803039de)

***

### How many customers have upgraded to an annual plan in 2020?

```sql
SELECT 
    COUNT(s.customer_id) AS Annual_count
FROM
    subscriptions s
        JOIN
    plans p ON s.plan_id = p.plan_id
WHERE
    YEAR(s.start_date) = 2020
        AND p.plan_name = 'pro annual';
```

#### Result
![image](https://github.com/JenishBabu/8-Week-SQL-Challenge/assets/110540665/b402a263-bffd-4f23-90e0-d08e0de023d2)

***

### How many days on average does it take for a customer to an annual plan from the day they join Foodie-Fi?

```sql
WITH CTE AS (
SELECT customer_id, start_date 
FROM subscriptions s
JOIN plans p 
ON s.plan_id = p.plan_id
WHERE plan_name = 'trial' ),

ACTE AS (
SELECT customer_id, start_date as annual_date
FROM subscriptions s
JOIN 
plans p 
ON s.plan_id = p.plan_id
WHERE plan_name = 'pro annual' )

SELECT Avg(DATEDIFF(annual_date, start_date)) as avg_day
FROM ACTE C2
JOIN CTE C1 ON C2.customer_id =C1.customer_id;
```

#### Result
![image](https://github.com/JenishBabu/8-Week-SQL-Challenge/assets/110540665/73a1e8b3-3239-462a-ba7d-c63d93b2351b)

***

### How many customers downgraded from a pro monthly to a basic monthly plan in 2020?

```sql
select count(*) from (
select p.plan_name, lead(p.plan_name) over() as next_pln, 
s.customer_id, s.start_date from plans p join 
subscriptions s 
on p.plan_id = s.plan_id) as J
where plan_name = 'pro monthly' and next_pln = 'basic monthly' and year(start_date) = 2020;
;
```

#### Result
![image](https://github.com/JenishBabu/8-Week-SQL-Challenge/assets/110540665/2bdfa602-d40a-4cbb-bc02-ae71f6300018)













