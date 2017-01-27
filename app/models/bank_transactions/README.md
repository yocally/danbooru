Some general design principles:

* Log everything
* Changes are never destructive
* Never delete anything
* No decimals
* For every piece of information, there is one authoritative source
* Coins should not be directly associated with real currency (USD, JPY, etc)

The data models:

* Transaction: A single account transaction, representing both credit and debt. Stores the amount of the transaction, and the purpose of the transaction. A user has many transactions.
* Balance: A single user's account balance. Contains a non-authoritative field for the amount, which is always updated to be the sum of all transaction amounts. A user has one balance.

Attack threats:

* Replay attacks: If a user can submit a request that triggers a credit transaction, then they can simply replay the request to trigger multiple credit transactions for the same event.
* Data modification: If the user has any control over the amount of a transaction, they can arbitrarily give themselves large credit amounts.
* Concurrency attack: When checking to see if a debt transaction is valid (whether the user has a positive balance), a user could submit multiple requests at once and before any of them have finished processing they may see a positive balance and process at the same time, leaving a negative balance.

Security principles:

* For every user, they can only have one transaction in flight at a time.

Monetary principles:

* In general, there is only one source for new coins: the central bank.
* This central bank accrues X new coins on a daily basis.
* Users can perform certain tasks which trigger transactions transferring coins from this central bank to the user's account. Importantly: this transaction will not occur if the bank does not have enough coins. This puts an effective cap on how much the economy can inflate, regardless of the amount of activity.
* Users can purchase temporary account upgrades for X coins. These coins do not disappear: they are represented as a transaction from the user to the central bank, thereby increasing its available supply.
* The cost of an account upgrade is tied to the 