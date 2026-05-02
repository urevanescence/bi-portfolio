-- ==============================================
-- WEEK 1 SQL PRACTICE
-- Dataset: Superstore (orders) + custom datasets
-- Tool: PostgreSQL
-- ==============================================

-- -----------------------------------------------
-- DAY 3: WHERE, ORDER BY, LIMIT
-- -----------------------------------------------

-- Q1: Top 5 orders with discount 10-30% by highest profit
SELECT *
FROM orders
WHERE discount BETWEEN 0.1 AND 0.3
ORDER BY profit DESC
LIMIT 5;

-- Q2: Table products with sales between $500-$1000
SELECT product_name, sales
FROM orders
WHERE product_name LIKE '%Table%'
  AND sales BETWEEN 500 AND 1000
ORDER BY sales DESC;

-- Q3: Corporate orders in specific cities, H1 2016
SELECT order_id, city, customer_name, order_date
FROM orders
WHERE city IN ('Henderson', 'Los Angeles', 'Seattle')
  AND segment = 'Corporate'
  AND order_date BETWEEN '2016-01-01' AND '2016-06-30'
ORDER BY order_date DESC;

-- Q4: Loss-making orders excluding West region and Furniture
SELECT *
FROM orders
WHERE profit < 0
  AND region != 'West'
  AND category != 'Furniture';

-- Q5: Profitable non-Sofa non-Technology products, top 10
SELECT product_name, category, profit
FROM orders
WHERE product_name NOT LIKE '%Sofa%'
  AND profit > 100
  AND category != 'Technology'
ORDER BY profit DESC
LIMIT 10;

-- -----------------------------------------------
-- DAY 4: GROUP BY, AGGREGATES, HAVING
-- -----------------------------------------------

-- Q6: Top cities by profit in 2016 (profit > $1000)
SELECT city, SUM(profit) AS total_profit
FROM orders
WHERE order_date BETWEEN '2016-01-01' AND '2016-12-31'
GROUP BY city
HAVING SUM(profit) > 1000
ORDER BY total_profit DESC;

-- Q7: Profit and sales count by region, excluding Furniture
-- Note: practice on custom dataset (store_sales table)
SELECT region, SUM(profit) AS total_profit, COUNT(id) AS sales_count
FROM store_sales
WHERE category != 'Furniture'
GROUP BY region
HAVING SUM(profit) > 1000
ORDER BY total_profit DESC;

-- Q8: Warehouse report - In Stock items by location and type
-- Note: practice on custom dataset (warehouse_stocks table)
SELECT warehouse, item_type,
        SUM(quantity) AS total_items,
        COUNT(*) AS records_count
FROM warehouse_stocks
WHERE status = 'In Stock'
GROUP BY warehouse, item_type
HAVING SUM(quantity) > 40
ORDER BY total_items DESC;

-- Q9: Stores with avg Electronics check above $50,000
-- Note: practice on custom dataset (sales table)
SELECT store_id, AVG(amount) AS avg_check
FROM sales
WHERE category = 'Electronics'
GROUP BY store_id
HAVING AVG(amount) > 50000;

-- -----------------------------------------------
-- DAY 6: Superstore Analysis 
-- -----------------------------------------------

-- Q10: Top 5 categories by revenue
SELECT category, SUM(sales) AS total_sales
FROM orders
GROUP BY category
ORDER BY total_sales DESC
LIMIT 5;

-- Q11: Sales by region
SELECT region, SUM(sales) AS total_sales
FROM orders
GROUP BY region
ORDER BY total_sales DESC;

-- Q12: Unique customers count
SELECT COUNT(DISTINCT customer_name) AS unique_customers
FROM orders;

-- Q13: Top 3 product categories by sales in the West region
SELECT category, SUM(sales) AS total_sales
FROM orders
WHERE region = 'West'
GROUP BY category
ORDER BY total_sales DESC
LIMIT 3;

-- Q14: 5 least profitable products in the Furniture category
SELECT product_name, SUM(profit) AS total_profit
FROM orders
WHERE category = 'Furniture'
GROUP BY product_name
ORDER BY total_profit ASC
LIMIT 5;

-- Q15: Top 3 customers by profit in New York City
SELECT customer_name, SUM(profit) AS total_profit
FROM orders
WHERE city = 'New York City'
GROUP BY customer_name
ORDER BY total_profit DESC
LIMIT 3;

-- Q16: Top 3 products by revenue in Office Supplies (East region)
SELECT product_name, SUM(sales) AS total_sales
FROM orders
WHERE category = 'Office Supplies' AND region = 'East'
GROUP BY product_name
ORDER BY total_sales DESC
LIMIT 3;

-- Q17: Customers with First Class shipping in 2016
SELECT DISTINCT customer_name
FROM orders
WHERE ship_mode = 'First Class' 
  AND order_date BETWEEN '2016-01-01' AND '2016-12-31';