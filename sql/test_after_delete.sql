-- ==========================================
-- Delete the sale. This will fire the AFTER DELETE trigger
-- 'restore_car_status' which sets the car back to 'available'.
-- ==========================================
DELETE FROM sales 
WHERE sale_id = 1;
-- Verify the inventory status is updated

SELECT inventory_id, status FROM inventory WHERE inventory_id = 1;
-- Expected Output:
-- inventory_id = 1, status = 'available'