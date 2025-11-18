UPDATE inventory
SET list_price = 30000
WHERE inventory_id = 1;
-- Verify that the price_log has recorded the change

SELECT * FROM price_log WHERE inventory_id = 1;
-- Expected Output:
-- A new entry in price_log with old_price = previous price, new_price = 30000
-- Example:
-- log_id | inventory_id | old_price | new_price | changed_at
