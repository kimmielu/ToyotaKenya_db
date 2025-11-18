SELECT inventory_id, status FROM inventory WHERE inventory_id = 1;

INSERT INTO sales (inventory_id, customer_id, employee_id, sale_price, payment_method)
VALUES (1, 1, 1, 25000.00, 'Cash');

SELECT inventory_id, status FROM inventory WHERE inventory_id = 1;
-- Expected Output:
-- Before Insert: inventory_id = 1, status = 'available'
-- After Insert:  inventory_id = 1, status = 'sold'