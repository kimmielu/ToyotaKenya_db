USE toyotakenya_db;

-- ==========================================
-- INSERT INTO branches
-- ==========================================
INSERT INTO branches (name, location, phone)
VALUES
('Toyota Kenya - Nairobi', 'Central Business District', '+254700000001'),
('Toyota Kenya - Mombasa', 'Mombasa City', '+254700000002'),
('Toyota Kenya - Kisumu',  'Kisumu Central', '+254700000003');

-- ==========================================
-- INSERT INTO employees
-- ==========================================
INSERT INTO employees (branch_id, first_name, last_name, role, email, hire_date)
VALUES
(3, 'Zacharia', 'Ogega', 'Salesperson', 'zach.ogega@toyotakenya.co.ke', '2025-01-14');
(2, 'Fidel', 'Onunga', 'Manager', 'fidel.onunga@toyotakenya.co.ke', '2024-02-02');
(3, 'Myles', 'Otieno', 'Manager', 'myles.otieno@toyotakenya.co.ke', '2023-01-01');
(1, 'Mark', 'William', 'Salesperson', 'mark.william@toyotakenya.co.ke', '2023-06-09');
-- ==========================================
-- INSERT INTO car_models
-- ==========================================
INSERT INTO car_models (make, model, year, engine, base_price)
VALUES
('Toyota', 'Corolla', 2022, '1.8L', 25000.00),
('Toyota', 'Prado',   2021, '2.8L', 65000.00),
('Toyota', 'Yaris',   2020, '1.5L', 18000.00);

-- ==========================================
-- INSERT INTO inventory (NEW UNIQUE VINs)
-- ==========================================
INSERT INTO inventory (model_id, branch_id, vin, color, mileage, status, list_price, date_received)
VALUES
(1, 1, 'VIN3001', 'White', 120,  'available', 26000.00, '2024-10-01'),
(2, 1, 'VIN3002', 'Black', 4500, 'available', 68000.00, '2024-08-15'),
(3, 2, 'VIN3003', 'Silver',200,  'available', 19000.00, '2024-09-20');

-- ==========================================
-- INSERT INTO customers
-- ==========================================
INSERT INTO customers (first_name, last_name, email, phone, address)
VALUES
('Kimberly',  'Amani', 'kim.amani@example.com',  '+254711111111', 'Nairobi'),
('Daniella', 'Lando',  'dani.lando@example.com',  '+254722222222', 'Kiambu'),
('Evans', 'Jowi',  'evans.jowi@example.com',  '+254733333333', 'Mombasa');

-- ==========================================
-- INSERT INTO sales
-- ==========================================
INSERT INTO sales (inventory_id, customer_id, employee_id, sale_price, payment_method)
VALUES
(1, 1, 1, 25500.00, 'Cash'),
(2, 2, 1, 68000.00, 'Card');

-- ==========================================
-- INSERT INTO payments
-- ==========================================
INSERT INTO payments (sale_id, amount, method)
VALUES
(1, 25500.00, 'Cash'),
(2, 50000.00, 'Card'),
(2, 18000.00, 'MPESA');
