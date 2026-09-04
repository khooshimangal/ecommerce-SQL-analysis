USE olist_ecommerce;

SELECT 
    DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m') AS month,
    ROUND(SUM(oi.price + oi.freight_value), 2)       AS total_revenue,
    COUNT(DISTINCT o.order_id)                        AS total_orders,
    ROUND(AVG(oi.price + oi.freight_value), 2)        AS avg_order_value
FROM orders o
JOIN order_items oi 
    ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
GROUP BY month
ORDER BY month;

