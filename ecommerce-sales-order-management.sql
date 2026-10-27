CREATE DATABASE ecommerce_management;

CREATE TABLE categories (
    category_id SERIAL PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL UNIQUE,
    description VARCHAR(255)
);

INSERT INTO categories (category_name, description)
VALUES
('Electronics', 'Electronic products'),
('Clothing', 'Clothes and fashion'),
('Home & Kitchen', 'Home and kitchen products'),
('Books', 'Books and educational materials'),
('Sports', 'Sports and fitness products');

SELECT * FROM categories;

CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(150) NOT NULL,
    category_id INT NOT NULL,
    price NUMERIC(10,2) NOT NULL CHECK (price >= 0),
    stock_quantity INT NOT NULL DEFAULT 0 CHECK (stock_quantity >= 0),
    brand VARCHAR(100),
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

INSERT INTO products
(product_name, category_id, price, stock_quantity, brand)
VALUES
('iPhone 15', 1, 69999, 25, 'Apple'),
('Samsung Galaxy S24', 1, 74999, 20, 'Samsung'),
('Dell Inspiron Laptop', 1, 55999, 15, 'Dell'),
('Men T-Shirt', 2, 799, 50, 'Puma'),
('Women Jeans', 2, 1499, 35, 'Levis'),
('Mixer Grinder', 3, 3499, 18, 'Philips'),
('The Alchemist', 4, 499, 40, 'Penguin'),
('Python Programming Book', 4, 899, 30, 'OReilly'),
('Running Shoes', 5, 2999, 25, 'Nike'),
('Yoga Mat', 5, 999, 45, 'Decathlon');

SELECT * FROM products;

CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    phone VARCHAR(15),
    city VARCHAR(50),
    registration_date DATE DEFAULT CURRENT_DATE
);

INSERT INTO customers
(customer_name, email, phone, city, registration_date)
VALUES
('Rahul Patil', 'rahul.patil@gmail.com', '9876543210', 'Pune', '2026-01-15'),
('Sneha Sharma', 'sneha.sharma@gmail.com', '9876543211', 'Mumbai', '2026-01-20'),
('Amit Pawar', 'amit.pawar@gmail.com', '9876543212', 'Nashik', '2026-02-05'),
('Priya Deshmukh', 'priya.deshmukh@gmail.com', '9876543213', 'Pune', '2026-02-12'),
('Akash More', 'akash.more@gmail.com', '9876543214', 'Nagpur', '2026-02-18'),
('Neha Joshi', 'neha.joshi@gmail.com', '9876543215', 'Aurangabad', '2026-03-01'),
('Rohit Kulkarni', 'rohit.kulkarni@gmail.com', '9876543216', 'Mumbai', '2026-03-10'),
('Pooja Shah', 'pooja.shah@gmail.com', '9876543217', 'Pune', '2026-03-15'),
('Suresh More', 'suresh.more@gmail.com', '9876543218', 'Nashik', '2026-03-20'),
('Kiran Jadhav', 'kiran.jadhav@gmail.com', '9876543219', 'Kolhapur', '2026-03-25');

SELECT * FROM customers;

CREATE TABLE sellers (
    seller_id SERIAL PRIMARY KEY,
    seller_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    phone VARCHAR(15),
    city VARCHAR(50),
    rating NUMERIC(2,1) CHECK (rating BETWEEN 0 AND 5)
);

INSERT INTO sellers
(seller_name, email, phone, city, rating)
VALUES
('Tech World', 'techworld@gmail.com', '9000000001', 'Pune', 4.8),
('Fashion Hub', 'fashionhub@gmail.com', '9000000002', 'Mumbai', 4.5),
('Home Mart', 'homemart@gmail.com', '9000000003', 'Nashik', 4.2),
('Book House', 'bookhouse@gmail.com', '9000000004', 'Pune', 4.7),
('Sports Point', 'sportspoint@gmail.com', '9000000005', 'Nagpur', 4.4);

SELECT * FROM sellers;

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE DEFAULT CURRENT_DATE,
    order_status VARCHAR(30) DEFAULT 'Pending',
    total_amount NUMERIC(12,2) DEFAULT 0,
    
    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
);

