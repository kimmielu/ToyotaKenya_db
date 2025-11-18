USE toyotakenya_db;

DELIMITER $$

-- ==========================================
-- PROCEDURE: sp_create_sale
-- PURPOSE: Create a sale safely with parameters:
--   p_inventory_id   INT    (which car)
--   p_customer_id    INT    (who buys)
--   p_employee_id    INT    (who sells)
--   p_sale_price     DEC(12,2)
--   p_payment_method VARCHAR(50)
--
-- Behavior:
--  - Checks inventory exists and is 'available'
--  - Starts a transaction
--  - Inserts sale
--  - Inserts payment (single payment equal to sale_price)
--  - Updates inventory status -> 'sold'
--  - Commits; on any error, rolls back and SIGNALs an error
-- Application: Used by point-of-sale systems or APIs to ensure consistency.
-- ==========================================
CREATE OR REPLACE PROCEDURE sp_create_sale(
  IN p_inventory_id INT,
  IN p_customer_id INT,
  IN p_employee_id INT,
  IN p_sale_price DECIMAL(12,2),
  IN p_payment_method VARCHAR(50)
)
BEGIN
  DECLARE v_status VARCHAR(20);
  DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
    -- On any SQL error, rollback and re-raise a generic error
    ROLLBACK;
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error creating sale - transaction rolled back';
  END;

  -- Start transaction
  START TRANSACTION;

  -- Check inventory status (lock row for update)
  SELECT status INTO v_status
  FROM inventory
  WHERE inventory_id = p_inventory_id
  FOR UPDATE;

  IF v_status IS NULL THEN
    -- inventory not found
    ROLLBACK;
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Inventory not found';
  ELSEIF v_status <> 'available' THEN
    -- not available for sale
    ROLLBACK;
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Inventory not available for sale';
  ELSE
    -- Insert sale
    INSERT INTO sales (inventory_id, customer_id, employee_id, sale_price, payment_method)
    VALUES (p_inventory_id, p_customer_id, p_employee_id, p_sale_price, p_payment_method);

    -- Capture last sale id
    SET @lastSaleId = LAST_INSERT_ID();

    -- Insert payment record (single payment)
    INSERT INTO payments (sale_id, amount, payment_date, method)
    VALUES (@lastSaleId, p_sale_price, NOW(), p_payment_method);

    -- Update inventory status
    UPDATE inventory
    SET status = 'sold'
    WHERE inventory_id = p_inventory_id;

    -- Commit transaction
    COMMIT;
  END IF;
END$$

DELIMITER ;
-- Example Call:
-- CALL sp_create_sale(1, 1, 1, 25000.00, 'Cash');
CALL sp_create_sale(3, 3, 2, 19000.00, 'Card');

--verify results
SELECT * FROM sales WHERE sale_id = LAST_INSERT_ID();
SELECT * FROM payments WHERE sale_id = LAST_INSERT_ID();
SELECT inventory_id, status FROM inventory WHERE inventory_id = 3;
