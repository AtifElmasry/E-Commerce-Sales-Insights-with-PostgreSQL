
# 📊 E-Commerce SQL Insights Report

This document summarizes key insights generated from SQL queries on the e-commerce database. The queries were executed using PostgreSQL to extract actionable patterns related to customer behavior and product performance.

---

## 🥇 1. Top 5 Customers by Total Spending

**Query:**
```sql
SELECT 
    c.full_name,
    c.email,
    ROUND(SUM(o.total_amount), 2) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.full_name, c.email
ORDER BY total_spent DESC
LIMIT 5;
```

**Insight:** These are your most valuable customers. Consider targeting them with loyalty programs or early access to new products.

---

## 📦 2. Best-Selling Products (by Quantity)

**Query:**
```sql
SELECT 
    p.name AS product_name,
    p.category,
    SUM(oi.quantity) AS total_units_sold
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.name, p.category
ORDER BY total_units_sold DESC
LIMIT 5;
```

**Insight:** These products drive the most unit sales. They could benefit from prominent placement in your store and bundled promotions.

---

## 💰 3. Average Order Value Per Customer

**Query:**
```sql
SELECT 
    c.full_name,
    COUNT(o.order_id) AS total_orders,
    ROUND(AVG(o.total_amount), 2) AS avg_order_value
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.full_name
ORDER BY avg_order_value DESC
LIMIT 10;
```

**Insight:** Identifies high-value purchasers based on average spend per order. Use this to tailor upsell strategies or suggest premium product lines.

---

## 🔁 4. Repeat Customers (2+ Orders)

**Query:**
```sql
SELECT 
    c.full_name,
    COUNT(o.order_id) AS order_count
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.full_name
HAVING COUNT(o.order_id) > 1
ORDER BY order_count DESC;
```

**Insight:** Repeat customers are a key metric for customer satisfaction and product quality. Nurture these relationships with personalized marketing.

---
