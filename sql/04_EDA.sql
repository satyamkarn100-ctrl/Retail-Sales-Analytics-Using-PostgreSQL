-- 04_EDA.SQL
-- Exploratory Data Analysis


-- 1. Preview sample orders
-- Similar to: df.head(10)

SELECT *
FROM olist_orders
LIMIT 10;


-- 2. Check overall missing values in order data
-- Similar to: df.isna().sum()

SELECT
    COUNT(*) FILTER (WHERE order_id IS NULL) AS missing_order_id,
    COUNT(*) FILTER (WHERE customer_id IS NULL) AS missing_customer_id,
    COUNT(*) FILTER (WHERE order_status IS NULL) AS missing_order_status,
    COUNT(*) FILTER (WHERE order_purchase_timestamp IS NULL) AS missing_order_purchase_timestamp,
    COUNT(*) FILTER (WHERE order_approved_at IS NULL) AS missing_order_approved_at,
    COUNT(*) FILTER (WHERE order_delivered_carrier_date IS NULL) AS missing_order_delivered_carrier_date,
    COUNT(*) FILTER (WHERE order_delivered_customer_date IS NULL) AS missing_order_delivered_customer_date,
    COUNT(*) FILTER (WHERE order_estimated_delivery_date IS NULL) AS missing_order_estimated_delivery_date
FROM olist_orders;


-- 3. Analyze missing delivery and approval dates by order status
-- Helps understand whether missing values are expected
-- based on the order lifecycle.

SELECT
    order_status,
    COUNT(*) AS total_orders,
    COUNT(*) FILTER (WHERE order_approved_at IS NULL) AS missing_approved,
    COUNT(*) FILTER (WHERE order_delivered_carrier_date IS NULL) AS missing_carrier,
    COUNT(*) FILTER (WHERE order_delivered_customer_date IS NULL) AS missing_customer_delivery
FROM olist_orders
GROUP BY order_status
ORDER BY total_orders DESC;


-- 4. Check the overall order date range
-- Similar to:
-- df['order_purchase_timestamp'].min()
-- df['order_purchase_timestamp'].max()

SELECT
    MIN(order_purchase_timestamp) AS first_order_date,
    MAX(order_purchase_timestamp) AS last_order_date
FROM olist_orders;


-- 5. Analyze payment value
-- Similar to basic numeric aggregation / describe()

SELECT
    MIN(payment_value) AS min_payment,
    MAX(payment_value) AS max_payment,
    AVG(payment_value) AS avg_payment,
    SUM(payment_value) AS total_payment
FROM olist_order_payments;


-- 6. Analyze payment methods
-- Similar to: df['payment_type'].value_counts()

SELECT
    payment_type,
    COUNT(*) AS total_payments
FROM olist_order_payments
GROUP BY payment_type
ORDER BY total_payments DESC;


-- 7. Analyze order items

-- Preview sample order items
-- Similar to: df.head(10)

SELECT *
FROM olist_order_items
LIMIT 10;


-- Check missing values in order items
-- Similar to: df.isna().sum()

SELECT
    COUNT(*) FILTER (WHERE order_id IS NULL) AS missing_order_id,
    COUNT(*) FILTER (WHERE order_item_id IS NULL) AS missing_order_item_id,
    COUNT(*) FILTER (WHERE product_id IS NULL) AS missing_product_id,
    COUNT(*) FILTER (WHERE seller_id IS NULL) AS missing_seller_id,
    COUNT(*) FILTER (WHERE shipping_limit_date IS NULL) AS missing_shipping_limit_date,
    COUNT(*) FILTER (WHERE price IS NULL) AS missing_price,
    COUNT(*) FILTER (WHERE freight_value IS NULL) AS missing_freight_value
FROM olist_order_items;


-- Check exact/full-row duplicates
-- Similar to: df.duplicated()

SELECT
    order_id,
    order_item_id,
    product_id,
    seller_id,
    shipping_limit_date,
    price,
    freight_value,
    COUNT(*) AS duplicate_count
FROM olist_order_items
GROUP BY
    order_id,
    order_item_id,
    product_id,
    seller_id,
    shipping_limit_date,
    price,
    freight_value
HAVING COUNT(*) > 1;


-- Analyze price values

SELECT
    MIN(price) AS min_price,
    MAX(price) AS max_price,
    AVG(price) AS avg_price,
    SUM(price) AS total_price
FROM olist_order_items;


-- Analyze freight values

SELECT
    MIN(freight_value) AS min_freight,
    MAX(freight_value) AS max_freight,
    AVG(freight_value) AS avg_freight,
    SUM(freight_value) AS total_freight
FROM olist_order_items;


