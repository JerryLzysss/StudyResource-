-- ============================================================
-- 第 25 章 存储对象 · 本地可执行演示
-- ============================================================

USE W3CSCHOOL;

CREATE OR REPLACE VIEW v_author_cnt AS
SELECT w3cschool_author AS author, COUNT(*) AS cnt
FROM w3cschool_tbl
GROUP BY w3cschool_author;

SELECT * FROM v_author_cnt;

DROP PROCEDURE IF EXISTS sp_count_by_author;
DELIMITER $$
CREATE PROCEDURE sp_count_by_author(IN p_author VARCHAR(40), OUT p_cnt INT)
BEGIN
  SELECT COUNT(*) INTO p_cnt
  FROM w3cschool_tbl
  WHERE w3cschool_author = p_author;
END$$
DELIMITER ;

CALL sp_count_by_author('Sanjay', @c);
SELECT @c AS sanjay_cnt;

SHOW VARIABLES LIKE 'event_scheduler';
