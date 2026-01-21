/*
Table: Orders

+-----------------+----------+
| Column Name     | Type     |
+-----------------+----------+
| order_number    | int      |
| customer_number | int      |
+-----------------+----------+
order_number is the primary key (column with unique values) for this table.
This table contains information about the order ID and the customer ID.
 

Write a solution to find the customer_number for the customer who has placed the largest number of orders.

The test cases are generated so that exactly one customer will have placed more orders than any other customer.

The result format is in the following example.

 

Example 1:

Input: 
Orders table:
+--------------+-----------------+
| order_number | customer_number |
+--------------+-----------------+
| 1            | 1               |
| 2            | 2               |
| 3            | 3               |
| 4            | 3               |
+--------------+-----------------+
Output: 
+-----------------+
| customer_number |
+-----------------+
| 3               |
+-----------------+
Explanation: 
The customer with number 3 has two orders, which is greater than either customer 1 or 2 because each of them only has one order. 
So the result is customer_number 3.
 
 */


--  ANS

SELECT customer_number
FROM Orders
GROUP BY customer_number
ORDER BY COUNT(*) DESC
LIMIT 1;


-- "Explanation"
/*
I will explain this step by step using your exact example, so you understand what GROUP BY does and what LIMIT 1 does, not just the syntax.

1. Original table (raw data)
order_number | customer_number
-------------+----------------
1            | 1
2            | 2
3            | 3
4            | 3


Each row = one order.

2. Why GROUP BY customer_number is needed

The question is:

Which customer placed the largest number of orders?

To answer this, we must count orders per customer.

What GROUP BY does conceptually

GROUP BY customer_number:

Collects all rows with the same customer_number

Treats them as one group

After grouping:

customer_number	rows in group
1	(1)
2	(2)
3	(3, 4)

Now apply COUNT(*):

SELECT customer_number, COUNT(*)
FROM Orders
GROUP BY customer_number;


Result:

customer_number | COUNT(*)
----------------+---------
1               | 1
2               | 1
3               | 2


Without GROUP BY, SQL cannot count per customer—it would only count total rows.

3. Why ORDER BY COUNT(*) DESC is used

We want the largest number of orders:

customer_number | COUNT(*)
----------------+---------
3               | 2   <-- highest
1               | 1
2               | 1


So we sort in descending order:

ORDER BY COUNT(*) DESC

4. What LIMIT 1 does here

After sorting, the first row is the answer.

LIMIT 1


Means:

“Give me only the top row.”

Final result:

customer_number
----------------
3

Without LIMIT 1

You would get:

3
1
2


But the problem requires only one customer.

5. Full query with explanation
SELECT customer_number
FROM Orders
GROUP BY customer_number      -- count per customer
ORDER BY COUNT(*) DESC        -- highest count first
LIMIT 1;                      -- pick the best one

6. How to know when to use GROUP BY (simple rule)

Use GROUP BY when the question says:

“per customer”

“per user”

“per category”

“number of … for each …”

“maximum / minimum / average per …”

This problem says:

Customer placing the largest number of orders

That phrase forces grouping.

One-line intuition (remember this)

GROUP BY creates buckets, COUNT counts items in each bucket, ORDER BY ranks the buckets, LIMIT picks the winner.

If you want, I can also explain this visually or with another example.*/