-- Count items in each order
-- Similar to grouping by order_id and counting rows

SELECT
    order_id,
    COUNT(*) AS item_count
FROM olist_order_items
GROUP BY order_id
ORDER BY item_count DESC;


-- 8. Analyze products

-- Preview sample products
-- Similar to: df.head(10)

SELECT *
FROM olist_products
LIMIT 10;


-- Check missing values in product data

SELECT
    COUNT(*) FILTER (WHERE product_id IS NULL) AS missing_product_id,
    COUNT(*) FILTER (WHERE product_category_name IS NULL) AS missing_product_category_name,
    COUNT(*) FILTER (WHERE product_name_length IS NULL) AS missing_product_name_length,
    COUNT(*) FILTER (WHERE product_description_length IS NULL) AS missing_product_description_length,
    COUNT(*) FILTER (WHERE product_photos_qty IS NULL) AS missing_product_photos_qty,
    COUNT(*) FILTER (WHERE product_weight_g IS NULL) AS missing_product_weight_g,
    COUNT(*) FILTER (WHERE product_length_cm IS NULL) AS missing_product_length_cm,
    COUNT(*) FILTER (WHERE product_height_cm IS NULL) AS missing_product_height_cm,
    COUNT(*) FILTER (WHERE product_width_cm IS NULL) AS missing_product_width_cm
FROM olist_products;


-- Check exact duplicate product rows

SELECT
    product_id,
    product_category_name,
    product_name_length,
    product_description_length,
    product_photos_qty,
    product_weight_g,
    product_length_cm,
    product_height_cm,
    product_width_cm,
    COUNT(*) AS duplicate_count
FROM olist_products
GROUP BY
    product_id,
    product_category_name,
    product_name_length,
    product_description_length,
    product_photos_qty,
    product_weight_g,
    product_length_cm,
    product_height_cm,
    product_width_cm
HAVING COUNT(*) > 1;


-- Analyze product categories
-- Similar to: df['product_category_name'].value_counts()

SELECT
    product_category_name,
    COUNT(*) AS product_count
FROM olist_products
GROUP BY product_category_name
ORDER BY product_count DESC;


-- Analyze product name length
-- Numeric column, so MIN/MAX/AVG can be used

SELECT
    MIN(product_name_length) AS min_name_length,
    MAX(product_name_length) AS max_name_length,
    AVG(product_name_length) AS avg_name_length
FROM olist_products;



-- 9 Analyze customers
-- Preview sample customers
SELECT *
from olist_customers
LIMIT 10;

SELECT
    COUNT(*) FILTER (WHERE customer_id IS NULL) AS missing_customer_id,
    COUNT(*) FILTER (WHERE customer_unique_id IS NULL) AS missing_customer_unique_id,
    COUNT(*) FILTER (WHERE customer_zip_code_prefix IS NULL) AS missing_customer_zip_code,
    COUNT(*) FILTER (WHERE customer_city IS NULL) AS missing_customer_city,
    COUNT(*) FILTER (WHERE customer_state IS NULL) AS missing_customer_state
FROM olist_customers;

-- Check duplicate customer IDs
SELECT
    customer_id,
    COUNT(*) AS duplicate_count
FROM olist_customers
GROUP BY customer_id
HAVING COUNT(*) > 1;

-- 10. Analyze sellers

-- Preview sample sellers
SELECT *
FROM olist_sellers
LIMIT 10;

-- Check missing values in seller data
SELECT
    COUNT(*) FILTER (WHERE seller_id IS NULL) AS missing_seller_id,
    COUNT(*) FILTER (WHERE seller_zip_code_prefix IS NULL) AS missing_seller_zip_code,
    COUNT(*) FILTER (WHERE seller_city IS NULL) AS missing_seller_city,
    COUNT(*) FILTER (WHERE seller_state IS NULL) AS missing_seller_state
FROM olist_sellers;

-- Analyze sellers by state
SELECT
    seller_state,
    COUNT(*) AS seller_count
FROM olist_sellers
GROUP BY seller_state
ORDER BY seller_count DESC;

-- 11. Analyze product category translation

-- Preview sample category translations
SELECT *
FROM product_category_name_translation;
LIMIT 10;

-- Check missing values in category translation
SELECT
    COUNT(*) FILTER (WHERE product_category_name IS NULL) AS missing_product_cat_name,
    COUNT(*) FILTER (WHERE product_category_name_english IS NULL) AS missing_product_category_name_english
FROM product_category_name_translation;

-- Analyze translated product categories
SELECT 
	product_category_name_english,
	COUNT(*) AS category_count
FROM product_category_name_translation
GROUP BY product_category_name_english
ORDER BY category_count DESC;


