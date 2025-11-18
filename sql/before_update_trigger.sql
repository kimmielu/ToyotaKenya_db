USE toyotakenya_db;

DELIMITER $$

-- ==========================================
-- TRIGGER 2: log_price_change_before
-- PURPOSE: Before updating the price of a car in inventory,
--          record the old price and the new incoming price
--          in the price_log table.
-- TRIGGER TYPE: BEFORE UPDATE
-- ==========================================
CREATE TRIGGER log_price_change_before
BEFORE UPDATE ON inventory
FOR EACH ROW
BEGIN
    -- Only log the update if the price is actually changing
    IF OLD.list_price <> NEW.list_price THEN
        INSERT INTO price_log (inventory_id, old_price, new_price)
        VALUES (OLD.inventory_id, OLD.list_price, NEW.list_price);
    END IF;
END$$

DELIMITER ;
