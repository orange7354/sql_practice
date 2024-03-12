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



--2 
SELECT
    department,
    SUM(CASE WHEN score >= 80 THEN 1 ELSE 0 END) AS '合格者数'
FROM students
GROUP BY department;