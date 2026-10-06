CREATE DATABASE IF NOT EXISTS customer_db;
USE customer_db;
 
 
-- ============================================================
-- SECTION 1: TABLE CREATION (DDL)
-- ============================================================
 
CREATE TABLE IF NOT EXISTS Customer (
    Customer_ID    INT PRIMARY KEY AUTO_INCREMENT,
    Customer_Name  VARCHAR(100) NOT NULL,
    Email          VARCHAR(150) NOT NULL UNIQUE,
    Phone          VARCHAR(15),
    City           VARCHAR(100),
    Address        VARCHAR(255),
    Registered_On  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);
 
 
-- ============================================================
-- SECTION 2: SAMPLE DATA (DML)
-- ============================================================
 
INSERT INTO Customer (Customer_Name, Email, Phone, City, Address) VALUES
('Arun',  'arun@mail.com',  '9876543210', 'Chennai',    '12 Anna Nagar, Chennai'),
('Priya', 'priya@mail.com', '9876543211', 'Coimbatore', '45 RS Puram, Coimbatore'),
('Karan', 'karan@mail.com', '9876543212', 'Bengaluru',  '7 MG Road, Bengaluru'),
('Divya', 'divya@mail.com', '9876543213', 'Madurai',    '21 KK Nagar, Madurai'),
('Rahul', 'rahul@mail.com', '9876543214', 'Hyderabad',  '9 Banjara Hills, Hyderabad');
 
 
-- ============================================================
-- SECTION 3: BASIC QUERIES
-- ============================================================
 

SELECT * FROM Customer;
 

SELECT * FROM Customer WHERE Customer_Name = 'Arun';
 

SELECT * FROM Customer WHERE City = 'Chennai';
 
UPDATE Customer
SET Phone = '9999999999'
WHERE Customer_ID = 1;
 
-- DELETE FROM Customer WHERE Customer_ID = 5;
 
SELECT COUNT(*) AS Total_Customers FROM Customer;
 

SELECT Customer_Name, Registered_On
FROM Customer
ORDER BY Registered_On DESC;
 
-- ============================================================
-- SECTION 4: BUSINESS REPORTS
-- ============================================================
 
-- ------------------------------------------------------------
-- Report 1: Customer Count by City
-- Shows how many customers are registered in each city,
-- highest first — useful for spotting your strongest markets.
-- ------------------------------------------------------------
SELECT
    City,
    COUNT(*) AS Total_Customers
FROM Customer
GROUP BY City
ORDER BY Total_Customers DESC;
 
 
-- ------------------------------------------------------------
-- Report 2: New Customer Registrations by Month
-- Groups customers by the month they registered, so you can
-- track growth/signup trends over time.
-- ------------------------------------------------------------
SELECT
    DATE_FORMAT(Registered_On, '%Y-%m') AS Registration_Month,
    COUNT(*) AS New_Customers
FROM Customer
GROUP BY DATE_FORMAT(Registered_On, '%Y-%m')
ORDER BY Registration_Month;
 
 
-- ------------------------------------------------------------
-- Report 3: Incomplete Customer Profiles
-- Flags customers missing a phone number or address, so these
-- records can be followed up on and completed.
-- ------------------------------------------------------------
SELECT
    Customer_ID,
    Customer_Name,
    Email,
    CASE WHEN Phone IS NULL OR Phone = '' THEN 'Missing' ELSE 'OK' END AS Phone_Status,
    CASE WHEN Address IS NULL OR Address = '' THEN 'Missing' ELSE 'OK' END AS Address_Status
FROM Customer
WHERE Phone IS NULL OR Phone = ''
   OR Address IS NULL OR Address = '';
 
 
-- ------------------------------------------------------------
-- Report 4: Recently Registered Customers (Last 30 Days)
-- Lists customers who signed up most recently — useful for
-- welcome emails or onboarding follow-ups.
-- ------------------------------------------------------------
SELECT
    Customer_ID,
    Customer_Name,
    Email,
    City,
    Registered_On
FROM Customer
WHERE Registered_On >= (CURRENT_DATE - INTERVAL 30 DAY)
ORDER BY Registered_On DESC;