INSERT INTO orders
(customer_id, order_date, order_status, total_amount)
VALUES
(1, '2026-04-01', 'Delivered', 69999),
(2, '2026-04-03', 'Delivered', 74999),
(3, '2026-04-05', 'Shipped', 55999),
(4, '2026-04-08', 'Delivered', 2298),
(5, '2026-04-10', 'Pending', 3499),
(6, '2026-04-12', 'Delivered', 1398),
(7, '2026-04-15', 'Shipped', 2999),
(8, '2026-04-18', 'Delivered', 1898),
(9, '2026-04-20', 'Cancelled', 999),
(10, '2026-04-22', 'Pending', 899);

SELECT * FROM orders;

CREATE TABLE order_items (
    order_item_id SERIAL PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    unit_price NUMERIC(10,2) NOT NULL CHECK (unit_price >= 0),

    FOREIGN KEY (order_id)
        REFERENCES orders(order_id),

    FOREIGN KEY (product_id)
        REFERENCES products(product_id)
);

INSERT INTO order_items
(order_id, product_id, quantity, unit_price)
VALUES
(1, 1, 1, 69999),
(2, 2, 1, 74999),
(3, 3, 1, 55999),
(4, 4, 2, 799),
(4, 5, 1, 1499),
(5, 6, 1, 3499),
(6, 7, 2, 499),
(7, 9, 1, 2999),
(8, 10, 1, 999),
(9, 10, 1, 999),
(10, 8, 1, 899);

SELECT * FROM order_items;

CREATE TABLE payments (
    payment_id SERIAL PRIMARY KEY,
    order_id INT NOT NULL,
    payment_date DATE DEFAULT CURRENT_DATE,
    payment_method VARCHAR(30) NOT NULL,
    payment_status VARCHAR(30) DEFAULT 'Pending',
    amount NUMERIC(12,2) NOT NULL CHECK (amount >= 0),

    FOREIGN KEY (order_id)
        REFERENCES orders(order_id)
);

INSERT INTO payments
(order_id, payment_date, payment_method, payment_status, amount)
VALUES
(1, '2026-04-01', 'UPI', 'Paid', 69999),
(2, '2026-04-03', 'Credit Card', 'Paid', 74999),
(3, '2026-04-05', 'Debit Card', 'Paid', 55999),
(4, '2026-04-08', 'UPI', 'Paid', 2298),
(5, '2026-04-10', 'Cash on Delivery', 'Pending', 3499),
(6, '2026-04-12', 'UPI', 'Paid', 998),
(7, '2026-04-15', 'Credit Card', 'Paid', 2999),
(8, '2026-04-18', 'UPI', 'Paid', 999),
(9, '2026-04-20', 'Debit Card', 'Refunded', 999),
(10, '2026-04-22', 'UPI', 'Pending', 899);

SELECT * FROM payments;

CREATE TABLE shipping (
    shipping_id SERIAL PRIMARY KEY,
    order_id INT NOT NULL,
    shipping_address VARCHAR(255) NOT NULL,
    city VARCHAR(50) NOT NULL,
    pincode VARCHAR(10) NOT NULL,
    courier_name VARCHAR(100),
    tracking_number VARCHAR(100) UNIQUE,
    shipping_status VARCHAR(30) DEFAULT 'Processing',
    shipped_date DATE,
    delivered_date DATE,

    FOREIGN KEY (order_id)
        REFERENCES orders(order_id)
);
INSERT INTO shipping
(order_id, shipping_address, city, pincode, courier_name, tracking_number, shipping_status, shipped_date, delivered_date)
VALUES
(1, 'Kothrud, Pune', 'Pune', '411038', 'Delhivery', 'DLV10001', 'Delivered', '2026-04-02', '2026-04-05'),
(2, 'Andheri West, Mumbai', 'Mumbai', '400058', 'Blue Dart', 'BD10002', 'Delivered', '2026-04-04', '2026-04-07'),
(3, 'College Road, Nashik', 'Nashik', '422005', 'DTDC', 'DT10003', 'Shipped', '2026-04-06', NULL),
(4, 'Baner, Pune', 'Pune', '411045', 'Delhivery', 'DLV10004', 'Delivered', '2026-04-09', '2026-04-12'),
(5, 'Dharampeth, Nagpur', 'Nagpur', '440010', 'Ecom Express', 'EC10005', 'Processing', NULL, NULL),
(6, 'Viman Nagar, Pune', 'Pune', '411014', 'Delhivery', 'DLV10006', 'Delivered', '2026-04-13', '2026-04-16'),
(7, 'Thane West, Mumbai', 'Mumbai', '400601', 'Blue Dart', 'BD10007', 'Shipped', '2026-04-16', NULL),
(8, 'Wakad, Pune', 'Pune', '411057', 'DTDC', 'DT10008', 'Delivered', '2026-04-19', '2026-04-22'),
(9, 'Gangapur Road, Nashik', 'Nashik', '422013', 'Ecom Express', 'EC10009', 'Cancelled', NULL, NULL),
(10, 'Shivaji Nagar, Pune', 'Pune', '411005', 'Delhivery', 'DLV10010', 'Processing', NULL, NULL);

