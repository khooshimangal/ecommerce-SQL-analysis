USE olist_ecommerce;

SELECT 
    oi.seller_id,
    ROUND(AVG(r.review_score), 2)                 AS avg_rating,
    COUNT(DISTINCT oi.order_id)                   AS total_orders,
    ROUND(SUM(oi.price), 2)                       AS total_revenue,
    RANK() OVER (
        ORDER BY AVG(r.review_score) DESC
    )                                             AS rating_rank,
    CASE 
        WHEN AVG(r.review_score) >= 4.5 THEN 'Top Seller'
        WHEN AVG(r.review_score) >= 3.5 THEN 'Average Seller'
        ELSE 'Underperformer'
    END                                           AS seller_tier
FROM order_items oi
JOIN order_reviews r 
    ON oi.order_id = r.order_id
GROUP BY oi.seller_id
HAVING COUNT(DISTINCT oi.order_id) > 50
ORDER BY avg_rating DESC
LIMIT 20;