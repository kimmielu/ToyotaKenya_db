USE toyotakenya_db;

DELIMITER $$

-- ==========================================
-- PROCEDURE: sp_total_sales
-- PURPOSE: Returns total number of sales and total revenue.
-- No input parameters.
-- Application: Manager dashboard / quick reporting.
-- ==========================================
CREATE OR REPLACE PROCEDURE sp_total_sales()
BEGIN
  SELECT 
    COUNT(*) AS total_sales,
    COALESCE(SUM(sale_price), 0) AS total_revenue
  FROM sales;
END$$

DELIMITER ;
-- To call the procedure and see results:
-- CALL sp_total_sales();
CALL sp_total_sales();
-- Expected Output:
-- total_sales | total_revenue