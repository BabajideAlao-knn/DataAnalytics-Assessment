WITH latest_savings AS (
    SELECT 
        id AS plan_id,
        owner_id,
        'Savings' AS type,
        MAX(transaction_date) AS last_transaction_date
    FROM savings_savingsaccount
    GROUP BY id, owner_id
),
latest_investments AS (
    SELECT 
        id AS plan_id,
        owner_id,
        'Investment' AS type,
        MAX(last_charge_date) AS last_transaction_date
    FROM plans_plan
    GROUP BY id, owner_id
),
combined AS (
    SELECT * FROM latest_savings
    UNION ALL
    SELECT * FROM latest_investments
)
SELECT 
    plan_id,
    owner_id,
    type,
    last_transaction_date,
    DATEDIFF(CURDATE(), last_transaction_date) AS inactivity_days
FROM combined
WHERE last_transaction_date < CURDATE() - INTERVAL 365 DAY;