/*****************************************************************************************
Purpose:
This script analyzes business performance across regions, products, customers,
time (monthly trends), customer segments, and product-level margins.
It identifies revenue leaders, profitability drivers, trend patterns,
and low-margin products requiring pricing review.
*****************************************************************************************/


-- 1) Which region generates the highest revenue?
SELECT 
    c.region,
    SUM(od.quantity * p.unit_price) AS revenue
FROM customers c
INNER JOIN orders o
    ON c.customer_id = o.customer_id
INNER JOIN order_details od
    ON od.order_id = o.order_id
INNER JOIN products p
    ON p.product_id = od.product_id
GROUP BY c.region
ORDER BY revenue DESC;  -- Highest revenue region appears first



-- 2) Which product categories are most profitable?
SELECT
    p.product_category,
    -- NOTE: This calculation currently represents revenue, not profit
    SUM(od.quantity * p.unit_price) AS total_profit
FROM products p
INNER JOIN order_details od
    ON p.product_id = od.product_id
GROUP BY p.product_category
ORDER BY total_profit DESC;



-- 3) Who are the top revenue-generating customers?
SELECT
    c.customer_id,
    c.customer_name,
    SUM(od.quantity * p.unit_price) AS revenue
FROM orders o
INNER JOIN customers c
    ON o.customer_id = c.customer_id
INNER JOIN order_details od
    ON o.order_id = od.order_id
INNER JOIN products p
    ON p.product_id = od.product_id
GROUP BY c.customer_id, c.customer_name
ORDER BY revenue DESC;



-- 4) What is the monthly sales trend in 2024?
WITH monthly_trends AS (
    SELECT
        MONTH(o.order_date) AS order_month,
        SUM(od.quantity * p.unit_price) AS revenue,
        COUNT(c.customer_id) AS total_customers,   -- Counts rows after join (not distinct customers)
        SUM(od.quantity) AS total_quantity
    FROM orders o
    INNER JOIN customers c
        ON o.customer_id = c.customer_id
    INNER JOIN order_details od
        ON o.order_id = od.order_id
    INNER JOIN products p
        ON p.product_id = od.product_id
    WHERE YEAR(o.order_date) = 2024
    GROUP BY MONTH(o.order_date)
)
SELECT 
    order_month,
    revenue,
    LAG(revenue) OVER (ORDER BY order_month) AS diff_pre_month, -- Previous month revenue
    CASE 
        WHEN revenue - LAG(revenue) OVER (ORDER BY order_month) > 0 THEN 'Increase'
        WHEN revenue - LAG(revenue) OVER (ORDER BY order_month) < 0 THEN 'Decrease'
        ELSE 'No Change'
    END AS pre_month_change,
    ROUND(AVG(revenue) OVER (), 2) AS avg_revenue,  -- Overall monthly average
    total_customers,
    total_quantity
FROM monthly_trends;



-- 5) Which customer segment (Retail vs Corporate) produces higher profit?
SELECT
    c.customer_type,
    SUM(od.quantity * (p.unit_price - p.cost_price)) AS total_profit,
    SUM(od.quantity * p.unit_price) AS total_revenue
FROM orders o
LEFT JOIN customers c
    ON o.customer_id = c.customer_id
LEFT JOIN order_details od
    ON o.order_id = od.order_id
LEFT JOIN products p
    ON p.product_id = od.product_id
GROUP BY c.customer_type
ORDER BY total_profit DESC;



-- 6) Which products have low profit margin and need pricing review?
SELECT
    product_name,
    cost_price,
    unit_price,
    CONCAT(
        ROUND(((unit_price - cost_price) / unit_price) * 100, 2),
        '%'
    ) AS margin_percent
FROM products
WHERE ((unit_price - cost_price) / unit_price) < 0.30  -- Threshold: below 30% margin
ORDER BY margin_percent;