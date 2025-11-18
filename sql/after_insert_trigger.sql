USE toyotakenya_db;

DELIMITER $$

-- ==========================================
-- TRIGGER 1: mark_car_sold
-- PURPOSE: After a new sale is inserted, automatically
--          update the corresponding car in 'inventory'
--          to show it has been sold.
-- ==========================================
CREATE TRIGGER mark_car_sold
AFTER INSERT ON sales
FOR EACH ROW
BEGIN
    UPDATE inventory
    SET status = 'sold'
    WHERE inventory_id = NEW.inventory_id;
END$$

DELIMITER ;
