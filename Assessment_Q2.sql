WITH tx_summary AS (
    SELECT 
        owner_id,
        COUNT(*) AS total_transactions,
        PERIOD_DIFF(DATE_FORMAT(MAX(transaction_date), '%Y%m'), DATE_FORMAT(MIN(transaction_date), '%Y%m')) + 1 AS months_active
    FROM savings_savingsaccount
    GROUP BY owner_id
),
tx_frequency AS (
    SELECT 
        owner_id,
        total_transactions,
        months_active,
        ROUND(total_transactions / months_active, 2) AS avg_per_month
    FROM tx_summary
),
categorized AS (
    SELECT 
        CASE
            WHEN avg_per_month >= 10 THEN 'High Frequency'
            WHEN avg_per_month BETWEEN 3 AND 9 THEN 'Medium Frequency'
            ELSE 'Low Frequency'
        END AS frequency_category,
        avg_per_month
    FROM tx_frequency
)
SELECT 
    frequency_category,
    COUNT(*) AS customer_count,
    ROUND(AVG(avg_per_month), 1) AS avg_transactions_per_month
FROM categorized
GROUP BY frequency_category;