USE toyotakenya_db;

DELIMITER $$

-- ==========================================
-- TRIGGER 3: restore_car_status
-- PURPOSE: After a sale is deleted from the 'sales' table,
--          automatically update the corresponding car in the
--          'inventory' table to set its status back to 'available'.
-- TRIGGER TYPE: AFTER DELETE
-- NOTES:
--   - Uses OLD.inventory_id because the row is deleted.
--   - Ensures inventory remains accurate after cancellations.
-- ==========================================
CREATE TRIGGER restore_car_status
AFTER DELETE ON sales
FOR EACH ROW
BEGIN
    UPDATE inventory
    SET status = 'available'
    WHERE inventory_id = OLD.inventory_id;
END$$

DELIMITER ;
