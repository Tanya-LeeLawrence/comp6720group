-- Query 1: Customers with more than 3 orders in last 30 days
SELECT customer_id, COUNT(*) AS order_count
FROM orders
WHERE order_date >= NOW() - INTERVAL 30 DAY
GROUP BY customer_id
HAVING COUNT(*) > 3;

-- Query 2: Total revenue per product category
SELECT p.category_id, SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.category_id;

-- Query 3: Customers with unpaid/failed orders
SELECT DISTINCT c.customer_id, c.name
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
LEFT JOIN payments p ON o.order_id = p.order_id
WHERE p.payment_status IN ('failed', 'pending') OR p.payment_status IS NULL;

-- Query 4: Top 5 best-selling products
SELECT oi.product_id, SUM(oi.quantity) AS total_sold
FROM order_items oi
GROUP BY oi.product_id
ORDER BY total_sold DESC
LIMIT 5;

-- Query 5: Orders with total > $500
SELECT o.order_id, SUM(oi.quantity * oi.unit_price) AS total_amount
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY o.order_id
HAVING total_amount > 500;