SELECT * FROM shipping;

CREATE TABLE reviews (
    review_id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL,
    product_id INT NOT NULL,
    rating INT NOT NULL CHECK (rating BETWEEN 1 AND 5),
    review_text VARCHAR(500),
    review_date DATE DEFAULT CURRENT_DATE,

    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id),

    FOREIGN KEY (product_id)
        REFERENCES products(product_id)
);

INSERT INTO reviews
(customer_id, product_id, rating, review_text, review_date)
VALUES
(1, 1, 5, 'Excellent phone and great camera.', '2026-04-06'),
(2, 2, 4, 'Good performance and premium design.', '2026-04-08'),
(3, 3, 5, 'Very good laptop for office work.', '2026-04-10'),
(4, 4, 4, 'Comfortable and good quality T-shirt.', '2026-04-13'),
(5, 6, 4, 'Mixer works very well.', '2026-04-15'),
(6, 7, 5, 'Interesting and useful book.', '2026-04-17'),
(7, 9, 5, 'Very comfortable running shoes.', '2026-04-20'),
(8, 10, 4, 'Good quality yoga mat.', '2026-04-23');

SELECT * FROM reviews;

CREATE TABLE returns (
    return_id SERIAL PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    return_date DATE DEFAULT CURRENT_DATE,
    return_reason VARCHAR(255) NOT NULL,
    refund_amount NUMERIC(12,2) NOT NULL CHECK (refund_amount >= 0),
    return_status VARCHAR(30) DEFAULT 'Requested',

    FOREIGN KEY (order_id)
        REFERENCES orders(order_id),

    FOREIGN KEY (product_id)
        REFERENCES products(product_id)
);

INSERT INTO returns
(order_id, product_id, return_date, return_reason, refund_amount, return_status)
VALUES
(4, 4, '2026-04-14', 'Size was not suitable', 1598, 'Completed'),
(6, 7, '2026-04-18', 'Customer changed mind', 998, 'Completed'),
(9, 10, '2026-04-21', 'Product not required', 999, 'Approved');

SELECT * FROM returns;

SELECT
    c.customer_id,
    c.customer_name,
    COUNT(o.order_id) AS total_orders
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.customer_name
ORDER BY total_orders DESC;

SELECT
    SUM(total_amount) AS total_revenue
FROM orders
WHERE order_status <> 'Cancelled';

SELECT
    c.customer_name,
    COUNT(o.order_id) AS total_orders,
    SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
WHERE o.order_status <> 'Cancelled'
GROUP BY
    c.customer_id,
    c.customer_name
ORDER BY total_spent DESC;

SELECT
    c.customer_name,
    SUM(o.total_amount) AS total_spent,
    RANK() OVER (
        ORDER BY SUM(o.total_amount) DESC
    ) AS customer_rank
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
WHERE o.order_status <> 'Cancelled'
GROUP BY
    c.customer_id,
    c.customer_name
ORDER BY customer_rank;



SELECT
    p.product_id,
    p.product_name,
    SUM(oi.quantity) AS total_quantity_sold,
    SUM(oi.quantity * oi.unit_price) AS total_sales
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
JOIN orders o
    ON oi.order_id = o.order_id
