Explanation:

SELECT Clause:
Selects the customer's name from the users_customuser table.
Calculates the sum of confirmed_amount (which is in kobo) from the savings_savingsaccount table, divides it by 100 to convert to Naira, and rounds the result to two decimal places. This is aliased as total_deposit_naira.

FROM and JOIN Clauses:
Joins savings_savingsaccount (aliased as ssa) with users_customuser (aliased as u) using the owner_id to link transactions to customers.
WHERE Clause:
Filters the transactions to include only those within the last 6 months using ssa.transaction_date >= DATE('now', '-6 months').

GROUP BY Clause:
Groups the results by customer name to aggregate their deposit amounts.

ORDER BY Clause:
Orders the results in descending order based on total_deposit_naira to get the highest deposit amounts first.

LIMIT Clause:
Restricts the output to the top 50 customers.
