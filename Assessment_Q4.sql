WITH CustomerTransactions AS (
    SELECT
        ssa.owner_id,
        COUNT(*) AS total_transactions,
        SUM(ssa.confirmed_amount) AS total_deposit_value_kobo
    FROM savings_savingsaccount ssa
    GROUP BY ssa.owner_id
)
SELECT
    u.id AS customer_id,
    u.name,
    CAST((JULIANDAY('now') - JULIANDAY(u.date_joined)) / 30 AS REAL) AS tenure_months,
    COALESCE(ct.total_transactions, 0) AS total_transactions,
    ROUND(
        (COALESCE(ct.total_transactions, 0) / CAST((JULIANDAY('now') - JULIANDAY(u.date_joined)) / 30 AS REAL)) * 12 * (COALESCE(ct.total_deposit_value_kobo, 0) * 0.001 / 100), 2
    ) AS estimated_clv
FROM users_customuser u
LEFT JOIN CustomerTransactions ct ON u.id = ct.owner_id
ORDER BY estimated_clv DESC;