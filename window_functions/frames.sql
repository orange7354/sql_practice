-- テーブルの作成
CREATE TABLE sales (
  id INT,
  date DATE,
  product VARCHAR(50),
  quantity INT,
  price DECIMAL(10, 2)
);

-- データの挿入
INSERT INTO sales (id, date, product, quantity, price)
VALUES
    (1, '2023-05-01', 'A', 10, 50.00),
    (2, '2023-05-01', 'B', 5, 100.00),
    (3, '2023-05-02', 'A', 15, 50.00),
    (4, '2023-05-02', 'C', 8, 75.00),
    (5, '2023-05-03', 'B', 10, 100.00),
    (6, '2023-05-03', 'C', 5, 75.00),
    (7, '2023-05-04', 'A', 20, 50.00),
    (8, '2023-05-04', 'B', 15, 100.00);

-- 以下の要件を満たすSQLクエリを作成してください：
-- 各行について、その行の日付と、直前の2日間の売上合計を表示してください。
-- 売上合計は、数量（quantity）と価格（price）を掛け合わせて計算してください。
-- 結果は、日付の昇順で並べ替えてください。



SELECT id,
    date,
    product,
    quantity,
    price,
    SUM(quantity * price) OVER (ORDER BY date ASC ROWS BETWEEN 2 PRECEDING AND 1 PRECEDING ) as tow_days_total_sales
FROM sales;


-- テーブルの作成
CREATE TABLE inventory (
  id INT,
  date DATE,
  product VARCHAR(50),
  quantity INT
);

-- データの挿入
INSERT INTO inventory (id, date, product, quantity)
VALUES
  (1, '2023-05-01', 'A', 100),
  (2, '2023-05-02', 'A', 80),
  (3, '2023-05-03', 'A', 120),
  (4, '2023-05-04', 'A', 90),
  (5, '2023-05-05', 'A', 110),
  (6, '2023-05-06', 'A', 100),
  (7, '2023-05-07', 'A', 130),
  (8, '2023-05-08', 'A', 120);



SELECT 
    id,
    date,
    product,
    quantity,
    AVG(quantity) OVER (ORDER BY date ASC BETWEEN 3 PRECEDING AND 1 PRECEDING) as avg_three_dayes_quantity,
FROM inventory
ORDER BY date ASC;

-- 以下の要件を満たすSQLクエリを作成してください：
-- 各行について、その行の日付と、直前の3日間の在庫数の平均値を表示してください。
-- 結果は、日付の昇順で並べ替えてください。


SELECT 
    id,
    date,
    product,
    quantity,
    AVG(quantity) OVER (ORDER BY date ASC ROWS BETWEEN 3 PRECEDING AND 1 PRECEDING) AS avg_three_dayes_quantity
FROM inventory
ORDER BY date;