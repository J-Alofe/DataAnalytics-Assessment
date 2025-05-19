SELECT
    p.plan_id,
    p.owner_id,
    p.type,
    MAX(ssa.transaction_date) AS last_transaction_date,
    CAST((DATE('now') - MAX(ssa.transaction_date)) AS INTEGER) AS inactivity_days
FROM plans_plan p
LEFT JOIN savings_savingsaccount ssa ON p.owner_id = ssa.owner_id
WHERE p.is_regular_savings = 1 OR p.is_a_fund = 1
GROUP BY p.plan_id, p.owner_id, p.type
HAVING MAX(ssa.transaction_date) < DATE('now', '-365 days') OR MAX(ssa.transaction_date) IS NULL;