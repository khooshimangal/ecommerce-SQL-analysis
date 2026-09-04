USE olist_ecommerce;

SELECT 
    t.product_category_name_english               AS category,
    ROUND(SUM(oi.price), 2)                       AS total_revenue,
    COUNT(DISTINCT oi.order_id)                   AS total_orders,
    ROUND(AVG(oi.price), 2)                       AS avg_item_price,
    ROUND(SUM(oi.price) * 100.0 / 
        SUM(SUM(oi.price)) OVER (), 2)            AS revenue_share_pct
FROM order_items oi
JOIN products p 
    ON oi.product_id = p.product_id
JOIN category_translation t 
    ON p.product_category_name = t.product_category_name
GROUP BY category
ORDER BY total_revenue DESC
LIMIT 10;