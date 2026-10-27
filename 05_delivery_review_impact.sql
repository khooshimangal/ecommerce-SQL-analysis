USE olist_ecommerce;

WITH review_by_order AS (
    SELECT
        order_id,
        AVG(review_score) AS avg_review_score
    FROM order_reviews
    GROUP BY order_id
),

delivery_analysis AS (
    SELECT
        o.order_id,

        CASE
            WHEN DATE(o.order_delivered_customer_date)
                 > DATE(o.order_estimated_delivery_date)
            THEN 'Late'
            ELSE 'On time or early'
        END AS delivery_status,

        DATEDIFF(
            DATE(o.order_delivered_customer_date),
            DATE(o.order_estimated_delivery_date)
        ) AS days_vs_estimated,

        r.avg_review_score

    FROM orders o

    LEFT JOIN review_by_order r
        ON o.order_id = r.order_id

    WHERE o.order_status = 'delivered'
      AND o.order_delivered_customer_date IS NOT NULL
      AND o.order_estimated_delivery_date IS NOT NULL
)

SELECT
    delivery_status,
    COUNT(*) AS delivered_orders,
    COUNT(avg_review_score) AS orders_with_reviews,
    ROUND(AVG(avg_review_score), 2) AS avg_review_score,

    ROUND(
        100.0 * SUM(
            CASE WHEN avg_review_score <= 2 THEN 1 ELSE 0 END
        ) / NULLIF(COUNT(avg_review_score), 0),
        2
    ) AS low_review_percentage,

    ROUND(AVG(days_vs_estimated), 1) AS avg_days_vs_estimated

FROM delivery_analysis

GROUP BY delivery_status

ORDER BY
    CASE
        WHEN delivery_status = 'Late' THEN 1
        ELSE 2
    END;