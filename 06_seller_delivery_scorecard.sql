USE olist_ecommerce;

-- 1. Reduce reviews to one record per order
WITH review_by_order AS (
    SELECT
        order_id,
        AVG(review_score) AS avg_review_score
    FROM order_reviews
    GROUP BY order_id
),

-- 2. Calculate delivery performance for delivered orders
delivered_orders AS (
    SELECT
        order_id,

        CASE
            WHEN DATE(order_delivered_customer_date)
                 > DATE(order_estimated_delivery_date)
            THEN 1
            ELSE 0
        END AS is_late,

        DATEDIFF(
            DATE(order_delivered_customer_date),
            DATE(order_estimated_delivery_date)
        ) AS days_vs_estimated

    FROM orders
    WHERE order_status = 'delivered'
      AND order_delivered_customer_date IS NOT NULL
      AND order_estimated_delivery_date IS NOT NULL
),

-- 3. Keep one row per order and seller
seller_order_pairs AS (
    SELECT DISTINCT
        order_id,
        seller_id
    FROM order_items
    WHERE seller_id IS NOT NULL
),

-- 4. Combine delivery and review metrics
seller_order_metrics AS (
    SELECT
        sop.seller_id,
        d.order_id,
        d.is_late,
        d.days_vs_estimated,
        r.avg_review_score

    FROM seller_order_pairs sop

    INNER JOIN delivered_orders d
        ON sop.order_id = d.order_id

    LEFT JOIN review_by_order r
        ON d.order_id = r.order_id
)

-- 5. Create the seller scorecard
SELECT
    seller_id,

    COUNT(*) AS delivered_orders,

    SUM(is_late) AS late_orders,

    ROUND(
        100.0 * AVG(is_late),
        2
    ) AS late_delivery_pct,

    COUNT(avg_review_score) AS reviewed_orders,

    ROUND(
        AVG(avg_review_score),
        2
    ) AS avg_review_score,

    ROUND(
        100.0 * SUM(
            CASE
                WHEN avg_review_score <= 2 THEN 1
                ELSE 0
            END
        ) / NULLIF(COUNT(avg_review_score), 0),
        2
    ) AS low_review_pct,

    ROUND(
        AVG(days_vs_estimated),
        1
    ) AS avg_days_vs_estimated

FROM seller_order_metrics

GROUP BY seller_id

HAVING COUNT(*) >= 50

ORDER BY
    late_delivery_pct DESC,
    delivered_orders DESC

LIMIT 25;