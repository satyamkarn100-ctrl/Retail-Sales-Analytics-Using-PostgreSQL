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

-- 3


