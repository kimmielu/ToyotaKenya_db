-- ==========================================
-- TEST: Update the price to trigger BEFORE UPDATE.
-- The trigger should insert a new row in price_log
-- BEFORE the new price overwrites the old value.
-- ==========================================
UPDATE inventory
SET list_price = 35000.00
WHERE inventory_id = 1;
-- Verify the price_log entry

SELECT * FROM price_log
WHERE inventory_id = 1;
-- Expected Output:
-- log_id | inventory_id | old_price | new_price | changed_at
--   1    |      1       | 30000.00  | 35000.00  | <timestamp>
-- Note: The actual timestamp will vary based on when the test is run.