WHERE o.order_status <> 'Cancelled'
GROUP BY
    p.product_id,
    p.product_name
ORDER BY total_quantity_sold DESC;


SELECT
    DATE_TRUNC('month', order_date)::DATE AS month,
    COUNT(order_id) AS total_orders,
    SUM(total_amount) AS total_sales,
    ROUND(AVG(total_amount), 2) AS average_order_value
FROM orders
WHERE order_status <> 'Cancelled'
GROUP BY DATE_TRUNC('month', order_date)
ORDER BY month;

SELECT
    c.category_name,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(oi.quantity) AS total_quantity_sold,
    SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM categories c
JOIN products p
    ON c.category_id = p.category_id
JOIN order_items oi
    ON p.product_id = oi.product_id
JOIN orders o
    ON oi.order_id = o.order_id
WHERE o.order_status <> 'Cancelled'
GROUP BY
    c.category_id,
    c.category_name
ORDER BY total_revenue DESC;



SELECT
    c.customer_id,
    c.customer_name,
    COUNT(o.order_id) AS total_orders,
    SUM(o.total_amount) AS lifetime_value,
    ROUND(AVG(o.total_amount), 2) AS average_order_value
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
WHERE o.order_status <> 'Cancelled'
GROUP BY
    c.customer_id,
    c.customer_name
ORDER BY lifetime_value DESC;

SELECT
    c.customer_id,
    c.customer_name,
    COUNT(o.order_id) AS total_orders,
    SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
WHERE o.order_status <> 'Cancelled'
GROUP BY
    c.customer_id,
    c.customer_name
HAVING COUNT(o.order_id) > 1
ORDER BY total_orders DESC;

SELECT
    product_id,
    product_name,
    brand,
    stock_quantity,
    price,
    CASE
        WHEN stock_quantity = 0 THEN 'Out of Stock'
        WHEN stock_quantity <= 10 THEN 'Critical Stock'
        WHEN stock_quantity <= 20 THEN 'Low Stock'
        ELSE 'In Stock'
    END AS stock_status
FROM products
ORDER BY stock_quantity ASC;

SELECT
    p.product_id,
    p.product_name,
    p.brand,
    COALESCE(SUM(oi.quantity), 0) AS quantity_sold,
    COALESCE(SUM(oi.quantity * oi.unit_price), 0) AS total_sales,
    COALESCE(ROUND(AVG(r.rating), 2), 0) AS average_rating
FROM products p
LEFT JOIN order_items oi
    ON p.product_id = oi.product_id
LEFT JOIN orders o
    ON oi.order_id = o.order_id
LEFT JOIN reviews r
    ON p.product_id = r.product_id
WHERE o.order_status <> 'Cancelled'
   OR o.order_status IS NULL
GROUP BY
    p.product_id,
    p.product_name,
    p.brand
ORDER BY total_sales DESC;

SELECT
    p.product_id,
    p.product_name,
    COUNT(DISTINCT oi.order_id) AS total_orders,
    COUNT(DISTINCT r.return_id) AS total_returns,
    ROUND(
        COUNT(DISTINCT r.return_id) * 100.0
        / NULLIF(COUNT(DISTINCT oi.order_id), 0),
        2
    ) AS return_rate_percentage
FROM products p
LEFT JOIN order_items oi
    ON p.product_id = oi.product_id
LEFT JOIN returns r
    ON p.product_id = r.product_id
GROUP BY
    p.product_id,
    p.product_name
ORDER BY return_rate_percentage DESC;

CREATE OR REPLACE VIEW sales_dashboard AS
SELECT
    o.order_id,
    o.order_date,
    c.customer_name,
    p.product_name,
    cat.category_name,
    oi.quantity,
    oi.unit_price,
    (oi.quantity * oi.unit_price) AS sales_amount,
    o.order_status,
    pay.payment_method,
    pay.payment_status
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
JOIN products p
    ON oi.product_id = p.product_id
JOIN categories cat
    ON p.category_id = cat.category_id
LEFT JOIN payments pay
    ON o.order_id = pay.order_id;


SELECT * FROM sales_dashboard;


SELECT
    product_name,
    SUM(sales_amount) AS total_sales,
    SUM(quantity) AS total_quantity_sold
