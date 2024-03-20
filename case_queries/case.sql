CREATE TABLE Students (
    student_id INTEGER PRIMARY KEY,
    name VARCHAR(50),
    department VARCHAR(50),
    score INTEGER
);

INSERT INTO Students VALUES
    (1, '山田太郎', '情報工学', 80),
    (2, '佐藤花子', '情報工学', 90),
    (3, '鈴木次郎', '機械工学', 75),
    (4, '田中美樹', '機械工学', 85),
    (5, '伊藤大輔', '電気工学', 92),
    (6, '渡辺陽子', '情報工学', 88),
    (7, '小林健太', '情報工学', 82),
    (8, '加藤裕子', '電気工学', 79),
    (9, '吉田久美子', '機械工学', 93),
    (10, '山本卓也', '機械工学', 89);

/** 
1.各学生について、以下の条件に基づいて「成績」列を追加してください。
    学生の点数が、その学生の所属学科の平均点数より高い場合は「平均以上」
    学生の点数が、その学生の所属学科の平均点数より低い場合は「平均未満」
    学生の点数が、その学生の所属学科の平均点数と等しい場合は「平均」

2.各学科について、以下の条件に基づいて「合格者数」列を追加してくださ。
    学生の点数が80点以上の場合は合格とみなします。
    各学科の合格者数を集計してください。
*/


-- 解答
-- 1
SELECT 
    student_id,
    name,
    department,
    score,
    CASE 
        WHEN score > (SELECT AVG(score) FROM Students s2 WHERE s2.department = s1.department) THEN '平均以上'
        WHEN score < (SELECT AVG(score) FROM Students s2 WHERE s2.department = s1.department) THEN '平均未満'
        ELSE '平均'
    END AS '成績'
FROM Students s1;

-- 各学生の点数がその学生の所属学科の平均点数と比較してどのように位置付けられるかを判断するクエリ
SELECT 
    s.student_id,
    s.name,
    s.department,
    s.score,
    CASE 
        WHEN s.score > d.avg_score THEN '平均以上'
        WHEN s.score < d.avg_score THEN '平均未満'
        ELSE '平均'
    END AS 成績
FROM 
    Students s
INNER JOIN (
    -- 各学科の平均点数を計算するサブクエリ
    SELECT 
        department,
        AVG(score) AS avg_score
    FROM 
        Students
    GROUP BY 
        department
) d ON s.department = d.department;


--2 
SELECT
    department,
    SUM(CASE WHEN score >= 80 THEN 1 ELSE 0 END) AS '合格者数'
FROM students
GROUP BY department;




CREATE TABLE StudentClub (
    std_id INTEGER,
    club_id INTEGER,
    club_name VARCHAR(32),
    main_club_flg CHAR(1),
    PRIMARY KEY (std_id, club_id)
);

INSERT INTO StudentClub VALUES
    (100, 1, '野球', 'Y'),
    (100, 2, '吹奏楽', 'N'),
    (200, 2, '吹奏楽', 'N'),
    (200, 3, 'バドミントン', 'Y'),
    (200, 4, 'サッカー', 'N'),
    (300, 4, 'サッカー', 'N'),
    (400, 5, '水泳', 'N'),
    (500, 6, '囲碁', 'N'),
    (600, 1, '野球', 'N'),
    (600, 7, 'テニス', 'Y'),
    (700, 8, 'バスケットボール', 'Y'),
    (800, 8, 'バスケットボール', 'N'),
    (900, 9, '卓球', 'Y'),
    (1000, 10, '将棋', 'N');


--1
--  各クラブについて、「男子部員数」と「女子部員数」の列を表示してください。
-- 学生のIDが偶数の場合は男子、奇数の場合は女子とみなします。
--  クラブに所属している学生がいない場合は、0を表示してください。
-- 
-- 2
-- 各クラブについて、「部員数」と「主な活動をしている部員の割合」の列を表示してください。
-- 「主な活動をしている部員の割合」は、そのクラブを主なクラブとしている部員の数を全部員数で割った値です。
-- 割合は、パーセント形式（例：50%）で表示してください。










-- 解答
SELECT
    club_id,
    club_name,
    SUM(CASE WHEN std_id % 2 = 0 THEN 1 ELSE 0 END) AS male_count,
    SUM(CASE WHEN std_id % 2 = 1 THEN 1 ELSE 0 END) AS female_count
FROM StudentClub
GROUP BY club_id, club_name;