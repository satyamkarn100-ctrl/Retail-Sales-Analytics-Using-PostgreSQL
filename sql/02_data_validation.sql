--Check row counts
SELECT 'customers' AS table_name, COUNT(*) AS rows FROM olist_customers
UNION ALL
SELECT 'products', COUNT(*) FROM olist_products
UNION ALL
SELECT 'sellers', COUNT(*) FROM olist_sellers
UNION ALL
SELECT 'category_translation', COUNT(*) FROM product_category_name_translation
UNION ALL
SELECT 'geolocation', COUNT(*) FROM olist_geolocation
UNION ALL
SELECT 'orders', COUNT(*) FROM olist_orders
UNION ALL
SELECT 'payments', COUNT(*) FROM olist_order_payments
UNION ALL
SELECT 'order_items', COUNT(*) FROM olist_order_items
UNION ALL
SELECT 'reviews', COUNT(*) FROM olist_order_reviews;


-- Checking Duplicate 
SELECT customer_id, COUNT(*) AS count
FROM olist_customers
GROUP BY customer_id
HAVING COUNT(*)>1;

SELECT product_id,COUNT(*) AS count
FROM olist_products
GROUP BY product_id
HAVING COUNT(*)>1;

SELECT seller_id,COUNT(*) AS count
from olist_sellers
GROUP BY seller_id
HAVING COUNT(*)>1;

SELECT order_id,COUNT(*) AS count
FROM olist_orders
GROUP BY order_id
HAVING COUNT(*)>1;

SELECT product_category_name,COUNT(*) AS count
FROM product_cateogory_name_translation
GROUP BY product_category_name
HAVING COUNT(*)>1;

SELECT order_id,payment_sequential,COUNT(*) as count
FROM olist_order_payments
GROUP BY order_id,payment_sequential
HAVING COUNT(*)>1;