FROM sales_dashboard
WHERE order_status <> 'Cancelled'
GROUP BY product_name
ORDER BY total_sales DESC
LIMIT 5;

SELECT
    COUNT(DISTINCT order_id) AS total_orders,
    COUNT(DISTINCT customer_name) AS total_customers,
    COUNT(DISTINCT product_name) AS total_products_sold,
    SUM(sales_amount) AS total_revenue,
    ROUND(AVG(sales_amount), 2) AS average_sales_value
FROM sales_dashboard


WITH monthly_sales AS (
    SELECT
        DATE_TRUNC('month', order_date)::DATE AS month,
        SUM(sales_amount) AS monthly_revenue
    FROM sales_dashboard
    WHERE order_status <> 'Cancelled'
    GROUP BY DATE_TRUNC('month', order_date)
)
SELECT
    month,
    monthly_revenue,
    RANK() OVER (
        ORDER BY monthly_revenue DESC
    ) AS revenue_rank
FROM monthly_sales
ORDER BY month;



CREATE OR REPLACE FUNCTION get_customer_report(p_customer_id INT)
RETURNS TABLE (
    customer_name VARCHAR,
    total_orders BIGINT,
    total_spent NUMERIC
)
LANGUAGE SQL
AS $$
    SELECT
        c.customer_name,
        COUNT(o.order_id) AS total_orders,
        COALESCE(SUM(o.total_amount), 0) AS total_spent
    FROM customers c
    LEFT JOIN orders o
        ON c.customer_id = o.customer_id
        AND o.order_status <> 'Cancelled'
    WHERE c.customer_id = p_customer_id
    GROUP BY c.customer_id, c.customer_name;
$$;

SELECT * FROM get_customer_report(1);

CREATE OR REPLACE FUNCTION update_product_stock()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE products
    SET stock_quantity = stock_quantity - NEW.quantity
    WHERE product_id = NEW.product_id;

    RETURN NEW;
END;
$$;

CREATE TRIGGER trg_update_product_stock
AFTER INSERT ON order_items
FOR EACH ROW
EXECUTE FUNCTION update_product_stock();

SELECT
    product_id,
    product_name,
    stock_quantity
FROM products
WHERE product_id = 1;

INSERT INTO orders
(customer_id, order_date, order_status, total_amount)
VALUES
(1, CURRENT_DATE, 'Pending', 0);

SELECT MAX(order_id) AS test_order_id
FROM orders;

INSERT INTO order_items
(order_id, product_id, quantity, unit_price)
VALUES
(11, 1, 2, 69999);

SELECT
    product_id,
    product_name,
    stock_quantity
FROM products
WHERE product_id = 1;

SELECT
    o.order_id,
    o.total_amount AS order_total,
    COALESCE(SUM(oi.quantity * oi.unit_price), 0) AS calculated_total,
    o.total_amount - COALESCE(SUM(oi.quantity * oi.unit_price), 0) AS difference
FROM orders o
LEFT JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY o.order_id, o.total_amount
ORDER BY o.order_id;

UPDATE orders o
SET total_amount = (
    SELECT COALESCE(SUM(oi.quantity * oi.unit_price), 0)
    FROM order_items oi
    WHERE oi.order_id = o.order_id
);

SELECT
    o.order_id,
    o.total_amount AS order_total,
    p.amount AS payment_amount,
    o.total_amount - p.amount AS difference,
    p.payment_status
FROM orders o
LEFT JOIN payments p
    ON o.order_id = p.order_id
ORDER BY o.order_id;

SELECT
    c.customer_id,
    c.customer_name,
    COUNT(o.order_id) AS total_orders,
    COALESCE(SUM(o.total_amount), 0) AS total_spent,
    CASE
        WHEN COALESCE(SUM(o.total_amount), 0) >= 50000
            THEN 'VIP Customer'
        WHEN COUNT(o.order_id) >= 2
            THEN 'Regular Customer'
        ELSE 'New Customer'
    END AS customer_segment
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
    AND o.order_status <> 'Cancelled'
GROUP BY c.customer_id, c.customer_name
ORDER BY total_spent DESC;

