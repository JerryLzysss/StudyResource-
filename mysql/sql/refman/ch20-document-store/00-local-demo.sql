-- ============================================================
-- 第 20 章 使用 MySQL 作为文档存储 · 本地可执行演示
-- ============================================================

USE W3CSCHOOL;

DROP TABLE IF EXISTS demo_docs;
CREATE TABLE demo_docs (
  doc_id VARCHAR(36) PRIMARY KEY,
  doc JSON NOT NULL,
  INDEX idx_name ((CAST(doc->>'$.name' AS CHAR(64))))
);

INSERT INTO demo_docs VALUES
  (UUID(), JSON_OBJECT('name', 'Alice', 'age', 30, 'tags', JSON_ARRAY('a', 'b'))),
  (UUID(), JSON_OBJECT('name', 'Bob', 'age', 28, 'tags', JSON_ARRAY('b')));

SELECT doc_id,
       doc->>'$.name' AS name,
       doc->>'$.age' AS age
FROM demo_docs
WHERE doc->>'$.name' = 'Alice';
