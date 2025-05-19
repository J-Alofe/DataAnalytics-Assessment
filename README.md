Explanation:

CustomerTransactions CTE:
Calculates the total_transactions and the total_deposit_value_kobo for each customer from the savings_savingsaccount table.
Groups the results by owner_id.

Final SELECT Statement:
Selects the customer's id (aliased as customer_id) and name from the users_customuser table.
Calculates the tenure_months by finding the difference in days between the current date and the date_joined (using JULIANDAY for accurate date differences) and then dividing by approximately 30.

Uses COALESCE to handle cases where a customer has no transactions, setting total_transactions and total_deposit_value_kobo to 0 in such scenarios.
Calculates the estimated_clv using the provided formula:
CLV = (total_transactions / tenure) * 12 * avg_profit_per_transaction

Where avg_profit_per_transaction is 0.1% of the total_deposit_value_kobo divided by the total_transactions. We simplify this by using the total_deposit_value_kobo multiplied by 0.001/100.
Performs a LEFT JOIN with the CustomerTransactions CTE on u.id = ct.owner_id to include all customers.
Orders the results in descending order based on the estimated_clv.