SELECT
    c.customer_id,
    c.customer_name,
    MAX(o.order_date) AS last_order_date,
    CURRENT_DATE - MAX(o.order_date) AS recency_days,
    COUNT(o.order_id) AS frequency,
    SUM(o.total_amount) AS monetary_value
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
WHERE o.order_status <> 'Cancelled'
GROUP BY c.customer_id, c.customer_name
ORDER BY monetary_value DESC;

WITH rfm AS (
    SELECT
        c.customer_id,
        c.customer_name,
        CURRENT_DATE - MAX(o.order_date) AS recency_days,
        COUNT(o.order_id) AS frequency,
        SUM(o.total_amount) AS monetary_value
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    WHERE o.order_status <> 'Cancelled'
    GROUP BY c.customer_id, c.customer_name
)
SELECT
    customer_id,
    customer_name,
    recency_days,
    frequency,
    monetary_value,
    CASE
        WHEN frequency >= 2 AND monetary_value >= 50000
            THEN 'High Value Customer'
        WHEN frequency >= 2
            THEN 'Loyal Customer'
        WHEN recency_days <= 30
            THEN 'Active Customer'
        ELSE 'At Risk Customer'
    END AS customer_segment
FROM rfm
ORDER BY monetary_value DESC;


WITH customer_orders AS (
    SELECT
        c.customer_id,
        c.customer_name,
        COUNT(o.order_id) AS total_orders,
        SUM(o.total_amount) AS total_spent
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    WHERE o.order_status <> 'Cancelled'
    GROUP BY c.customer_id, c.customer_name
)
SELECT
    COUNT(*) AS total_customers,
    COUNT(*) FILTER (WHERE total_orders = 1) AS one_time_customers,
    COUNT(*) FILTER (WHERE total_orders > 1) AS repeat_customers,
    ROUND(
        COUNT(*) FILTER (WHERE total_orders > 1) * 100.0
        / NULLIF(COUNT(*), 0),
        2
    ) AS repeat_customer_percentage
FROM customer_orders;



SELECT
    payment_method,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(amount) AS total_payment_amount,
    ROUND(AVG(amount), 2) AS average_payment
FROM payments
WHERE payment_status = 'Paid'
GROUP BY payment_method
ORDER BY total_payment_amount DESC;

SELECT
    order_status,
    COUNT(*) AS total_orders,
    ROUND(
        COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (),
        2
    ) AS percentage
FROM orders
GROUP BY order_status
ORDER BY total_orders DESC;

SELECT
    p.product_id,
    p.product_name,
    p.brand,
    COALESCE(SUM(oi.quantity), 0) AS units_sold,
    COALESCE(SUM(oi.quantity * oi.unit_price), 0) AS total_revenue,
    CASE
        WHEN COALESCE(SUM(oi.quantity * oi.unit_price), 0) >= 50000
            THEN 'High Revenue'
        WHEN COALESCE(SUM(oi.quantity * oi.unit_price), 0) >= 10000
            THEN 'Medium Revenue'
        ELSE 'Low Revenue'
    END AS revenue_category
FROM products p
LEFT JOIN order_items oi
    ON p.product_id = oi.product_id
LEFT JOIN orders o
    ON oi.order_id = o.order_id
    AND o.order_status <> 'Cancelled'
GROUP BY p.product_id, p.product_name, p.brand
ORDER BY total_revenue DESC;

SELECT
    p.product_id,
    p.product_name,
    p.stock_quantity,
    COALESCE(SUM(oi.quantity), 0) AS total_sold,
    CASE
        WHEN p.stock_quantity = 0
            THEN 'OUT OF STOCK'
        WHEN p.stock_quantity <= 10
            THEN 'CRITICAL - RESTOCK NOW'
        WHEN p.stock_quantity <= 20
            THEN 'LOW STOCK'
        ELSE 'HEALTHY STOCK'
    END AS inventory_status
FROM products p
LEFT JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY
    p.product_id,
    p.product_name,
    p.stock_quantity
ORDER BY p.stock_quantity ASC;



