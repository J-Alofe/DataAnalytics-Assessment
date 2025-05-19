SELECT
    u.name,
    ROUND(SUM(ssa.confirmed_amount) / 100, 2) AS total_deposit_naira
FROM savings_savingsaccount ssa
JOIN users_customuser u ON ssa.owner_id = u.id
WHERE ssa.transaction_date >= DATE('now', '-6 months')
GROUP BY u.name
ORDER BY total_deposit_naira DESC
LIMIT 50;