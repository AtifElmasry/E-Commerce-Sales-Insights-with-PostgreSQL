
-- Drop tables if they exist
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS customers;

-- Customers Table
CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    full_name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    gender VARCHAR(10),
    birthdate DATE,
    country VARCHAR(50),
    city VARCHAR(50),
    signup_date DATE,
    referral_source VARCHAR(50),
    is_active BOOLEAN DEFAULT TRUE
);

-- Products Table
CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    category VARCHAR(50),
    price NUMERIC(10, 2)
);

-- Orders Table
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id),
    order_date DATE,
    total_amount NUMERIC(10, 2)
);

-- Order Items Table
CREATE TABLE order_items (
    item_id SERIAL PRIMARY KEY,
    order_id INT REFERENCES orders(order_id),
    product_id INT REFERENCES products(product_id),
    quantity INT,
    price_each NUMERIC(10, 2)
);

INSERT INTO products (name, category, price) VALUES ('Wireless Mouse', 'Electronics', 25.99);
INSERT INTO products (name, category, price) VALUES ('Bluetooth Speaker', 'Electronics', 45.0);
INSERT INTO products (name, category, price) VALUES ('Water Bottle', 'Home & Kitchen', 10.5);
INSERT INTO products (name, category, price) VALUES ('Notebook', 'Office Supplies', 5.99);
INSERT INTO products (name, category, price) VALUES ('Yoga Mat', 'Fitness', 20.0);
INSERT INTO customers (full_name, email, gender, birthdate, country, city, signup_date, referral_source, is_active)
VALUES ('Allison Hill', 'jillrhodes@miller.com', 'Other', '1980-03-25', 'Germany', 'New Jamesside', '2024-04-15', 'Organic', FALSE);
INSERT INTO orders (customer_id, order_date, total_amount)
VALUES (1, '2024-10-03', 135.0);
INSERT INTO order_items (order_id, product_id, quantity, price_each)
VALUES ((SELECT MAX(order_id) FROM orders), 2, 3, 45.0);
INSERT INTO customers (full_name, email, gender, birthdate, country, city, signup_date, referral_source, is_active)
VALUES ('Donald Booth', 'jpeterson@bernard.com', 'Male', '1970-09-17', 'Canada', 'Davisstad', '2024-09-05', 'Organic', FALSE);
INSERT INTO orders (customer_id, order_date, total_amount)
VALUES (2, '2024-12-16', 25.99);
INSERT INTO order_items (order_id, product_id, quantity, price_each)
VALUES ((SELECT MAX(order_id) FROM orders), 1, 1, 25.99);
INSERT INTO customers (full_name, email, gender, birthdate, country, city, signup_date, referral_source, is_active)
VALUES ('Monica Herrera', 'arnoldmaria@hotmail.com', 'Male', '1989-01-03', 'Canada', 'Lake Chad', '2024-10-20', 'Friend Referral', TRUE);
INSERT INTO orders (customer_id, order_date, total_amount)
VALUES (3, '2025-01-16', 40.0);
INSERT INTO order_items (order_id, product_id, quantity, price_each)
VALUES ((SELECT MAX(order_id) FROM orders), 5, 2, 20.0);
INSERT INTO orders (customer_id, order_date, total_amount)
VALUES (3, '2025-02-09', 17.97);
INSERT INTO order_items (order_id, product_id, quantity, price_each)
VALUES ((SELECT MAX(order_id) FROM orders), 4, 3, 5.99);
INSERT INTO orders (customer_id, order_date, total_amount)
VALUES (3, '2024-11-19', 37.97);
INSERT INTO order_items (order_id, product_id, quantity, price_each)
VALUES ((SELECT MAX(order_id) FROM orders), 1, 1, 25.99);
INSERT INTO order_items (order_id, product_id, quantity, price_each)
VALUES ((SELECT MAX(order_id) FROM orders), 4, 2, 5.99);
INSERT INTO customers (full_name, email, gender, birthdate, country, city, signup_date, referral_source, is_active)
VALUES ('Sharon James', 'francisco53@hotmail.com', 'Female', '1982-07-26', 'Netherlands', 'New Cynthiaside', '2024-12-12', 'Google Ads', FALSE);
INSERT INTO orders (customer_id, order_date, total_amount)
VALUES (4, '2025-01-28', 5.99);
INSERT INTO order_items (order_id, product_id, quantity, price_each)
VALUES ((SELECT MAX(order_id) FROM orders), 4, 1, 5.99);
INSERT INTO customers (full_name, email, gender, birthdate, country, city, signup_date, referral_source, is_active)
VALUES ('James Mayo', 'megan03@trujillo.com', 'Female', '1968-11-26', 'USA', 'New Nancy', '2024-01-25', 'Friend Referral', FALSE);
INSERT INTO orders (customer_id, order_date, total_amount)
VALUES (5, '2024-07-08', 147.92);
INSERT INTO order_items (order_id, product_id, quantity, price_each)
VALUES ((SELECT MAX(order_id) FROM orders), 4, 3, 5.99);
INSERT INTO order_items (order_id, product_id, quantity, price_each)
VALUES ((SELECT MAX(order_id) FROM orders), 1, 2, 25.99);
INSERT INTO order_items (order_id, product_id, quantity, price_each)
VALUES ((SELECT MAX(order_id) FROM orders), 1, 3, 25.99);
INSERT INTO customers (full_name, email, gender, birthdate, country, city, signup_date, referral_source, is_active)
VALUES ('Jennifer Rocha', 'josephwright@hotmail.com', 'Female', '2001-01-28', 'Canada', 'Juliechester', '2025-04-22', 'Facebook', TRUE);
INSERT INTO orders (customer_id, order_date, total_amount)
VALUES (6, '2025-05-20', 77.97);
INSERT INTO order_items (order_id, product_id, quantity, price_each)
VALUES ((SELECT MAX(order_id) FROM orders), 1, 3, 25.99);
INSERT INTO orders (customer_id, order_date, total_amount)
VALUES (6, '2025-05-11', 10.5);
INSERT INTO order_items (order_id, product_id, quantity, price_each)
VALUES ((SELECT MAX(order_id) FROM orders), 3, 1, 10.5);
INSERT INTO orders (customer_id, order_date, total_amount)
VALUES (6, '2025-05-09', 51.98);
INSERT INTO order_items (order_id, product_id, quantity, price_each)
VALUES ((SELECT MAX(order_id) FROM orders), 1, 2, 25.99);
INSERT INTO customers (full_name, email, gender, birthdate, country, city, signup_date, referral_source, is_active)
VALUES ('Zachary Hicks', 'callahaneric@conner.org', 'Female', '1968-09-20', 'UK', 'Jamesmouth', '2024-07-09', 'Facebook', TRUE);
INSERT INTO orders (customer_id, order_date, total_amount)
VALUES (7, '2024-10-14', 166.5);
INSERT INTO order_items (order_id, product_id, quantity, price_each)
VALUES ((SELECT MAX(order_id) FROM orders), 2, 3, 45.0);
INSERT INTO order_items (order_id, product_id, quantity, price_each)
VALUES ((SELECT MAX(order_id) FROM orders), 3, 3, 10.5);
INSERT INTO orders (customer_id, order_date, total_amount)
VALUES (7, '2025-02-08', 257.97);
INSERT INTO order_items (order_id, product_id, quantity, price_each)
VALUES ((SELECT MAX(order_id) FROM orders), 1, 3, 25.99);
INSERT INTO order_items (order_id, product_id, quantity, price_each)
VALUES ((SELECT MAX(order_id) FROM orders), 2, 3, 45.0);
INSERT INTO order_items (order_id, product_id, quantity, price_each)
VALUES ((SELECT MAX(order_id) FROM orders), 2, 1, 45.0);
INSERT INTO customers (full_name, email, gender, birthdate, country, city, signup_date, referral_source, is_active)
VALUES ('Alexandra Le', 'daniel62@yahoo.com', 'Female', '1964-08-14', 'UK', 'Teresaburgh', '2024-06-23', 'Facebook', TRUE);
INSERT INTO orders (customer_id, order_date, total_amount)
VALUES (8, '2024-08-03', 77.97);
INSERT INTO order_items (order_id, product_id, quantity, price_each)
VALUES ((SELECT MAX(order_id) FROM orders), 1, 1, 25.99);
INSERT INTO order_items (order_id, product_id, quantity, price_each)
VALUES ((SELECT MAX(order_id) FROM orders), 1, 2, 25.99);
INSERT INTO orders (customer_id, order_date, total_amount)
VALUES (8, '2025-02-20', 145.5);
INSERT INTO order_items (order_id, product_id, quantity, price_each)
VALUES ((SELECT MAX(order_id) FROM orders), 3, 1, 10.5);
INSERT INTO order_items (order_id, product_id, quantity, price_each)
VALUES ((SELECT MAX(order_id) FROM orders), 2, 3, 45.0);
INSERT INTO orders (customer_id, order_date, total_amount)
VALUES (8, '2024-10-16', 28.47);
INSERT INTO order_items (order_id, product_id, quantity, price_each)
VALUES ((SELECT MAX(order_id) FROM orders), 3, 1, 10.5);
INSERT INTO order_items (order_id, product_id, quantity, price_each)
VALUES ((SELECT MAX(order_id) FROM orders), 4, 2, 5.99);
INSERT INTO order_items (order_id, product_id, quantity, price_each)
VALUES ((SELECT MAX(order_id) FROM orders), 4, 1, 5.99);
INSERT INTO customers (full_name, email, gender, birthdate, country, city, signup_date, referral_source, is_active)
VALUES ('Katie Gonzalez', 'amberosborne@hotmail.com', 'Female', '1964-06-09', 'Netherlands', 'Tracyville', '2025-05-16', 'Google Ads', FALSE);
INSERT INTO orders (customer_id, order_date, total_amount)
VALUES (9, '2025-05-20', 74.95);
INSERT INTO order_items (order_id, product_id, quantity, price_each)
VALUES ((SELECT MAX(order_id) FROM orders), 4, 3, 5.99);
INSERT INTO order_items (order_id, product_id, quantity, price_each)
VALUES ((SELECT MAX(order_id) FROM orders), 4, 2, 5.99);
INSERT INTO order_items (order_id, product_id, quantity, price_each)
VALUES ((SELECT MAX(order_id) FROM orders), 2, 1, 45.0);
INSERT INTO orders (customer_id, order_date, total_amount)
VALUES (9, '2025-05-25', 166.98);
INSERT INTO order_items (order_id, product_id, quantity, price_each)
VALUES ((SELECT MAX(order_id) FROM orders), 4, 1, 5.99);
INSERT INTO order_items (order_id, product_id, quantity, price_each)
VALUES ((SELECT MAX(order_id) FROM orders), 1, 1, 25.99);
INSERT INTO order_items (order_id, product_id, quantity, price_each)
VALUES ((SELECT MAX(order_id) FROM orders), 2, 3, 45.0);
INSERT INTO orders (customer_id, order_date, total_amount)
VALUES (9, '2025-05-19', 17.97);
INSERT INTO order_items (order_id, product_id, quantity, price_each)
VALUES ((SELECT MAX(order_id) FROM orders), 4, 3, 5.99);
INSERT INTO customers (full_name, email, gender, birthdate, country, city, signup_date, referral_source, is_active)
VALUES ('David Bradley', 'dennislisa@cannon.net', 'Male', '1975-08-21', 'UK', 'Allisonchester', '2023-11-06', 'Instagram', FALSE);
INSERT INTO orders (customer_id, order_date, total_amount)
VALUES (10, '2024-12-28', 97.97);
INSERT INTO order_items (order_id, product_id, quantity, price_each)
VALUES ((SELECT MAX(order_id) FROM orders), 5, 1, 20.0);
INSERT INTO order_items (order_id, product_id, quantity, price_each)
VALUES ((SELECT MAX(order_id) FROM orders), 1, 3, 25.99);
INSERT INTO orders (customer_id, order_date, total_amount)
VALUES (10, '2025-05-25', 63.0);
INSERT INTO order_items (order_id, product_id, quantity, price_each)
VALUES ((SELECT MAX(order_id) FROM orders), 3, 3, 10.5);
INSERT INTO order_items (order_id, product_id, quantity, price_each)
VALUES ((SELECT MAX(order_id) FROM orders), 3, 1, 10.5);
INSERT INTO order_items (order_id, product_id, quantity, price_each)
VALUES ((SELECT MAX(order_id) FROM orders), 3, 2, 10.5);
INSERT INTO orders (customer_id, order_date, total_amount)
VALUES (10, '2025-04-24', 5.99);
INSERT INTO order_items (order_id, product_id, quantity, price_each)
VALUES ((SELECT MAX(order_id) FROM orders), 4, 1, 5.99);