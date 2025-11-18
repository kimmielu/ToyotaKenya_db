-- ==========================================
-- RIGHT JOIN: employees + sales
-- PURPOSE: Show ALL employees (RIGHT table),
--          including employees with no sales.
-- ==========================================
SELECT
    employees.employee_id,
    employees.first_name,
    employees.last_name,
    sales.sale_id,
    sales.sale_date
FROM sales
RIGHT JOIN employees
    ON sales.employee_id = employees.employee_id;
-- Expected Output:
-- employee_id | first_name | last_name | sale_id |      sale_date