-- ==========================================
-- LEFT JOIN: customers + sales
-- PURPOSE: Show ALL customers, including those 
--          who have never made a purchase.
-- ==========================================
SELECT 
    customers.first_name,
    customers.last_name,
    sales.sale_id,
    sales.sale_price
FROM customers
LEFT JOIN sales 
    ON customers.customer_id = sales.customer_id;
-- Expected Output:
-- first_name | last_name | sale_id | sale_price