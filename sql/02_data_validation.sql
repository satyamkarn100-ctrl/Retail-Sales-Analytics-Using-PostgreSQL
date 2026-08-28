--Check row counts
SELECT 'customers' AS table_name, COUNT(*) AS rows FROM olist_customers
UNION ALL
SELECT 'products', COUNT(*) FROM olist_products
UNION ALL
SELECT 'sellers', COUNT(*) FROM olist_sellers
UNION ALL
SELECT 'category_translation', COUNT(*) FROM product_category_name_translation
UNION ALL
SELECT 'geolocation', COUNT(*) FROM olist_geolocation
UNION ALL
SELECT 'orders', COUNT(*) FROM olist_orders
UNION ALL
SELECT 'payments', COUNT(*) FROM olist_order_payments
UNION ALL
SELECT 'order_items', COUNT(*) FROM olist_order_items
UNION ALL
SELECT 'reviews', COUNT(*) FROM olist_order_reviews;
