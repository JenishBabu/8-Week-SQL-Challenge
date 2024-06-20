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

### 1. How many customers has Foodie-Fi ever had?

```sql
SELECT 
    COUNT(DISTINCT customer_id) AS no_of_customers
FROM
    subscriptions;
```

#### Result
![image](https://github.com/JenishBabu/8-Week-SQL-Challenge/assets/110540665/dd8d05bb-7cd4-4809-b881-794ac9b3bbdb)

***

### 2.What is the monthly distribution of trial plan start_date values for our dataset - use the start of the month as the group by value

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

### 3.What plan start_date values occur after the year 2020 for our dataset? Show the breakdown by count of events for each plan_name

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

### 4.What is the customer count and percentage of customers who have churned rounded to 1 decimal place?

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

### 5.How many customers have churned straight after their initial free trial - what percentage is this rounded to the nearest whole number?

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


















