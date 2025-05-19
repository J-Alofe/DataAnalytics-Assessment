SELECT Clause:
Selects the plan_id, owner_id, and type from the plans_plan table.
Uses MAX(ssa.transaction_date) to find the most recent transaction date for each account.
Calculates the number of inactivity days by subtracting the last_transaction_date from the current date (DATE('now')) and casting the result to an integer.

FROM and LEFT JOIN Clauses:
Starts with the plans_plan table (aliased as p) to get all savings and investment plans.
Performs a LEFT JOIN with the savings_savingsaccount table (aliased as ssa) on p.owner_id = ssa.owner_id to include transaction history. A LEFT JOIN ensures that all plans are included even if they have no transactions.

WHERE Clause:
Filters for plans where is_regular_savings is 1 (savings account) or is_a_fund is 1 (investment plan).

GROUP BY Clause:
Groups the results by plan_id, owner_id, and type to find the last transaction date for each unique account.

HAVING Clause:
Filters the grouped results to include only those where the MAX(ssa.transaction_date) is older than 365 days from the current date (DATE('now', '-365 days')) or where there are no transactions at all (MAX(ssa.transaction_date) IS NULL).
