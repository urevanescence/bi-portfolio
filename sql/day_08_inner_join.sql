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