WITH product_sales AS (
    SELECT
        c.category_name,
        p.product_id,
        p.product_name,
        SUM(oi.quantity * oi.unit_price) AS total_revenue
    FROM categories c
    JOIN products p
        ON c.category_id = p.category_id
    JOIN order_items oi
        ON p.product_id = oi.product_id
    JOIN orders o
        ON oi.order_id = o.order_id
    WHERE o.order_status <> 'Cancelled'
    GROUP BY
        c.category_name,
        p.product_id,
        p.product_name
),
ranked_products AS (
    SELECT
        category_name,
        product_name,
        total_revenue,
        DENSE_RANK() OVER (
            PARTITION BY category_name
            ORDER BY total_revenue DESC
        ) AS product_rank
    FROM product_sales
)
SELECT
    category_name,
    product_name,
    total_revenue,
    product_rank
FROM ranked_products
WHERE product_rank <= 3
ORDER BY category_name, product_rank;



WITH monthly_sales AS (
    SELECT
        DATE_TRUNC('month', order_date)::DATE AS month,
        SUM(total_amount) AS monthly_revenue
    FROM orders
    WHERE order_status <> 'Cancelled'
    GROUP BY DATE_TRUNC('month', order_date)
),
growth_analysis AS (
    SELECT
        month,
        monthly_revenue,
        LAG(monthly_revenue) OVER (
            ORDER BY month
        ) AS previous_month_revenue
    FROM monthly_sales
)
SELECT
    month,
    monthly_revenue,
    previous_month_revenue,
    ROUND(
        (monthly_revenue - previous_month_revenue)
        * 100.0
        / NULLIF(previous_month_revenue, 0),
        2
    ) AS growth_percentage
FROM growth_analysis
ORDER BY month;



SELECT
    COUNT(DISTINCT o.order_id) AS total_orders,
    COUNT(DISTINCT o.customer_id) AS total_customers,
    COUNT(DISTINCT oi.product_id) AS unique_products_sold,
    SUM(oi.quantity) AS total_units_sold,
    SUM(oi.quantity * oi.unit_price) AS total_revenue,
    ROUND(
        SUM(oi.quantity * oi.unit_price)
        / NULLIF(COUNT(DISTINCT o.order_id), 0),
        2
    ) AS average_order_value
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE o.order_status <> 'Cancelled';




SELECT
    o.order_id,
    o.order_date,
    c.customer_name,
    c.city AS customer_city,
    p.product_name,
    cat.category_name,
    oi.quantity,
    oi.unit_price,
    (oi.quantity * oi.unit_price) AS sales_amount,
    o.order_status,
    pay.payment_method,
    pay.payment_status,
    s.courier_name,
    s.shipping_status
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
JOIN products p
    ON oi.product_id = p.product_id
JOIN categories cat
    ON p.category_id = cat.category_id
LEFT JOIN payments pay
    ON o.order_id = pay.order_id
LEFT JOIN shipping s
    ON o.order_id = s.order_id
WHERE o.order_status <> 'Cancelled'
ORDER BY o.order_date, o.order_id;


CREATE OR REPLACE VIEW ecommerce_dashboard AS
SELECT
    o.order_id,
    o.order_date,
    c.customer_name,
    c.city AS customer_city,
    p.product_name,
    cat.category_name,
    oi.quantity,
    oi.quantity * oi.unit_price AS sales_amount,
    o.order_status,
    pay.payment_method,
    pay.payment_status,
    s.shipping_status
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
JOIN products p
    ON oi.product_id = p.product_id
JOIN categories cat
    ON p.category_id = cat.category_id
LEFT JOIN payments pay
    ON o.order_id = pay.order_id
LEFT JOIN shipping s
    ON o.order_id = s.order_id
WHERE o.order_status <> 'Cancelled';


SELECT *
FROM ecommerce_dashboard
ORDER BY order_date;



SELECT
    (SELECT COUNT(*) FROM customers) AS total_customers,
    (SELECT COUNT(*) FROM products) AS total_products,
    (SELECT COUNT(*) FROM orders) AS total_orders,
    (SELECT COUNT(*) FROM order_items) AS total_order_items,
    (SELECT COUNT(*) FROM payments) AS total_payments,
    (SELECT COUNT(*) FROM shipping) AS total_shipments,
    (SELECT COUNT(*) FROM reviews) AS total_reviews,
    (SELECT COUNT(*) FROM returns) AS total_returns;