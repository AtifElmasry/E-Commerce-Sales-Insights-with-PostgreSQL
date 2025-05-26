-- E-Commerce Database Schema

CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    signup_date DATE
);

CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    category VARCHAR(50),
    price NUMERIC(10, 2)
);

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id),
    order_date DATE,
    total_amount NUMERIC(10, 2)
);

CREATE TABLE order_items (
    item_id SERIAL PRIMARY KEY,
    order_id INT REFERENCES orders(order_id),
    product_id INT REFERENCES products(product_id),
    quantity INT,
    price_each NUMERIC(10, 2)
);

CREATE TABLE ads (
    ad_id SERIAL PRIMARY KEY,
    campaign_name VARCHAR(100),
    spend NUMERIC(10, 2),
    start_date DATE,
    end_date DATE
);

CREATE TABLE ad_clicks (
    click_id SERIAL PRIMARY KEY,
    ad_id INT REFERENCES ads(ad_id),
    customer_id INT REFERENCES customers(customer_id),
    click_date DATE
);
