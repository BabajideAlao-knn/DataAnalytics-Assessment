WITH savings AS (
    SELECT owner_id
    FROM plans_plan
    WHERE plan_type_id = 1
),
investments AS (
    SELECT owner_id
    FROM plans_plan
    WHERE plan_type_id = 2
),
deposits AS (
    SELECT s.owner_id, SUM(s.confirmed_amount) AS total_deposit
    FROM savings_savingsaccount s
    JOIN plans_plan p ON s.savings_id = p.id
    GROUP BY s.owner_id
)
SELECT 
    u.id AS owner_id,
    u.name,
    (SELECT COUNT(*) FROM plans_plan WHERE plan_type_id = 1 AND owner_id = u.id) AS savings_count,
    (SELECT COUNT(*) FROM plans_plan WHERE plan_type_id = 2 AND owner_id = u.id) AS investment_count,
    ROUND(IFNULL(d.total_deposit, 0), 2) AS total_deposits
FROM users_customuser u
JOIN savings s ON u.id = s.owner_id
JOIN investments i ON u.id = i.owner_id
LEFT JOIN deposits d ON u.id = d.owner_id
ORDER BY total_deposits DESC;