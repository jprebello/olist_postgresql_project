CREATE TABLE customers (
    customer_id VARCHAR(50) PRIMARY KEY,
    customer_unique_id VARCHAR(50) NOT NULL,
    customer_city VARCHAR(50) NOT NULL,
    customer_state CHAR(2) NOT NULL
);

CREATE TABLE orders (
    order_id VARCHAR(50) PRIMARY KEY,
    customer_id VARCHAR(50) NOT NULL,
    order_status VARCHAR(20) NOT NULL,
    order_purchase_timestamp DATE NOT NULL,
    order_approved_at DATE,
    order_delivered_customer_date DATE,
    order_estimated_delivery_date DATE,

    FOREIGN KEY (customer_id)
    REFERENCES customers(customer_id)
);

CREATE TABLE order_payments (
    order_id VARCHAR(50),
    payment_sequential INTEGER,
    payment_type VARCHAR(20) NOT NULL,
    payment_installments INTEGER NOT NULL,
    payment_value DECIMAL NOT NULL,

    PRIMARY KEY(order_id, payment_sequential),

    FOREIGN KEY (order_id)
    REFERENCES orders(order_id)
);

CREATE TABLE order_reviews (
    review_id VARCHAR(50),
    order_id VARCHAR(50),
    review_score INTEGER NOT NULL,
    review_creation_date DATE NOT NULL,

    PRIMARY KEY(review_id, order_id),

    FOREIGN KEY (order_id)
    REFERENCES orders(order_id)
);

CREATE TABLE products (
    product_id VARCHAR(50) PRIMARY KEY,
    product_category_name VARCHAR(50)
);

CREATE TABLE sellers (
    seller_id VARCHAR(50) PRIMARY KEY,
    seller_city VARCHAR(50) NOT NULL,
    seller_state CHAR(2) NOT NULL
);

CREATE TABLE order_items (
    order_id VARCHAR(50),
    order_item_id INTEGER,
    product_id VARCHAR(50) NOT NULL,
    seller_id VARCHAR(50) NOT NULL,
    price DECIMAL NOT NULL,
    freight_value DECIMAL NOT NULL,

    PRIMARY KEY(order_id, order_item_id),

    FOREIGN KEY (order_id)
    REFERENCES orders(order_id),

    FOREIGN KEY (product_id)
    REFERENCES products(product_id),

    FOREIGN KEY (seller_id)
    REFERENCES sellers(seller_id)
);
