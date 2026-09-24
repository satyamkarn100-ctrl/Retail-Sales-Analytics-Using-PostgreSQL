-- DATA CLEANING

-- 1 CUSTOMERS CLEANING
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


--2 SELLERS CLEANING
SELECT *
FROM olist_sellers
LIMIT 10;

DROP TABLE IF EXISTS sellers_clean;

CREATE TABLE sellers_clean AS 
SELECT
	seller_id,
	seller_zip_code_prefix,
	UPPER(TRIM(seller_city))  AS seller_city,
	UPPER(TRIM(seller_state)) AS seller_state
FROM olist_sellers;


SELECT *
FROM public.sellers_clean
LIMIT 10;

-- 3 Order status

SELECT *
FROM olist_orders
LIMIT 10;

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


SELECT *
FROM olist_order_items
LIMIT 10;


CREATE TABLE order_items_clean AS
SELECT 
	TRIM(order_id) AS order_id,
	order_item_id,
	TRIM(product_id) AS product_id,
	TRIM(seller_id) AS seller_id,
	shipping_limit_date,price,freight_value
FROM olist_order_items;


SELECT * 
FROM olist_products
LIMIT 10;


DROP TABLE IF EXISTS olist_products_clean;

CREATE TABLE olist_products_clean AS
SELECT
    TRIM(product_id) AS product_id,
    LOWER(TRIM(product_category_name)) AS product_category_name,
    product_name_lenght,
    product_description_lenght,
    product_photos_qty,
    product_weight_g,
    product_length_cm,
    product_height_cm,
    product_width_cm
FROM olist_products;


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
