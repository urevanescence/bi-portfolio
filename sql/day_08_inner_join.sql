-- STEP 1: Create the structure for the 'returns' table
CREATE TABLE returns (
    returned TEXT,
    order_id TEXT
);

-- STEP 2: Populate the table with sample return data
INSERT INTO returns (returned, order_id) VALUES 
('Yes', 'CA-2016-152156'),
('Yes', 'CA-2017-138688'),
('Yes', 'US-2015-108966'),
('Yes', 'CA-2014-115812'),
('Yes', 'CA-2017-114412');

-- STEP 3: Practice INNER JOIN and calculate profitability
-- We join 'orders' and 'returns' using 'order_id' as the common key
SELECT 
    o.order_id, 
    o.product_name, 
    o.sales,
    o.profit,
    ROUND((o.profit / o.sales), 2) AS profitability
FROM orders AS o
INNER JOIN returns AS r 
  ON o.order_id = r.order_id;

SELECT 
    o.order_id, 
    o.product_name, 
    o.profit, 
    ROUND((o.profit / o.sales), 2) AS profitability
FROM orders AS o
INNER JOIN returns AS r 
  ON o.order_id = r.order_id
WHERE o.profit < 0;

-- PRACTICE AND REVIEWING MATERIAL AFTER A WEEK BREAK

-- Task 1: Furniture tax report (10% tax)
SELECT
    p.product_id,
    o.order_id,
    p.product_name,
    p.category, 
    ROUND (o.sales, 2) AS sales,
    ROUND((o.sales * 0.1), 2) AS tax
FROM orders AS o
INNER JOIN products AS p
  ON o.product_id = p.product_id
WHERE p.category = 'Furniture'
ORDER BY o.sales DESC;

-- Task 2: Triple Join - Total sales by customer and category
SELECT
    c.customer_name,
    p.category,
    ROUND(SUM(o.sales), 2) AS total_sales
FROM orders AS o
INNER JOIN products AS p
  ON o.product_id = p.product_id
INNER JOIN customers AS c
  ON o.customer_id = c.customer_id
GROUP BY c.customer_name, p.category
ORDER BY total_sales DESC;

-- Task 3: High discounts (>20%) in Office Supplies
SELECT
    o.order_id,
    p.product_id,
    p.product_name,
    ROUND(o.discount, 2) AS discount,
    ROUND(o.sales, 2) AS sales
FROM orders AS o
INNER JOIN products AS p
  ON o.product_id = p.product_id
WHERE p.category = 'Office Supplies' AND o.discount > 0.2
ORDER BY discount DESC;

-- Task 4: Corporate Phones profitability report
SELECT
    c.customer_id,
    c.customer_name,
    p.product_id,
    p.product_name,
    ROUND(SUM(o.profit), 2) AS total_profit
FROM orders AS o
INNER JOIN products AS p
  ON o.product_id = p.product_id
INNER JOIN customers AS c
  ON o.customer_id = c.customer_id
WHERE c.segment = 'Corporate' AND p.product_name ILIKE '%Phone%'
GROUP BY
    c.customer_id,
    c.customer_name,
    p.product_id,
    p.product_name
ORDER BY total_profit DESC;