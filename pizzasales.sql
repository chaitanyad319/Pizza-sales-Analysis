SET SQL_SAFE_UPDATES=0;
#Total Revenue of Pizza Sales:
select sum(total_price)as Total_Revenue from pizzasales;
#Average Order Values of Pizza Sales:
select sum(total_price)/COUNT(distinct order_id) as Avg_order_value from pizzasales;
#Total Pizzas Sold:
select sum(quantity) as Total_pizza_sold from pizzasales;
#Total Number of Orders:
select count(distinct order_id) as Total_orders from pizzasales;
#Average number of Pizzas sold Per Order:
select sum(quantity)/count(distinct order_id) as Average_pizza_sold_per_Order from pizzasales;

#Changing date format
UPDATE pizzasales
SET order_date = DATE_FORMAT(STR_TO_DATE(order_date, '%d-%m-%Y'), '%Y-%m-%d');

#DAIILY TRENDS and MONTHLY TREND:
SELECT DAYNAME(order_date) AS Order_Day, COUNT(DISTINCT order_id) AS Total_Orders 
FROM pizzasales
GROUP BY DAYNAME(order_date);
SELECT month(Order_date) as Order_Month, COUNT(Distinct order_id) as Total_Orders
from pizzasales
GROUP BY month(Order_date);

#Percentage of Pizza sales per category:
SELECT pizza_category, CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_Revenue,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) 
from pizzasales) AS DECIMAL(10,2)) AS PCT
FROM pizzasales
GROUP BY pizza_category;

#Percentage of sales per category for particular month:
SELECT pizza_category, CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_Revenue,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) 
from pizzasales where month(order_date)=1) AS DECIMAL(10,2)) AS PCT
FROM pizzasales
where month(order_date)=1
GROUP BY pizza_category;

#Percentage of sales by pizza size:
select pizza_size, 
cast(sum(total_price) as decimal(10,2)) as total_renevnue,
cast(sum(total_price)*100/(select sum(total_price)from pizzasales)as decimal(10,2)) as PCT 
from pizzasales 
group by pizza_size
order by pct DESC;

#Percentage of sales by Pizza Category:
select pizza_category, 
cast(sum(total_price) as decimal(10,2)) as total_renevnue,
cast(sum(total_price)*100/(select sum(total_price)from pizzasales)as decimal(10,2)) as PCT 
from pizzasales
group by pizza_category
order by pct DESC;

#Top 5 best sellers by revenue,total quantity and total order:
select pizza_name,sum(total_price) as total_revenue from pizzasales
group by pizza_name
order by total_revenue DESC
limit 5;
select pizza_name,sum(quantity) as total_quantity from pizzasales
group by pizza_name
order by total_quantity DESC
limit 5;
select pizza_name,count(distinct order_id) as total_count from pizzasales
group by pizza_name
order by total_count DESC
limit 5;

#Worst 5 best sellers by revenue,total quantity and total order:
select pizza_name,sum(total_price) as total_revenue from pizzasales
group by pizza_name
order by total_revenue asc
limit 5;
select pizza_name,sum(quantity) as total_quantity from pizzasales
group by pizza_name
order by total_quantity ASC
limit 5;
select pizza_name,count(distinct order_id) as total_count from pizzasales
group by pizza_name
order by total_count ASC
limit 5;

