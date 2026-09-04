USE olist_ecommerce;

SELECT 
    c.customer_state,
    ROUND(AVG(DATEDIFF(
        o.order_delivered_customer_date,
        o.order_purchase_timestamp
    )), 1)                                        AS avg_delivery_days,
    COUNT(o.order_id)                             AS total_orders,
    ROUND(MIN(DATEDIFF(
        o.order_delivered_customer_date,
        o.order_purchase_timestamp
    )), 0)                                        AS fastest_delivery_days,
    ROUND(MAX(DATEDIFF(
        o.order_delivered_customer_date,
        o.order_purchase_timestamp
    )), 0)                                        AS slowest_delivery_days,
    RANK() OVER (
        ORDER BY AVG(DATEDIFF(
            o.order_delivered_customer_date,
            o.order_purchase_timestamp
        ))
    )                                             AS speed_rank
FROM orders o
JOIN customers c 
    ON o.customer_id = c.customer_id
WHERE o.order_delivered_customer_date IS NOT NULL
  AND o.order_status = 'delivered'
GROUP BY c.customer_state
ORDER BY avg_delivery_days;