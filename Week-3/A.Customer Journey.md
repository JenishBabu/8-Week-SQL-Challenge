# Foodie - Fi

## A. Customer Journey

Based off the 8 sample customers provided in the sample from the subscriptions table, write a brief description about each customer’s onboarding journey.Try to keep it as short as possible - you may also want to run some sort of join to make your explanations a bit easier

***

### Total Number of Subscribers

```sql
SELECT 
    COUNT(DISTINCT customer_id) AS no_of_subscribers
FROM
    subscriptions;
```

***

### Number of subscriptions each subscriber has

```sql
SELECT 
    customer_id, COUNT(*) AS no_of_subscriptions
FROM
    subscriptions
GROUP BY 1;
```

#### Selecting random customer_ids for the onboarding details.

### Customer_id = 14

```sql
SELECT 
    s.customer_id, p.plan_name, p.price, s.start_date
FROM
    subscriptions s
        JOIN
    plans p ON s.plan_id = p.plan_id
WHERE
    s.customer_id = 14;
```

#### Result
![image](https://github.com/JenishBabu/8-Week-SQL-Challenge/assets/110540665/65fcda5e-539f-4429-949d-2444888aa708)

* This Customer Starts the trail from 22-09-2020
* After free trail the customer subscribed to basic monthly plan.

