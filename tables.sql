USE toyotakenya_db;

-- ==========================================
-- TABLE 1: branches
-- Stores all Toyota Kenya branches.
-- ==========================================
CREATE TABLE branches (
    branch_id INT AUTO_INCREMENT PRIMARY KEY,       -- Unique branch ID
    name VARCHAR(100) NOT NULL,                     -- Branch name
    location VARCHAR(150),                          -- City or town
    phone VARCHAR(30)                               -- Phone contact
);

-- ==========================================
-- TABLE 2: employees
-- Stores employees who work at Toyota Kenya branches.
-- ==========================================
CREATE TABLE employees (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,     -- Unique employee ID
    branch_id INT,                                  -- FK to branches
    first_name VARCHAR(50) NOT NULL,                -- Employee first name
    last_name VARCHAR(50) NOT NULL,                 -- Employee last name
    role VARCHAR(50),                               -- Job title
    email VARCHAR(100),                             -- Contact email
    hire_date DATE,                                 -- Date hired

    FOREIGN KEY (branch_id) REFERENCES branches(branch_id)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);

-- ==========================================
-- TABLE 3: car_models
-- Stores vehicle model master data.
-- ==========================================
CREATE TABLE car_models (
    model_id INT AUTO_INCREMENT PRIMARY KEY,        -- Unique model ID
    make VARCHAR(50) NOT NULL,                      -- Manufacturer (Toyota)
    model VARCHAR(50) NOT NULL,                     -- Model name
    year YEAR,                                      -- Year of manufacture
    engine VARCHAR(50),                             -- Engine type
    base_price DECIMAL(12,2)                        -- Base model price
);

-- ==========================================
-- TABLE 4: inventory
-- Stores individual cars in stock.
-- ==========================================
CREATE TABLE inventory (
    inventory_id INT AUTO_INCREMENT PRIMARY KEY,    -- Unique car ID
    model_id INT NOT NULL,                          -- FK to car_models
    branch_id INT NOT NULL,                         -- FK to branches
    vin VARCHAR(50) UNIQUE,                         -- Vehicle ID Number (unique)
    color VARCHAR(30),                              -- Vehicle color
    mileage INT DEFAULT 0,                          -- Odometer reading
    status ENUM('available','reserved','sold','in_service') DEFAULT 'available',
    list_price DECIMAL(12,2),                       -- Price the branch sells at
    date_received DATE,                             -- Date car entered inventory

    FOREIGN KEY (model_id) REFERENCES car_models(model_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    FOREIGN KEY (branch_id) REFERENCES branches(branch_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- ==========================================
-- TABLE 5: customers
-- Stores customer information.
-- ==========================================
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,     -- Unique customer ID
    first_name VARCHAR(50) NOT NULL,                -- First name
    last_name VARCHAR(50) NOT NULL,                 -- Last name
    email VARCHAR(120),                             -- Email address
    phone VARCHAR(30),                              -- Contact number
    address TEXT                                    -- Customer address
);

-- ==========================================
-- TABLE 6: sales
-- Stores all completed car sales.
-- ==========================================
CREATE TABLE sales (
    sale_id INT AUTO_INCREMENT PRIMARY KEY,         -- Unique sale ID
    inventory_id INT NOT NULL,                      -- Car sold
    customer_id INT NOT NULL,                       -- Buyer
    employee_id INT NOT NULL,                       -- Salesperson
    sale_date DATETIME DEFAULT CURRENT_TIMESTAMP,   -- Date of sale
    sale_price DECIMAL(12,2) NOT NULL,              -- Final price
    payment_method VARCHAR(50),                     -- Payment method

    FOREIGN KEY (inventory_id) REFERENCES inventory(inventory_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- ==========================================
-- TABLE 7: payments
-- Stores payments for each sale.
-- ==========================================
CREATE TABLE payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,      -- Unique payment ID
    sale_id INT NOT NULL,                           -- FK to sales
    amount DECIMAL(12,2) NOT NULL,                  -- Amount paid
    payment_date DATETIME DEFAULT CURRENT_TIMESTAMP,-- Date paid
    method VARCHAR(50),                             -- Cash, Card, MPESA, etc.

    FOREIGN KEY (sale_id) REFERENCES sales(sale_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
