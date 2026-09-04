USE olist_ecommerce;

SELECT 
    payment_type,
    COUNT(*)                                        AS total_transactions,
    ROUND(SUM(payment_value), 2)                    AS total_value,
    ROUND(AVG(payment_value), 2)                    AS avg_transaction_value,
    ROUND(COUNT(*) * 100.0 / 
        SUM(COUNT(*)) OVER (), 2)                   AS transaction_share_pct,
    ROUND(SUM(payment_value) * 100.0 / 
        SUM(SUM(payment_value)) OVER (), 2)         AS value_share_pct
FROM order_payments
GROUP BY payment_type
ORDER BY total_value DESC;