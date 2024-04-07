CREATE TABLE customers (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    email VARCHAR(50)
);

CREATE TABLE orders (
    id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES customers(id)
);

INSERT INTO customers (id, name, email)
VALUES
(1, 'test1', 'hoge1@example.com'),
(2, 'test2', 'hoge2@example.com'),
(3, 'test3', 'hoge3@example.com'),
(4, 'test4', 'hoge4@example.com'),
(5, 'test5', 'hoge5@example.com');

INSERT INTO orders (id, customer_id, order_date, total_amount)
VALUES
(1, 1, '2023-04-01', 5000),
(2, 1, '2023-04-15', 3000),
(3, 2, '2023-04-10', 8000),
(4, 3, '2023-04-20', 6000),
(5, 4, '2023-04-25', 10000),
(6, NULL, '2023-04-30', 7000);




-- NOT IN と NOT EXISTS の動作の違いを確認する為に、
-- 一度も注文したことのない顧客を検索してみます。

-- NOT IN を使用した場合
SELECT
    id,
    name
FROM customers
WHERE id NOT IN (
    SELECT customer_id
    FROM orders
);

-- NOT EXISTS を使用した場合

SELECT *
FROM customers c
WHERE NOT EXISTS (
    SELECT 1
    FROM orders o
    WHERE c.id = o.customer_id
);