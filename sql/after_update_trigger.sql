DELIMITER $$

-- ==========================================
-- TRIGGER 2: log_price_change
-- PURPOSE: After a car's price is updated in the 
--          inventory table, record the old and new
--          prices in the price_log audit table.
-- ==========================================
CREATE TRIGGER log_price_change
AFTER UPDATE ON inventory
FOR EACH ROW
BEGIN
    -- Only insert a log if the price actually changed
    IF OLD.list_price <> NEW.list_price THEN
        INSERT INTO price_log (inventory_id, old_price, new_price)
        VALUES (OLD.inventory_id, OLD.list_price, NEW.list_price);
    END IF;
END$$

DELIMITER ;
