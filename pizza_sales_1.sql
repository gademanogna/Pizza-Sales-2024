select * from pizza_sales;

SELECT SUM(total_price) AS Total_Revenue from pizza_sales;


SELECT SUM(total_price) / COUNT(DISTINCT order_id) AS Avg_Order_Value from pizza_sales;


SELECT SUM(quantity) AS Total_pizza_sold FROM pizza_sales;

SELECT COUNT(DISTINCT order_id) AS Total_Orders from pizza_sales;


SELECT CAST(SUM(quantity) AS DECIMAL(10,2)) / 
CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS Avg_pizza_per_order FROM pizza_sales; 


--Hourly Trend for Total Pizza Sold
SELECT DATEPART(HOUR, order_time) AS order_hour, SUM(quantity) AS Total_pizza_sold 
FROM pizza_sales
GROUP BY DATEPART(HOUR, order_time)
ORDER BY DATEPART(HOUR, order_time);


--Weekly Trend for Total Orders
SELECT DATEPART(ISO_WEEK, order_date) AS week_number, YEAR(order_date) AS order_year,
COUNT(DISTINCT order_id) AS Total_orders 
FROM pizza_sales
GROUP BY DATEPART(ISO_WEEK, order_date), YEAR(order_date)
ORDER BY DATEPART(ISO_WEEK, order_date), YEAR(order_date);


--Percentage of sales by pizza category
SELECT pizza_category, CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_Revenue, 
CAST(SUM(total_price) * 100 / 
(SELECT SUM(total_price) FROM pizza_sales) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
GROUP BY pizza_category; 

--Percentage of sales by pizza size
SELECT pizza_size, CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_Sales, CAST(SUM(total_price) * 100 / 
(SELECT SUM(total_price) FROM pizza_sales) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
GROUP BY pizza_size
ORDER BY PCT DESC;


--Top 5 Best sellers by revenue
SELECT TOP 5 pizza_name, SUM(total_price) AS Total_Revenue 
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue DESC;

--Bottom 5 sellers by revenue
SELECT TOP 5 pizza_name, SUM(total_price) AS Total_Revenue 
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue ASC;


--Top 5 Best sellers by quantity
SELECT TOP 5 pizza_name, SUM(quantity) AS Total_Quantity 
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Quantity DESC;

--Bottom 5 sellers by quantity
SELECT TOP 5 pizza_name, SUM(quantity) AS Total_Quantity 
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Quantity ASC;

--Top 5 Best sellers by order
SELECT TOP 5 pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders DESC;


--Bottom 5 sellers by order
SELECT TOP 5 pizza_name, COUNT(DISTINCT order_id) AS Total_Orders 
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders ASC;


