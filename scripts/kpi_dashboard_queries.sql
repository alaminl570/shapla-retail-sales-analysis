/*****************************************************************************************
Purpose:
This script calculates key business KPIs including Total Revenue, Total Profit,
Profit Margin %, Average Order Value (AOV), Top 5 Products by Revenue,
Revenue by Region, and generates consolidated dashboard-style result sets.
*****************************************************************************************/


-- KPI 1 – Total Revenue
SELECT
    SUM(od.quantity * p.unit_price) AS total_revenue
FROM products p
INNER JOIN order_details od
    ON od.product_id = p.product_id;


-- KPI 2 – Total Profit
SELECT
    -- Profit per unit = Selling Price - Cost Price
    SUM(od.quantity * (p.unit_price - p.cost_price)) AS total_profit
FROM products p
INNER JOIN order_details od
    ON od.product_id = p.product_id;


-- KPI 3 – Profit Margin %
SELECT
    -- Margin % = (Total Profit / Total Revenue) * 100
    CONCAT(
        ROUND(
            SUM(od.quantity * (p.unit_price - p.cost_price)) * 100.0 /
            SUM(od.quantity * p.unit_price),
        2
        ), '%'
    ) AS profit_margin_percent
FROM products p
INNER JOIN order_details od
    ON od.product_id = p.product_id;


-- KPI 4 – Average Order Value (AOV)
SELECT 
    ROUND(
        SUM(od.quantity * p.unit_price) * 1.0 /   -- 1.0 ensures decimal division
        COUNT(DISTINCT o.order_id),               -- Prevents duplication from multiple order lines
    2
    ) AS avg_order_value
FROM orders o
JOIN order_details od ON o.order_id = od.order_id
JOIN products p ON od.product_id = p.product_id;


-- KPI 5 – Top 5 Products by Revenue
SELECT
    p.product_name,
    SUM(od.quantity * p.unit_price) AS total_revenue
FROM order_details od
INNER JOIN products p 
    ON od.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_revenue DESC;


-- KPI 6 – Revenue by Region
SELECT 
    c.region,
    SUM(od.quantity * p.unit_price) AS total_revenue
FROM orders o
JOIN customers c 
    ON o.customer_id = c.customer_id
JOIN order_details od 
    ON o.order_id = od.order_id
JOIN products p 
    ON od.product_id = p.product_id
GROUP BY c.region
ORDER BY total_revenue DESC;



/*****************************************************************************************
Consolidated KPI Report (Single Result Set for Dashboard KPI Cards)
*****************************************************************************************/

SELECT
    'Total Revenue' AS measure_name,
    SUM(od.quantity * p.unit_price) AS measure_value
FROM products p
JOIN order_details od 
    ON od.product_id = p.product_id

UNION ALL

SELECT
    'Total Profit',
    SUM(od.quantity * (p.unit_price - p.cost_price))
FROM products p
JOIN order_details od 
    ON od.product_id = p.product_id

UNION ALL

SELECT
    'Profit Margin %',
    ROUND(
        SUM(od.quantity * (p.unit_price - p.cost_price)) * 100.0 /
        SUM(od.quantity * p.unit_price),
    2)
FROM products p
JOIN order_details od 
    ON od.product_id = p.product_id

UNION ALL

SELECT
    'Average Order Value (AOV)',
    ROUND(
        SUM(od.quantity * p.unit_price) * 1.0 /
        COUNT(DISTINCT o.order_id),
    2)
FROM orders o
JOIN order_details od 
    ON o.order_id = od.order_id
JOIN products p 
    ON od.product_id = p.product_id;



/*****************************************************************************************
Dashboard View – Top Products & Revenue by Region Combined
*****************************************************************************************/

SELECT *
FROM (
    SELECT TOP 5
        'Top 5 Product' AS measure_name,
        p.product_name AS category_name,
        SUM(od.quantity * p.unit_price) AS total_revenue
    FROM order_details od
    JOIN products p 
        ON od.product_id = p.product_id
    GROUP BY p.product_name
    ORDER BY SUM(od.quantity * p.unit_price) DESC
) AS top_products

UNION ALL

SELECT
    'Revenue by Region' AS measure_name,
    c.region AS category_name,
    SUM(od.quantity * p.unit_price) AS total_revenue
FROM orders o
JOIN customers c 
    ON o.customer_id = c.customer_id
JOIN order_details od 
    ON o.order_id = od.order_id
JOIN products p 
    ON od.product_id = p.product_id
GROUP BY c.region;