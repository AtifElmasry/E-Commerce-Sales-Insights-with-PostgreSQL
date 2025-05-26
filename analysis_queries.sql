-- SQL Queries for Data Insights

-- Top 5 customers by total spend
SELECT c.name, SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.name
ORDER BY total_spent DESC
LIMIT 5;

-- Best-selling products by quantity
SELECT p.name, SUM(oi.quantity) AS total_sold
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.name
ORDER BY total_sold DESC;

-- Average order value
SELECT AVG(total_amount) AS average_order_value
FROM orders;

-- Ad campaign performance
SELECT a.campaign_name, COUNT(ac.click_id) AS clicks, a.spend, 
       ROUND(a.spend / NULLIF(COUNT(ac.click_id), 0), 2) AS cost_per_click
FROM ads a
LEFT JOIN ad_clicks ac ON a.ad_id = ac.ad_id
GROUP BY a.campaign_name, a.spend;
