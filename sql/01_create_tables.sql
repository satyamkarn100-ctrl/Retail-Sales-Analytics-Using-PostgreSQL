CREATE TABLE olist_customers(
    customer_id VARCHAR(50),
    customer_unique_id VARCHAR(50),
    customer_zip_code_prefix VARCHAR(10),
    customer_city VARCHAR(50),
    customer_state VARCHAR(50),
    PRIMARY KEY(customer_id)
);

CREATE TABLE olist_products(
    product_id VARCHAR(50),
    product_category_name VARCHAR(50),
    product_name_length INT,
    product_description_length INT,
    product_photos_qty INT,
    product_weight_g INT,
    product_length_cm INT,
    product_height_cm INT,
    product_width_cm INT,
    PRIMARY KEY(product_id)
);

CREATE TABLE olist_sellers(
    seller_id VARCHAR(50),
    seller_zip_code_prefix VARCHAR(10),
    seller_city VARCHAR(50),
    seller_state VARCHAR(50),
    PRIMARY KEY(seller_id)
);

CREATE TABLE product_category_name_translation(
    product_category_name VARCHAR(50),
    product_category_name_english VARCHAR(50),
    PRIMARY KEY(product_category_name)
);

CREATE TABLE olist_orders(
    order_id VARCHAR(60),
    customer_id VARCHAR(50) REFERENCES olist_customers(customer_id),
    order_status VARCHAR(50),
    order_purchase_timestamp TIMESTAMP,
    order_approved_at TIMESTAMP,
    order_delivered_carrier_date TIMESTAMP,
    order_delivered_customer_date TIMESTAMP,
    order_estimated_delivery_date TIMESTAMP,
    PRIMARY KEY(order_id)
);

CREATE TABLE olist_order_payments(
    order_id VARCHAR(60) REFERENCES olist_orders(order_id),
    payment_sequential INT,
    payment_type VARCHAR(50),
    payment_installments INT,
    payment_value NUMERIC(10,2),
    PRIMARY KEY(order_id, payment_sequential)
);

CREATE TABLE olist_order_items(
    order_id VARCHAR(60) REFERENCES olist_orders(order_id),
    order_item_id INT,
    product_id VARCHAR(50) REFERENCES olist_products(product_id),
    seller_id VARCHAR(50) REFERENCES olist_sellers(seller_id),
    shipping_limit_date TIMESTAMP,
    price NUMERIC(10,2),
    freight_value NUMERIC(10,2),
    PRIMARY KEY(order_id, order_item_id)
);

CREATE TABLE olist_order_reviews(
    review_id VARCHAR(60),
    order_id VARCHAR(60) REFERENCES olist_orders(order_id),
    review_score INT,
    review_comment_title TEXT,
    review_comment_message TEXT,
    review_creation_date TIMESTAMP,
    review_answer_timestamp TIMESTAMP
);

CREATE TABLE olist_geolocation(
    geolocation_zip_code_prefix VARCHAR(10),
    geolocation_lat NUMERIC(10,7),
    geolocation_lng NUMERIC(10,7),
    geolocation_city VARCHAR(100),
    geolocation_state VARCHAR(20)
);
