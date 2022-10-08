
## Case Study Questions

### 1. What is the total amount each customer spent at the restaurant?

````sql
  select s.customer_id , sum(m.price) from sales s
  join menu m
  on s.product_id = m.product_id
  group by s.customer_id;
````
_______________________________________________________________________________________________________________________________________________________

### 2. How many days has each customer visited the restaurant?

````sql
select customer_id , count(distinct order_date) from sales
  group by customer_id;
````
_______________________________________________________________________________________________________________________________________________________

### 3.  What was the first item from the menu purchased by each customer?


````sql
 select s.customer_id , m.product_name from sales s 
  join menu m 
  on s.product_id = m.product_id group by customer_id
  having min(date(order_date));
````
______________________________________________________________________________________________________________________________________________________

### 4. What is the most purchased item on the menu and how many times was it purchased by all customers?

````sql
 select  m.product_id,(m.product_name) , m.product_name from sales s
  join menu m 
  on s.product_id = m.product_id 
  group by  m.product_name
  order by count(m.product_name) desc
  limit 1; 
````
_______________________________________________________________________________________________________________________________________________________

### 5.  Which item was the most popular for each customer?

````sql
WITH cte AS (
SELECT m.product_name, s.customer_id, COUNT(m.product_id) AS order_count,
DENSE_RANK() OVER(PARTITION BY s.customer_id
ORDER BY COUNT(m.product_id)DESC) AS order_rank 
FROM sales s 
JOIN menu m 
ON s.product_id = m.product_id
GROUP BY s.customer_id, m.product_name
)
SELECT product_name, customer_id, order_count
FROM cte
WHERE order_rank = 1;

````
_______________________________________________________________________________________________________________________________________________________

### 6. Which item was purchased first by the customer after they became a member?

````sql
  with cte as
  (select 
  row_number() over (partition by s.customer_id order by s.order_date) as rownum, 
  s.order_date,s.customer_id,m.product_name,me.join_date from menu m join sales s on m.product_id = s.product_id 
  join members me on s.customer_id = me.customer_id 
  where s.order_date > me.join_date)
  select customer_id, product_name from cte where rownum =1;

````
_______________________________________________________________________________________________________________________________________________________

### 7. Which menu item(s) was purchased just before the customer became a member and when?
 
 ````sql
 with cte as(
  select 
  row_number() over (partition by s.customer_id order by s.order_date desc) as rownum, 
  s.order_date,s.customer_id,m.product_name,me.join_date from menu m join sales s on m.product_id = s.product_id 
  join members me on s.customer_id = me.customer_id 
  where s.order_date <= me.join_date)
  select customer_id,product_name from cte
  where rownum=1
  ;
````
_______________________________________________________________________________________________________________________________________________________

### 8. What is the total items and amount spent for each member before they became a member?

````sql
 select s.customer_id,(s.product_id),sum(m.price) from sales s join menu m 
  on s.product_id = m.product_id join members me on s.customer_id= me.customer_id
  where s.order_date < me.join_date
  group by s.customer_id;
````
_______________________________________________________________________________________________________________________________________________________

### 9. If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?
 
````sql 
 with cte as (
  select s.customer_id, 
  m.product_name,
  case when m.product_name = 'sushi' then (sum(m.price)*20)
  else (sum(m.price)*10) end as points
  ,sum(m.price) from sales s join menu m on s.product_id =
  m.product_id group by s.customer_id,m.product_name)
  select customer_id , sum(points) from cte 
  group by customer_id;
````
_______________________________________________________________________________________________________________________________________________________

### 10. In the first week after a customer joins the program (including their join date) they earn 2x points on all items, – not just sushi — how many points do customer A and B have at the end of January?
 
 ````sql
select s.customer_id , sum(case
when s.order_date>=me.join_date and s.order_date <= date_add(me.join_date, interval 6 day) then m.price*20
else m.price*10 end) as points from sales s join menu m on 
s.product_id = m.product_id join members me on s.customer_id = me.customer_id
group by s.customer_id order by points desc;
````
_______________________________________________________________________________________________________________________________________________________

### Bonus Question:

### 11. Recreate the given Table..


````sql
select s.customer_id , s.order_date , m.product_name , m.price ,
case  when me.join_date is null then "N"
else (case when me.join_date > s.order_date then "N"
else "Y"
end)
end as members
from sales s join menu m on s.product_id = m.product_id left join members me on s.customer_id = me.customer_id ;
````
