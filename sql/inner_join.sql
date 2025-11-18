-- ==========================================
-- INNER JOIN: sales + customers
-- PURPOSE: Show all completed sales WITH 
--          matching customer details.
-- ==========================================
SELECT 
    sales.sale_id,
    customers.first_name AS customer_first_name,
    customers.last_name AS customer_last_name,
    sales.sale_price,
    sales.sale_date
FROM sales
INNER JOIN customers 
    ON sales.customer_id = customers.customer_id;
-- Expected Output:
-- sale_id | customer_first_name | customer_last_name | sale_price |      sale_date

