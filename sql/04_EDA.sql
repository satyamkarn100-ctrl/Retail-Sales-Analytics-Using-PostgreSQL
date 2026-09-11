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



-- Analyze customers
-- Preview sample customers
SELECT *
from olist_customers
LIMIT 10;

SELECT 
	COUNT(*) FILTER(WHERE customer_id IS NULL) AS missing_customer_id,
	COUNT(*) FILTER(WHERE customer_unique_id IS NULL) AS missing_customer_unique_id,
	COUNT(*) FILTER(WHERE customer_zip_code_prefix IS NULL) AS missing_customer_city,
	COUNT(*) FILTER(WHERE customer_city IS NULL) AS missing_customer_city,
	COUNT(*) FILTER(WHERE customer_state IS NULL) AS missing_customer_state
FROM olist_customers;
	
