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

-- 3. Analyze missing delivery/approval dates by order status
-- Helps determine whether missing values are expected
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


-- 5. Analyze payment value distribution
-- Similar to basic numeric aggregation / describe()
SELECT
    MIN(payment_value) AS min_payment,
    MAX(payment_value) AS max_payment,
    AVG(payment_value) AS avg_payment,
    SUM(payment_value) AS total_payment
FROM olist_order_payments;


-- 6.Analyze payment methods
-- Similar to: df['payment_type'].value_counts()
SELECT
    payment_type,
    COUNT(*) AS total_payments
FROM olist_order_payments
GROUP BY payment_type
ORDER BY total_payments DESC;


-- 7 Analyze order Items
-- This is Similar to df.head(10)
SELECT * 
FROM olist_order_items
LIMIT 10;


SELECT 
	COUNT(*) FILTER(WHERE order_id IS NULL) AS missing_orders_id,
	COUNT(*) FILTER(WHERE order_item_id IS NULL) AS missing_order_item_id,
	COUNT(*) FILTER(WHERE product_id IS NULL) AS missing_product_id,
	COUNT(*) FILTER(WHERE seller_id IS NULL) AS missing_seller_id,
	COUNT(*) FILTER(WHERE shipping_limit_date IS NULL) AS missing_shipping_limit_date,
	COUNT(*) FILTER(WHERE price IS NULL ) AS missing_price,
	COUNT(*) FILTER(WHERE freight_value IS NULL ) AS missing_freight_value
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
	order_id,order_item_id,product_id,seller_id,
	shipping_limit_date,
	price,
	freight_value

HAVING COUNT(*)>1;
