-- PostgreSQL schema for the cleaned UCI Online Retail data.

DROP TABLE IF EXISTS customer_rfm;
DROP TABLE IF EXISTS transactions;

CREATE TABLE transactions (
    invoice_no TEXT NOT NULL,
    stock_code TEXT NOT NULL,
    description TEXT,
    quantity INTEGER NOT NULL CHECK (quantity > 0),
    invoice_date TIMESTAMP NOT NULL,
    unit_price NUMERIC(12, 4) NOT NULL CHECK (unit_price > 0),
    customer_id NUMERIC,
    country TEXT NOT NULL,
    is_cancelled BOOLEAN NOT NULL DEFAULT FALSE,
    line_revenue NUMERIC(14, 4) NOT NULL
);

CREATE INDEX idx_transactions_invoice_date
    ON transactions (invoice_date);
CREATE INDEX idx_transactions_customer_id
    ON transactions (customer_id);
CREATE INDEX idx_transactions_stock_code
    ON transactions (stock_code);

CREATE TABLE customer_rfm (
    customer_id NUMERIC PRIMARY KEY,
    recency_days INTEGER NOT NULL,
    frequency INTEGER NOT NULL,
    monetary NUMERIC(14, 2) NOT NULL,
    r_score SMALLINT NOT NULL CHECK (r_score BETWEEN 1 AND 5),
    f_score SMALLINT NOT NULL CHECK (f_score BETWEEN 1 AND 5),
    m_score SMALLINT NOT NULL CHECK (m_score BETWEEN 1 AND 5),
    segment TEXT NOT NULL
);
