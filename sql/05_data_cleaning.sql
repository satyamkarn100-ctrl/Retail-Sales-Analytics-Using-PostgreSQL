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


SELECT order_id,order_status,order_purchase_timestamp,
	order_approved_at,order_delivered_carrier_date,order_delivered_customer_date,
	order_estimated_delivery_date
FROM olist_orders
WHERE order_status = 'delivered'
	AND order_approved_at IS NULL;

DROP TABLE IF EXISTS orders_clean;
