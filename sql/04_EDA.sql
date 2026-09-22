-- 04_EDA.SQL
-- Exploratory Data Analysis


-- ============================================================
-- 1. ORDERS (olist_orders)
-- ============================================================

-- Preview sample orders
-- Similar to: df.head(10)

SELECT *
FROM olist_orders
LIMIT 10;


-- Check overall missing values in order data
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

-- Check duplicate order IDs
SELECT
	order_id,
	COUNT(*) AS duplicate_count
FROM  olist_orders
GROUP BY order_id
HAVING COUNT(*)>1;


-- Analyze missing delivery and approval dates by order status
-- Helps understand whether missing values are expected
-- based on the order lifecycle.

SELECT *
FROM olist_orders
LIMIT 10;

SELECT
    order_status,
    COUNT(*) AS total_orders,
	COUNT(*) FILTER(WHERE order_id IS NULL) AS missing_order_id,
	COUNT(*) FILTER(WHERE customer_id IS NULL) AS missing_customer_id,
	COUNT(*) FILTER(WHERE order_status IS NULL) AS missing_order_status,
	COUNT(*) FILTER(WHERE order_purchase_timestamp IS NULL) AS mising_order_purchase_timestamp,
    COUNT(*) FILTER (WHERE order_approved_at IS NULL) AS missing_approved,
    COUNT(*) FILTER (WHERE order_delivered_carrier_date IS NULL) AS missing_carrier,
    COUNT(*) FILTER (WHERE order_delivered_customer_date IS NULL) AS missing_customer_delivery,
	COUNT(*) FILTER(WHERE order_estimated_delivery_Date IS NULL) AS missing_estimated_delivery_date
	
FROM olist_orders
GROUP BY order_status
ORDER BY total_orders DESC;


-- Check the overall order date range
-- Similar to:
-- df['order_purchase_timestamp'].min()
-- df['order_purchase_timestamp'].max()

SELECT
    MIN(order_purchase_timestamp) AS first_order_date,
    MAX(order_purchase_timestamp) AS last_order_date
FROM olist_orders;


-- Analyze order status
-- Similar to: df['order_status'].value_counts()

SELECT
    order_status,
    COUNT(*) AS order_count
FROM olist_orders
GROUP BY order_status
ORDER BY order_count DESC;


-- ============================================================
-- 2. ORDER ITEMS (olist_order_items)
-- ============================================================

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
    ROUND(AVG(price), 2) AS avg_price,
    SUM(price) AS total_price
FROM olist_order_items;


-- Analyze freight values

SELECT
    MIN(freight_value) AS min_freight,
    MAX(freight_value) AS max_freight,
    ROUND(AVG(freight_value), 2) AS avg_freight,
    SUM(freight_value) AS total_freight
FROM olist_order_items;


-- Count items in each order — shown as a distribution, not a raw per-order dump
-- (raw per-order list is ~99k rows, not usable as an EDA summary)
-- also tells you whether market-basket analysis makes sense on this dataset
-- (olist orders are mostly single-item, this query proves it either way)

SELECT
    item_count,
    COUNT(*) AS num_orders
FROM (
    SELECT order_id, COUNT(*) AS item_count
    FROM olist_order_items
    GROUP BY order_id
) sub
GROUP BY item_count
ORDER BY item_count;


-- ============================================================
-- 3. PRODUCTS (olist_products)
-- ============================================================

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

-- Check duplicate product IDs
SELECT
    product_id,
    COUNT(*) AS duplicate_count
FROM olist_products
GROUP BY product_id
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
    ROUND(AVG(product_name_length), 1) AS avg_name_length
FROM olist_products;


-- Analyze product weight and dimensions
-- Similar to: df[['product_weight_g','product_length_cm','product_height_cm','product_width_cm']].mean()

SELECT
    ROUND(AVG(product_weight_g), 1) AS avg_weight_g,
    ROUND(AVG(product_length_cm), 1) AS avg_length_cm,
    ROUND(AVG(product_height_cm), 1) AS avg_height_cm,
    ROUND(AVG(product_width_cm), 1) AS avg_width_cm
FROM olist_products;


-- ============================================================
-- 4. CUSTOMERS (olist_customers)
-- ============================================================

-- Preview sample customers
SELECT *
FROM olist_customers
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

