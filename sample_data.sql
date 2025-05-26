-- Sample data insertions

INSERT INTO customers (name, email, signup_date) VALUES
('Alice Johnson', 'alice@example.com', '2023-01-10'),
('Bob Smith', 'bob@example.com', '2023-02-15');

INSERT INTO products (name, category, price) VALUES
('Wireless Mouse', 'Electronics', 25.99),
('Bluetooth Speaker', 'Electronics', 45.00),
('Water Bottle', 'Home & Kitchen', 10.50);

INSERT INTO orders (customer_id, order_date, total_amount) VALUES
(1, '2023-03-01', 71.99),
(2, '2023-03-05', 10.50);

INSERT INTO order_items (order_id, product_id, quantity, price_each) VALUES
(1, 1, 1, 25.99),
(1, 2, 1, 45.00),
(2, 3, 1, 10.50);

INSERT INTO ads (campaign_name, spend, start_date, end_date) VALUES
('Spring Promo', 500.00, '2023-02-01', '2023-03-01');

INSERT INTO ad_clicks (ad_id, customer_id, click_date) VALUES
(1, 1, '2023-02-15');
