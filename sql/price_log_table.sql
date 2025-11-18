USE toyotakenya_db;

-- ==========================================
-- TABLE: price_log
-- PURPOSE: Stores history of price changes
--          for cars in inventory.
-- ==========================================
CREATE TABLE price_log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    inventory_id INT,
    old_price DECIMAL(12,2),
    new_price DECIMAL(12,2),
    changed_at DATETIME DEFAULT CURRENT_TIMESTAMP
);
