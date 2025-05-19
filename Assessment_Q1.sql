WITH MonthlyTransactions AS (
    SELECT
        ssa.owner_id,
        EXTRACT(YEAR FROM transaction_date) AS transaction_year,
        EXTRACT(MONTH FROM transaction_date) AS transaction_month,
        COUNT(*) AS monthly_transaction_count
    FROM savings_savingsaccount ssa
    WHERE ssa.transaction_date >= DATE('now', '-1 year')
    GROUP BY ssa.owner_id, EXTRACT(YEAR FROM transaction_date), EXTRACT(MONTH FROM transaction_date)
),
CustomerMonthlyAverages AS (
    SELECT
        mt.owner_id,
        AVG(mt.monthly_transaction_count) AS avg_monthly_transactions
    FROM MonthlyTransactions mt
    GROUP BY mt.owner_id
)
SELECT
    CASE
        WHEN cma.avg_monthly_transactions > 10 THEN 'High Frequency'
        WHEN cma.avg_monthly_transactions BETWEEN 3 AND 10 THEN 'Medium Frequency'
        ELSE 'Low Frequency'
    END AS frequency_category,
    COUNT(DISTINCT u.id) AS customer_count,
    ROUND(AVG(cma.avg_monthly_transactions), 2) AS avg_transactions_per_month
FROM CustomerMonthlyAverages cma
JOIN users_customuser u ON cma.owner_id = u.id
GROUP BY frequency_category
ORDER BY
    CASE frequency_category
        WHEN 'High Frequency' THEN 1
        WHEN 'Medium Frequency' THEN 2
        ELSE 3
    END;