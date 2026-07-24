-- ============================================================
-- 第 11 章 数据类型 · 本地可执行演示
-- ============================================================

USE W3CSCHOOL;

DROP TABLE IF EXISTS demo_refman_types;
CREATE TABLE demo_refman_types (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  qty INT NOT NULL,
  price DECIMAL(10,2) NOT NULL,
  created_at DATETIME(3) DEFAULT CURRENT_TIMESTAMP(3),
  meta JSON,
  note VARCHAR(100)
);

INSERT INTO demo_refman_types (qty, price, meta, note)
VALUES (2, 19.90, JSON_OBJECT('color', 'red', 'size', 'M'), 'demo');

SELECT id, qty, price, created_at,
       JSON_EXTRACT(meta, '$.color') AS color,
       note
FROM demo_refman_types;