-- 12. Analyze order status
-- Similar to: df['order_status'].value_counts()

SELECT
    order_status,
    COUNT(*) AS order_count
FROM olist_orders
GROUP BY order_status
ORDER BY order_count DESC;


-- 13. Analyze payment data

-- Preview sample payments
SELECT *
FROM olist_order_payments
LIMIT 10;

-- Check missing values in payment data
SELECT
    COUNT(*) FILTER (WHERE order_id IS NULL) AS missing_order_id,
    COUNT(*) FILTER (WHERE payment_sequential IS NULL) AS missing_payment_sequential,
    COUNT(*) FILTER (WHERE payment_type IS NULL) AS missing_payment_type,
    COUNT(*) FILTER (WHERE payment_installments IS NULL) AS missing_payment_installments,
    COUNT(*) FILTER (WHERE payment_value IS NULL) AS missing_payment_value
FROM olist_order_payments;

-- Check duplicate payment records
SELECT
    order_id,
    payment_sequential,
    COUNT(*) AS duplicate_count
FROM olist_order_payments
GROUP BY
    order_id,
    payment_sequential
HAVING COUNT(*) > 1;

-- Analyze payment installments
SELECT
    MIN(payment_installments) AS min_installments,
    MAX(payment_installments) AS max_installments,
    AVG(payment_installments) AS avg_installments
FROM olist_order_payments;

-- Analyze payment value by payment type
SELECT
    payment_type,
    COUNT(*) AS payment_count,
    SUM(payment_value) AS total_payment_value,
    AVG(payment_value) AS avg_payment_value
FROM olist_order_payments
GROUP BY payment_type
ORDER BY total_payment_value DESC;


-- 14. Analyze order reviews

-- Preview sample reviews
SELECT *
FROM olist_order_reviews
LIMIT 10;

-- Check missing values in review data
SELECT
    COUNT(*) FILTER (WHERE review_id IS NULL) AS missing_review_id,
    COUNT(*) FILTER (WHERE order_id IS NULL) AS missing_order_id,
    COUNT(*) FILTER (WHERE review_score IS NULL) AS missing_review_score,
    COUNT(*) FILTER (WHERE review_comment_title IS NULL) AS missing_review_title,
    COUNT(*) FILTER (WHERE review_comment_message IS NULL) AS missing_review_message,
    COUNT(*) FILTER (WHERE review_creation_date IS NULL) AS missing_creation_date,
    COUNT(*) FILTER (WHERE review_answer_timestamp IS NULL) AS missing_answer_timestamp
FROM olist_order_reviews;

-- Check duplicate review IDs
SELECT
    review_id,
    COUNT(*) AS duplicate_count
FROM olist_order_reviews
GROUP BY review_id
HAVING COUNT(*) > 1
ORDER BY duplicate_count DESC;

-- Analyze review score distribution
-- Similar to: df['review_score'].value_counts()

SELECT
    review_score,
    COUNT(*) AS review_count
FROM olist_order_reviews
GROUP BY review_score
ORDER BY review_score DESC;

-- Analyze average review score
SELECT
    MIN(review_score) AS min_review_score,
    MAX(review_score) AS max_review_score,
    AVG(review_score) AS avg_review_score
FROM olist_order_reviews;


-- 15. Analyze geolocation data

-- Preview sample geolocation records
SELECT *
FROM olist_geolocation
LIMIT 10;

-- Check missing values in geolocation data
SELECT
    COUNT(*) FILTER (WHERE geolocation_zip_code_prefix IS NULL) AS missing_zip_code,
    COUNT(*) FILTER (WHERE geolocation_lat IS NULL) AS missing_latitude,
    COUNT(*) FILTER (WHERE geolocation_lng IS NULL) AS missing_longitude,
    COUNT(*) FILTER (WHERE geolocation_city IS NULL) AS missing_city,
    COUNT(*) FILTER (WHERE geolocation_state IS NULL) AS missing_state
FROM olist_geolocation;

-- Analyze latitude range
SELECT
    MIN(geolocation_lat) AS min_latitude,
    MAX(geolocation_lat) AS max_latitude,
    AVG(geolocation_lat) AS avg_latitude
FROM olist_geolocation;

-- Analyze longitude range
SELECT
    MIN(geolocation_lng) AS min_longitude,
    MAX(geolocation_lng) AS max_longitude,
    AVG(geolocation_lng) AS avg_longitude
FROM olist_geolocation;

-- Analyze geolocation records by state
SELECT
    geolocation_state,
    COUNT(*) AS location_count
FROM olist_geolocation
GROUP BY geolocation_state
ORDER BY location_count DESC;






