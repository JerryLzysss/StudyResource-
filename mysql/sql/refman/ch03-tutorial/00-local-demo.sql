-- ============================================================
-- 第 3 章 教程 · 本地可执行演示
-- ============================================================

-- 迷你教程（独立库，避免与 W3CSCHOOL 冲突）
CREATE DATABASE IF NOT EXISTS menagerie
  DEFAULT CHARACTER SET utf8mb4;
USE menagerie;

DROP TABLE IF EXISTS pet;
CREATE TABLE pet (
  name    VARCHAR(20),
  owner   VARCHAR(20),
  species VARCHAR(20),
  sex     CHAR(1),
  birth   DATE,
  death   DATE
);

INSERT INTO pet VALUES
  ('Fluffy', 'Harold', 'cat', 'f', '1993-02-04', NULL),
  ('Claws',  'Gwen',   'cat', 'm', '1994-03-17', NULL),
  ('Buffy',  'Harold', 'dog', 'f', '1989-05-13', NULL),
  ('Fang',   'Benny',  'dog', 'm', '1990-08-27', NULL),
  ('Bowser', 'Diane',  'dog', 'm', '1979-08-31', '1995-07-29');

SELECT * FROM pet;
SELECT name, birth FROM pet WHERE species = 'dog';
SELECT owner, COUNT(*) AS cnt FROM pet GROUP BY owner;
