-- Executive KPI summary
SELECT
    ROUND(SUM(line_revenue), 2) AS net_revenue,
    COUNT(DISTINCT invoice_no) AS orders,
    COUNT(DISTINCT customer_id) AS identified_customers,
    ROUND(
        SUM(line_revenue) / NULLIF(COUNT(DISTINCT invoice_no), 0),
        2
    ) AS average_order_value
FROM transactions;

-- Monthly revenue, orders and purchasing customers
SELECT
    DATE_TRUNC('month', invoice_date) AS month,
    ROUND(SUM(line_revenue), 2) AS revenue,
    COUNT(DISTINCT invoice_no) AS orders,
    COUNT(DISTINCT customer_id) AS customers
FROM transactions
GROUP BY 1
ORDER BY 1;

-- Country performance excluding the home market
SELECT
    country,
    ROUND(SUM(line_revenue), 2) AS revenue,
    COUNT(DISTINCT invoice_no) AS orders,
    ROUND(
        SUM(line_revenue) / NULLIF(COUNT(DISTINCT invoice_no), 0),
        2
    ) AS average_order_value
FROM transactions
WHERE country <> 'United Kingdom'
GROUP BY country
ORDER BY revenue DESC
LIMIT 15;

-- Highest-revenue products
SELECT
    stock_code,
    MAX(description) AS description,
    SUM(quantity) AS units,
    ROUND(SUM(line_revenue), 2) AS revenue
FROM transactions
GROUP BY stock_code
ORDER BY revenue DESC
LIMIT 20;

-- Segment size and value
SELECT
    segment,
    COUNT(*) AS customers,
    ROUND(AVG(recency_days), 1) AS avg_recency_days,
    ROUND(AVG(frequency), 1) AS avg_orders,
    ROUND(SUM(monetary), 2) AS segment_value
FROM customer_rfm
GROUP BY segment
ORDER BY segment_value DESC;

-- Revenue concentration among the top 10% of customers
WITH ranked AS (
    SELECT
        customer_id,
        monetary,
        NTILE(10) OVER (ORDER BY monetary DESC) AS value_decile
    FROM customer_rfm
)
SELECT
    ROUND(
        100.0 * SUM(monetary) FILTER (WHERE value_decile = 1)
        / NULLIF(SUM(monetary), 0),
        2
    ) AS top_decile_revenue_share_pct
FROM ranked;
