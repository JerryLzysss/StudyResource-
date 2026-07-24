-- ============================================================
-- 第 3 章 教程 · 创建表

-- 文档：docs/refman/ch03-tutorial/05-creating-tables.md
-- ============================================================

-- ---------- 原文示例 1 ----------
CREATE TABLE pet (name VARCHAR(20), owner VARCHAR(20),
       species VARCHAR(20), sex CHAR(1), birth DATE, death DATE);

-- ---------- 原文示例 2 ----------
SHOW TABLES;
-- +---------------------+
| Tables in menagerie |
-- +---------------------+
| pet                 |
-- +---------------------+

-- ---------- 原文示例 3 ----------
DESCRIBE pet;
-- +---------+-------------+------+-----+---------+-------+
| Field   | Type        | Null | Key | Default | Extra |
-- +---------+-------------+------+-----+---------+-------+
| name    | varchar(20) | YES  |     | NULL    |       |
| owner   | varchar(20) | YES  |     | NULL    |       |
| species | varchar(20) | YES  |     | NULL    |       |
| sex     | char(1)     | YES  |     | NULL    |       |
| birth   | date        | YES  |     | NULL    |       |
| death   | date        | YES  |     | NULL    |       |
-- +---------+-------------+------+-----+---------+-------+

