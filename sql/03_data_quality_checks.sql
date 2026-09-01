-- Data Quality Validation

-- 1. CHECK NEGATIVE PRICE
SELECT COUNT(*) AS invalid_price
FROM olist_order_items
WHERE price <0;

--2.CHECK NEGATIVE FREIGHT
SELECT COUNT(*) AS invalid_freight
FROM olist_order_items
WHERE freight_value <0;

--3.CHECK NEGSTIVE PAYMENT VALUE

SELECT COUNT(*) AS invalid_payment_value
FROM olist_order_payments
WHERE payment_value<0;

-- 4 CHECK INVALID PAYMENT INSTALLMENTS
SELECT COUNT(*) AS invalid_installments
FROM olist_order_payments
WHERE payment_installments <=0

-- 5. CHECK INVALID REVIEW SCORE
SELECT COUNT(*) AS invalid_review_score
FROM olist_order_reviews
WHERE review_score < 1
   OR review_score > 5;

-- 6. CHECK INVALID DELIVERY DATE
SELECT COUNT(*) AS invalid_delivery_date
FROM olist_orders
WHERE order_delivered_customer_date < order_purchase_timestamp;

-- 7.CHECK INVALID ESTIMATED DELIVERY DATE
SELECT COUNT(*) AS invalid_estimated_date
FROM olist_orders
WHERE order_estimated_delivery_date < order_purchase_timestamp;

-- 8. CHECK INVALID SHIPPING LIMIT DATE
SELECT COUNT(*) AS invalid_shipping_date
FROM olist_order_items i
JOIN olist_orders o
ON i.order_id = o.order_id
WHERE i.shipping_limit_date < o.order_purchase_timestamp;

-- 9. CHECK INVALID LATITUDE
SELECT COUNT(*) AS invalid_latitude
FROM olist_geolocation
WHERE geolocation_lat < -90
   OR geolocation_lat > 90;

-- 10. CHECK INVALID LONGITUDE
SELECT COUNT(*) AS invalid_longitude
FROM olist_geolocation
WHERE geolocation_lng < -180
   OR geolocation_lng > 180;

