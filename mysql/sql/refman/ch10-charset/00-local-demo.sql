-- ============================================================
-- 第 10 章 字符集、排序规则、Unicode · 本地可执行演示
-- ============================================================

SHOW CHARACTER SET LIKE 'utf8%';
SHOW COLLATION WHERE Charset = 'utf8mb4' LIMIT 10;

SELECT @@character_set_server, @@collation_server;
SELECT DEFAULT_CHARACTER_SET_NAME, DEFAULT_COLLATION_NAME
FROM information_schema.SCHEMATA
WHERE SCHEMA_NAME = 'W3CSCHOOL';

SELECT '你好😊' AS s,
       CHAR_LENGTH('你好😊') AS chars,
       LENGTH('你好😊') AS bytes;

SELECT 'a' = 'A' AS default_cmp,
       'a' COLLATE utf8mb4_bin = 'A' COLLATE utf8mb4_bin AS bin_cmp;
