WITH transaction_summary AS (
    SELECT 
        owner_id,
        COUNT(*) AS total_transactions,
        SUM(confirmed_amount) AS total_value
    FROM savings_savingsaccount
    GROUP BY owner_id
),
tenure_data AS (
    SELECT 
        id AS customer_id,
        name,
        TIMESTAMPDIFF(MONTH, created_on, CURDATE()) AS tenure_months
    FROM users_customuser
),
clv_calc AS (
    SELECT 
        t.owner_id AS customer_id,
        u.name,
        u.tenure_months,
        t.total_transactions,
        ROUND(t.total_value * 0.001 / NULLIF(t.total_transactions, 0), 2) AS avg_profit_per_transaction,
        ROUND(((t.total_transactions / NULLIF(u.tenure_months, 0)) * 12 * (t.total_value * 0.001 / NULLIF(t.total_transactions, 0))), 2) AS estimated_clv
    FROM transaction_summary t
    JOIN tenure_data u ON t.owner_id = u.customer_id
)
SELECT 
    customer_id,
    name,
    tenure_months,
    total_transactions,
    estimated_clv
FROM clv_calc
ORDER BY estimated_clv DESC;