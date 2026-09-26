-- Data Cleaning

-- 1. Customers
SELECT *
FROM olist_customers
LIMIT 10;

DROP TABLE IF EXISTS customers_clean;

CREATE TABLE customers_clean AS
SELECT
    customer_id,
    customer_unique_id,
    customer_zip_code_prefix,
    TRIM(customer_city) AS customer_city,
    UPPER(TRIM(customer_state)) AS customer_state
FROM olist_customers;

SELECT *
FROM customers_clean
LIMIT 10;


-- 2. Sellers
SELECT *
FROM olist_sellers
LIMIT 10;

DROP TABLE IF EXISTS sellers_clean;

CREATE TABLE sellers_clean AS 
SELECT
    seller_id,
    seller_zip_code_prefix,
    UPPER(TRIM(seller_city)) AS seller_city,
    UPPER(TRIM(seller_state)) AS seller_state
FROM olist_sellers;

SELECT *
FROM sellers_clean
LIMIT 10;


-- 3. Orders
SELECT *
FROM olist_orders
LIMIT 10;

-- Check missing dates in delivered orders
SELECT *
FROM olist_orders
WHERE order_status = 'delivered'
    AND (
        order_approved_at IS NULL
        OR order_delivered_carrier_date IS NULL
        OR order_delivered_customer_date IS NULL
    );

DROP TABLE IF EXISTS orders_clean;

CREATE TABLE orders_clean AS
SELECT
    TRIM(order_id) AS order_id,
    TRIM(customer_id) AS customer_id,
    LOWER(TRIM(order_status)) AS order_status,
    order_purchase_timestamp,
    order_approved_at,
    order_delivered_carrier_date,
    order_delivered_customer_date,
    order_estimated_delivery_date
FROM olist_orders;


-- 4. Order Items
SELECT *
FROM olist_order_items
LIMIT 10;

DROP TABLE IF EXISTS order_items_clean;

CREATE TABLE order_items_clean AS
SELECT 
    TRIM(order_id) AS order_id,
    order_item_id,
    TRIM(product_id) AS product_id,
    TRIM(seller_id) AS seller_id,
    shipping_limit_date,
    price,
    freight_value
FROM olist_order_items;


-- 5. Products
SELECT *
FROM olist_products
LIMIT 10;
DROP TABLE IF EXISTS olist_products_clean;

CREATE TABLE olist_products_clean AS
SELECT
    TRIM(product_id) AS product_id,
    LOWER(TRIM(product_category_name)) AS product_category_name,
    product_name_length,
    product_description_length,
    product_photos_qty,
    product_weight_g,
    product_length_cm,
    product_height_cm,
    product_width_cm
FROM olist_products;

-- 6. Order Payments
SELECT *
FROM olist_order_payments
LIMIT 10;

DROP TABLE IF EXISTS order_payments_clean;

CREATE TABLE order_payments_clean AS
SELECT
    TRIM(order_id) AS order_id,
    payment_sequential,
    LOWER(TRIM(payment_type)) AS payment_type,
    payment_installments,
    payment_value
FROM olist_order_payments;

-- 7 Order Reviews
SELECT *
FROM olist_order_reviews
LIMIT 10;

DROP TABLE IF EXISTS order_reviews_clean;

CREATE TABLE order_reviews_clean AS
SELECT
    TRIM(review_id) AS review_id,
    TRIM(order_id) AS order_id,
    review_score,
    TRIM(review_comment_title) AS review_comment_title,
    TRIM(review_comment_message) AS review_comment_message,
    review_creation_date,
    review_answer_timestamp
FROM olist_order_reviews;


-- Olist Geolocation

SELECT *
FROM olist_geolocation
LIMIT 10;
DROP TABLE IF EXISTS geolocation_clean;

CREATE TABLE geolocation_clean AS
SELECT 
    geolocation_zip_code_prefix,
    geolocation_lat,
    geolocation_lng,
    LOWER(TRIM(geolocation_city)) AS geolocation_city,
    UPPER(TRIM(geolocation_state)) AS geolocation_state
FROM olist_geolocation;


DROP TABLE IF EXISTS product_category_name_translation_clean;

CREATE TABLE product_category_name_translation_clean AS
SELECT
    TRIM(product_category_name) AS product_category_name,
    TRIM(product_category_name_english) AS product_category_name_english
FROM product_category_name_translation;


