CREATE TABLE employees (
    id INT,
    name VARCHAR(50),
    department VARCHAR(50),
    salary INT
);

INSERT INTO employees (id, name, department, salary)
VALUES
    (1, '山田太郎', '営業部', 500000),
    (2, '佐藤花子', '営業部', 600000),
    (3, '鈴木一郎', '開発部', 550000),
    (4, '田中健', '開発部', 700000),
    (5, '渡辺優子', '人事部', 450000),
    (6, '高橋信也', '営業部', 600000),
    (7, '伊藤恵子', '開発部', 550000);


SELECT
    id,
    name,
    department,
    salary,
    ROW_NUMBER() OVER (PARTITION BY department ORDER BY salary DESC) AS dept_salary_rank
FROM
    employees;

CREATE TABLE students_window (
    id INT,
    name VARCHAR(50),
    grade INT,
    score INT
);

INSERT INTO students_window (id, name, grade, score)
VALUES
    (1, '山田太郎', 1, 85),
    (2, '佐藤花子', 1, 92),
    (3, '鈴木一郎', 1, 78),
    (4, '田中優子', 2, 89),
    (5, '渡辺健', 2, 91),
    (6, '伊藤さくら', 2, 88),
    (7, '高橋太一', 3, 95),
    (8, '山本美穂', 3, 79),
    (9, '中村隆', 3, 82);

-- 課題1
-- ROW_NUMBER()関数を使用して、各学年（grade）内で点数（score）の降順に基づいて、生徒に連番を割り当ててください。
-- 結果は、id、name、grade、score、および連番（student_rankという別名で表示）の列を含むようにしてください。

SELECT id,
    name,
    grade,
    score,
    ROW_NUMBER() OVER (PARTITION BY grade ORDER BY score DESC) as student_rank
FROM students_window;

CREATE TABLE products (
    id INT,
    name VARCHAR(50),
    category VARCHAR(50),
    price INT
);


-- 課題2
-- 各カテゴリ（category）内で価格（price）の昇順に基づいて、商品に連番を割り当ててください。
-- 結果は、id、name、category、price、および連番（product_rankという別名で表示）の列を含むようにしてください。
-- 結果をcategoryの昇順で並べ替え、同じカテゴリ内ではproduct_rankの昇順で並べ替えてください。


INSERT INTO products (id, name, category, price)
VALUES
    (1, 'シャツ', '衣類', 2500),
    (2, 'パンツ', '衣類', 3500),
    (3, '靴', '履物', 5000),
    (4, 'ソックス', '衣類', 1000),
    (5, 'スニーカー', '履物', 8000),
    (6, 'ジャケット', '衣類', 6000),
    (7, 'サンダル', '履物', 3000),
    (8, 'ベルト', 'アクセサリー', 2000),
    (9, 'ネクタイ', 'アクセサリー', 2500);

SELECT id,
    name,
    category,
    price,
    ROW_NUMBER() OVER (PARTITION BY category ORDER BY ASC) as product_rank
FROM products
ORDER BY
    category ASC,
    product_rank ASC,