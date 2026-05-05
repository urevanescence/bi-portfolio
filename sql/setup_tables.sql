-- Setup: split Superstore into normalized tables for JOIN practice

-- Product table
CREATE TABLE products AS
SELECT DISTINCT
    product_id,
    product_name,
    category,
    sub_category
FROM orders;

-- Customer table
CREATE TABLE customers AS
SELECT DISTINCT
    customer_id,
    customer_name,
    segment
FROM orders;