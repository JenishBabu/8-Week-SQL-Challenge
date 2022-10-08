CREATE SCHEMA dannysdiner;
use dannysdiner;

/*create table sales*/
CREATE TABLE sales (
  customer_id VARCHAR(1),
  order_date DATE,
  product_id INTEGER
);


/* Insert values in sales */

INSERT INTO sales
  
VALUES
  ('A', '2021-01-01', '1'),
  ('A', '2021-01-01', '2'),
  ('A', '2021-01-07', '2'),
  ('A', '2021-01-10', '3'),
  ('A', '2021-01-11', '3'),
  ('A', '2021-01-11', '3'),
  ('B', '2021-01-01', '2'),
  ('B', '2021-01-02', '2'),
  ('B', '2021-01-04', '1'),
  ('B', '2021-01-11', '1'),
  ('B', '2021-01-16', '3'),
  ('B', '2021-02-01', '3'),
  ('C', '2021-01-01', '3'),
  ('C', '2021-01-01', '3'),
  ('C', '2021-01-07', '3');
 


/* Create table menu */ 

CREATE TABLE menu (
  product_id INTEGER,
  product_name VARCHAR(5),
  price INTEGER
);

/*Insert values in menu */

INSERT INTO menu
  
VALUES
  ('1', 'sushi', '10'),
  ('2', 'curry', '15'),
  ('3', 'ramen', '12');
  

/*Create table members */

CREATE TABLE members (
  customer_id VARCHAR(1),
  join_date DATE
);

/* Insert into members */
INSERT INTO members
  
VALUES
  ('A', '2021-01-07'),
  ('B', '2021-01-09');
  
  
  /* #1 What is the total amount each customer spent at the restaurant? */
  
  select s.customer_id , sum(m.price) from sales s
  join menu m
  on s.product_id = m.product_id
  group by s.customer_id;
  
  /* #2 How many days has each customer visited the restaurant? */
  
  select customer_id , count(distinct order_date) from sales
  group by customer_id;
  
  /* #3 What was the first item from the menu purchased by each customer */
  
  select s.customer_id , m.product_name from sales s 
  join menu m 
  on s.product_id = m.product_id group by customer_id
  having min(date(order_date));
  
  /* #4 What is the most purchased item on the menu and how many times was it purchased by all customers? */
  
  select  m.product_id,(m.product_name) , m.product_name from sales s
  join menu m 
  on s.product_id = m.product_id 
  group by  m.product_name
  order by count(m.product_name) desc
  limit 1

  ; 
  
  /* #5 Which item was the most popular for each customer? */

select (select dense_rank() over(partition by s.customer_id
order by count(s.customer_id) desc) as ranki,
s.customer_id , m.product_name , count(m.product_name)
from sales s join menu m on s.product_id = m.product_id 
group by m.product_name,s.customer_id 
order by s.customer_id) as jen
from jen
where ranki =1;


  /* #6 Which item was purchased first by the customer after they became a member? */
  
  with cte as
  (select 
  row_number() over (partition by s.customer_id order by s.order_date) as rownum, 
  s.order_date,s.customer_id,m.product_name,me.join_date from menu m join sales s on m.product_id = s.product_id 
  join members me on s.customer_id = me.customer_id 
  where s.order_date > me.join_date)
  select customer_id, product_name from cte where rownum =1;
  
  /* #7 Which item was purchased just before the customer became a member?*/
  
  with cte as(
  select 
  row_number() over (partition by s.customer_id order by s.order_date desc) as rownum, 
  s.order_date,s.customer_id,m.product_name,me.join_date from menu m join sales s on m.product_id = s.product_id 
  join members me on s.customer_id = me.customer_id 
  where s.order_date <= me.join_date)
  select customer_id,product_name from cte
  where rownum=1
  ;
  
  /* #8 What is the total items and amount spent for each member before they became a member? */
  
  select s.customer_id,(s.product_id),sum(m.price) from sales s join menu m 
  on s.product_id = m.product_id join members me on s.customer_id= me.customer_id
  where s.order_date < me.join_date
  group by s.customer_id;
  
  
  /* #9 If each $1 spent equates 10 points and sushi has a 2x multiplier how many 
  points would each customer have ? */
  
  with cte as (
  select s.customer_id, 
  m.product_name,
  case when m.product_name = 'sushi' then (sum(m.price)*20)
  else (sum(m.price)*10) end as points
  ,sum(m.price) from sales s join menu m on s.product_id =
  m.product_id group by s.customer_id,m.product_name)
  select customer_id , sum(points) from cte 
  group by customer_id;
  
  /* #10 In the first week after a customer joins the program (including their join date) 
  they earn 2x points on all items, not just sushi - how many points do customer A and B 
  have at the end of January? */
  
select s.customer_id , sum(case
when s.order_date>=me.join_date and s.order_date <= date_add(me.join_date, interval 6 day) then m.price*20
else m.price*10 end) as points from sales s join menu m on 
s.product_id = m.product_id join members me on s.customer_id = me.customer_id
group by s.customer_id order by points desc;

/* #BONUS QUETIONS# */

/* Recreate the given table */ 

select s.customer_id , s.order_date , m.product_name , m.price ,
case  when me.join_date is null then "N"
else (case when me.join_date > s.order_date then "N"
else "Y"
end)
end as members
from sales s join menu m on s.product_id = m.product_id left join members me on s.customer_id = me.customer_id ;

  

 
  
  
  


  
  