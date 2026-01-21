

-- best way to find max but here if you use "is" instead "=" throw error.

select customer_number from Orders where (order_number = (select max(order_number) from Orders))

-- but above approach not fit 


