SELECT *
FROM olist_orders
LIMIT 10;

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


SELECT 
	order_status,
	COUNT(*) AS total_orders,
	COUNT(*) FILTER(WHERE order_approved_At IS NULL) AS missing_approved,
	COUNT(*) FILTER(WHERE order_delivered_carrier_date IS NULL) AS missing_carrier,
	COUNT(*) FILTER(WHERE order_delivered_customer_date IS NULL) AS missing_customer_delivery

FROM olist_orders
GROUP BY order_status
ORDER BY total_orders DESC;
