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

#### Result
![image](https://github.com/JenishBabu/8-Week-SQL-Challenge/assets/110540665/ef346047-aa65-4db8-9cd8-3931ab41a58a)

***

### Number of subscriptions each subscriber has

```sql
SELECT 
    customer_id, COUNT(*) AS no_of_subscriptions
FROM
    subscriptions
GROUP BY 1;
```
#### Result
![image](https://github.com/JenishBabu/8-Week-SQL-Challenge/assets/110540665/273f3177-4b69-42b5-be50-fd8a8d1ada42)

***

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

***

### Customer_id = 106

```sql
SELECT 
    s.customer_id, p.plan_name, p.price, s.start_date
FROM
    subscriptions s
        JOIN
    plans p ON s.plan_id = p.plan_id
WHERE
    s.customer_id = 106;
```

#### Result
![image](https://github.com/JenishBabu/8-Week-SQL-Challenge/assets/110540665/d3ef6929-d80c-4198-9cff-bca6251c7bc3)

* This Customer starts the free trail from 2 August 2020.
* Then Subscribed to pro annual plan from 7th of August.

***

### Customer_id = 789

```sql
SELECT 
    s.customer_id, p.plan_name, p.price, s.start_date
FROM
    subscriptions s
        JOIN
    plans p ON s.plan_id = p.plan_id
WHERE
    s.customer_id = 789;
```

#### Result
![image](https://github.com/JenishBabu/8-Week-SQL-Challenge/assets/110540665/a5a713ee-bba3-4607-9a1a-3dfb20e2e23d)

* Started free trail on June 28, 2020.
* Then Subscribed to basic monthly trail after the free trail.

***

### Customer_id = 69

```sql
SELECT 
    s.customer_id, p.plan_name, p.price, s.start_date
FROM
    subscriptions s
        JOIN
    plans p ON s.plan_id = p.plan_id
WHERE
    s.customer_id = 69;
```

#### Result
![image](https://github.com/JenishBabu/8-Week-SQL-Challenge/assets/110540665/07a20cbf-5a47-43cc-a41f-7720fbe6df72)

* Started the free trail fron 07-03-2020.
* After free trail subscribed to basic monthly plan.
* Then upgraded the plan to pro monthly from 14-04-2020.

***

### Customer_id = 10

```sql
SELECT 
    s.customer_id, p.plan_name, p.price, s.start_date
FROM
    subscriptions s
        JOIN
    plans p ON s.plan_id = p.plan_id
WHERE
    s.customer_id = 10;
```

#### Result
![image](https://github.com/JenishBabu/8-Week-SQL-Challenge/assets/110540665/19f925e9-a728-44d6-b5c7-3ebe41dd8528)

* This customer started the free trail from 19-09-2020.
* Then after 7 days of free trail, subscribed to pro monthly plan.

***

### Customer_id = 669

```sql
SELECT 
    s.customer_id, p.plan_name, p.price, s.start_date
FROM
    subscriptions s
        JOIN
    plans p ON s.plan_id = p.plan_id
WHERE
    s.customer_id = 669;
```

#### Result
![image](https://github.com/JenishBabu/8-Week-SQL-Challenge/assets/110540665/a4aa2669-8cce-4c40-8dc5-081410555421)

* Started free trail from 28-11-2020.
* After free trail subscribed to basic monthly plan.
* Then after 4 months into the basic monthly plan, the customer upgraged into pro  monthly from 24-04-2021.

***

### Customer_id = 1000

```sql
SELECT 
    s.customer_id, p.plan_name, p.price, s.start_date
FROM
    subscriptions s
        JOIN
    plans p ON s.plan_id = p.plan_id
WHERE
    s.customer_id = 1000;
```

#### Result
![image](https://github.com/JenishBabu/8-Week-SQL-Challenge/assets/110540665/7447e28e-0293-496c-a383-01db72dcb76b)

* This customer stated using foofie-fi from 19-03-2020.
* Then uses pro monthly plan for 3 months from 26-03-2020.
* Cancels the plan on 04-06-2020 but can still use the foodie-fi till the end of billing date.

***

### Customer_id = 888

```sql
SELECT 
    s.customer_id, p.plan_name, p.price, s.start_date
FROM
    subscriptions s
        JOIN
    plans p ON s.plan_id = p.plan_id
WHERE
    s.customer_id = 888;
```

#### Result
![image](https://github.com/JenishBabu/8-Week-SQL-Challenge/assets/110540665/e2b2f47f-7298-4c9f-87b7-e410592d8d2a)

* Started the free trail on 25-02-2020 and after the free trail subscibed to pro monthly plan.
* After two months the customer upgraded the plan to pro annual from 03-05-2020.
