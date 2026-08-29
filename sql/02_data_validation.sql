-- DATA VALIDATION

-- 1. ROW COUNT VALIDATION

SELECT 'customers' AS table_name, COUNT(*) AS rows
FROM olist_customers

UNION ALL

SELECT 'products', COUNT(*)
FROM olist_products

UNION ALL

SELECT 'sellers', COUNT(*)
FROM olist_sellers

UNION ALL

SELECT 'category_translation', COUNT(*)
FROM product_category_name_translation

UNION ALL

SELECT 'geolocation', COUNT(*)
FROM olist_geolocation

UNION ALL

SELECT 'orders', COUNT(*)
FROM olist_orders

UNION ALL

SELECT 'payments', COUNT(*)
FROM olist_order_payments

UNION ALL

SELECT 'order_items', COUNT(*)
FROM olist_order_items

UNION ALL

SELECT 'reviews', COUNT(*)
FROM olist_order_reviews;

-- 2.DUPLICATE / PRIMARY KEY VALIDATION

-- Customers
SELECT customer_id, COUNT(*) AS count
FROM olist_customers
GROUP BY customer_id
HAVING COUNT(*) > 1;

-- Products
SELECT product_id, COUNT(*) AS count
FROM olist_products
GROUP BY product_id
HAVING COUNT(*) > 1;

-- Sellers
SELECT seller_id, COUNT(*) AS count
FROM olist_sellers
GROUP BY seller_id
HAVING COUNT(*) > 1;

-- Category Translation
SELECT product_category_name, COUNT(*) AS count
FROM product_category_name_translation
GROUP BY product_category_name
HAVING COUNT(*) > 1;

-- Orders
SELECT order_id, COUNT(*) AS count
FROM olist_orders
GROUP BY order_id
HAVING COUNT(*) > 1;

-- Order Payments
-- Composite Key: (order_id, payment_sequential)
SELECT order_id, payment_sequential, COUNT(*) AS count
FROM olist_order_payments
GROUP BY order_id, payment_sequential
HAVING COUNT(*) > 1;

-- Order Items
-- Composite Key: (order_id, order_item_id)
SELECT order_id, order_item_id, COUNT(*) AS count
FROM olist_order_items
GROUP BY order_id, order_item_id
HAVING COUNT(*) > 1;

-- Reviews
SELECT review_id, COUNT(*) AS count
FROM olist_order_reviews
GROUP BY review_id
HAVING COUNT(*) > 1;

-- 3. NULL VALUE VALIDATION

-- Customers
SELECT COUNT(*) AS null_customer_id
FROM olist_customers
WHERE customer_id IS NULL;

-- Products
SELECT COUNT(*) AS null_product_id
FROM olist_products
WHERE product_id IS NULL;

-- Sellers
SELECT COUNT(*) AS null_seller_id
FROM olist_sellers
WHERE seller_id IS NULL;

-- Category Translation
SELECT COUNT(*) AS null_category_name
FROM product_category_name_translation
WHERE product_category_name IS NULL;

-- Orders
SELECT COUNT(*) AS null_order_id
FROM olist_orders
WHERE order_id IS NULL;

-- Payments
SELECT COUNT(*) AS null_payment_order_id
FROM olist_order_payments
WHERE order_id IS NULL;

-- Order Items
SELECT COUNT(*) AS null_order_id
FROM olist_order_items
WHERE order_id IS NULL;

SELECT COUNT(*) AS null_product_id
FROM olist_order_items
WHERE product_id IS NULL;

SELECT COUNT(*) AS null_seller_id
FROM olist_order_items
WHERE seller_id IS NULL;

-- Reviews
SELECT COUNT(*) AS null_review_id
FROM olist_order_reviews
WHERE review_id IS NULL;

SELECT COUNT(*) AS null_review_order_id
FROM olist_order_reviews
WHERE order_id IS NULL;

-- Geolocation
SELECT COUNT(*) AS null_geolocation_zip
FROM olist_geolocation
WHERE geolocation_zip_code_prefix IS NULL;