-- Analyze customers by state
-- Similar to: df['customer_state'].value_counts()

SELECT
    customer_state,
    COUNT(*) AS customer_count
FROM olist_customers
GROUP BY customer_state
ORDER BY customer_count DESC;


-- ============================================================
-- 5. SELLERS (olist_sellers)
-- ============================================================

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

-- Check duplicate seller IDs
SELECT
	seller_id,
	COUNT(*) AS duplicate_count
FROM olist_sellers
GROUP BY seller_id
HAVING COUNT(*)>1;

-- Analyze sellers by city
SELECT
	seller_city,
	COUNT(*) AS seller_count
FROM olist_sellers
GROUP BY seller_city
ORDER BY seller_count DESC
LIMIT 20;

-- Analyze sellers by state
SELECT
    seller_state,
    COUNT(*) AS seller_count
FROM olist_sellers
GROUP BY seller_state
ORDER BY seller_count DESC;


-- ============================================================
-- 6. PRODUCT CATEGORY TRANSLATION (product_category_name_translation)
-- ============================================================

-- Preview sample category translations
SELECT *
FROM product_category_name_translation
LIMIT 10;

-- Check missing values in category translation
SELECT
    COUNT(*) FILTER (WHERE product_category_name IS NULL) AS missing_product_cat_name,
    COUNT(*) FILTER (WHERE product_category_name_english IS NULL) AS missing_product_category_name_english
FROM product_category_name_translation;

-- Check duplicate category translations
SELECT
	product_category_name,
	COUNT(*) AS duplicate_count
FROM product_category_name_translation
GROUP BY product_category_name
HAVING COUNT(*)>1;

SELECT
	product_category_name_english,
	COUNT(*) AS duplicate_count
FROM product_category_name_translation
GROUP BY product_category_name_english
HAVING COUNT(*)>1;


-- ============================================================
-- 7. PAYMENTS (olist_order_payments)
-- ============================================================

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

-- Analyze payment value
-- Similar to basic numeric aggregation / describe()

SELECT
    MIN(payment_value) AS min_payment,
    MAX(payment_value) AS max_payment,
    ROUND(AVG(payment_value), 2) AS avg_payment,
    SUM(payment_value) AS total_payment
FROM olist_order_payments;

-- Analyze payment installments
SELECT
    MIN(payment_installments) AS min_installments,
    MAX(payment_installments) AS max_installments,
    ROUND(AVG(payment_installments), 1) AS avg_installments
FROM olist_order_payments;

-- Analyze payment value by payment type
-- Similar to: df.groupby('payment_type')['payment_value'].agg(['count','sum','mean'])

SELECT
    payment_type,
    COUNT(*) AS payment_count,
    SUM(payment_value) AS total_payment_value,
    ROUND(AVG(payment_value), 2) AS avg_payment_value
FROM olist_order_payments
GROUP BY payment_type
ORDER BY total_payment_value DESC;


-- ============================================================
-- 8. ORDER REVIEWS (olist_order_reviews)
-- ============================================================

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
-- (this one matters — review_id has no PK constraint in the schema, unlike
-- the other duplicate checks above which are already PK-enforced)
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
    ROUND(AVG(review_score), 2) AS avg_review_score
FROM olist_order_reviews;


-- ============================================================
-- 9. GEOLOCATION (olist_geolocation)
-- ============================================================

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
    ROUND(AVG(geolocation_lat), 4) AS avg_latitude
FROM olist_geolocation;

-- Analyze longitude range
SELECT
    MIN(geolocation_lng) AS min_longitude,
    MAX(geolocation_lng) AS max_longitude,
    ROUND(AVG(geolocation_lng), 4) AS avg_longitude
FROM olist_geolocation;

-- Check for out-of-bounds coordinates
-- Brazil's real lat/lng range is roughly lat -34 to 6, lng -74 to -33 —
-- olist's geolocation table is known to have some bad points outside this box
SELECT
    COUNT(*) AS outlier_coords
FROM olist_geolocation
WHERE geolocation_lat NOT BETWEEN -34 AND 6
   OR geolocation_lng NOT BETWEEN -74 AND -33;

-- Analyze geolocation records by state
SELECT
    geolocation_state,
    COUNT(*) AS location_count
FROM olist_geolocation
GROUP BY geolocation_state
ORDER BY location_count DESC;
