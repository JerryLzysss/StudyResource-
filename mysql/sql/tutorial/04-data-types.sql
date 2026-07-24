-- ============================================================
-- 模块：04 数据类型
-- 文档：docs/tutorial/04-data-types.md
-- 依赖：请先执行 sql/tutorial/00-setup.sql
-- ============================================================

USE W3CSCHOOL;

-- 用一张演示表观察常见类型
DROP TABLE IF EXISTS demo_types;
CREATE TABLE demo_types (
  id INT PRIMARY KEY AUTO_INCREMENT,
  tiny_num TINYINT,
  int_num INT,
  price DECIMAL(10,2),
  ratio FLOAT,
  the_date DATE,
  the_time TIME,
  the_dt DATETIME,
  title VARCHAR(50),
  body TEXT
);

INSERT INTO demo_types (tiny_num, int_num, price, ratio, the_date, the_time, the_dt, title, body)
VALUES (1, 100, 19.99, 0.85, CURDATE(), CURTIME(), NOW(), 'demo', 'long text');

DESC demo_types;
SELECT * FROM demo_types;
