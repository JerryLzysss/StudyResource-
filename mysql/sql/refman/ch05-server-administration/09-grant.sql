-- ============================================================
-- 第 5 章 MySQL 服务器管理 · GRANT

-- 文档：docs/refman/ch05-server-administration/09-grant.md
-- ============================================================

-- ---------- 原文示例 1 ----------
GRANT ALL ON db1.* TO 'jeffrey'@'localhost';
GRANT 'role1', 'role2' TO 'user1'@'localhost', 'user2'@'localhost';
GRANT SELECT ON world.* TO 'role3';

-- ---------- 原文示例 2 ----------
CREATE USER 'jeffrey'@'localhost' IDENTIFIED BY 'password';
GRANT ALL ON db1.* TO 'jeffrey'@'localhost';
GRANT SELECT ON db2.invoice TO 'jeffrey'@'localhost';
ALTER USER 'jeffrey'@'localhost' WITH MAX_QUERIES_PER_HOUR 90;

-- ---------- 原文示例 3 ----------
GRANT ALL ON test.* TO ''@'localhost' ...;

-- ---------- 原文示例 4 ----------
SELECT Host, User FROM mysql.user WHERE User='';

-- ---------- 原文示例 5 ----------
DROP USER ''@'localhost';

-- ---------- 原文示例 6 ----------
GRANT SELECT, INSERT ON *.* TO u1;

-- ---------- 原文示例 7 ----------
GRANT SELECT, INSERT, UPDATE ON *.* TO u1;
REVOKE INSERT, UPDATE ON db1.* FROM u1;

-- ---------- 原文示例 8 ----------
GRANT ALL ON *.* TO 'someuser'@'somehost';
GRANT SELECT, INSERT ON *.* TO 'someuser'@'somehost';

-- ---------- 原文示例 9 ----------
GRANT ALL ON mydb.* TO 'someuser'@'somehost';
GRANT SELECT, INSERT ON mydb.* TO 'someuser'@'somehost';

-- ---------- 原文示例 10 ----------
GRANT ALL ON mydb.mytbl TO 'someuser'@'somehost';
GRANT SELECT, INSERT ON mydb.mytbl TO 'someuser'@'somehost';

-- ---------- 原文示例 11 ----------
GRANT SELECT (col1), INSERT (col1, col2) ON mydb.mytbl TO 'someuser'@'somehost';

-- ---------- 原文示例 12 ----------
GRANT CREATE ROUTINE ON mydb.* TO 'someuser'@'somehost';
GRANT EXECUTE ON PROCEDURE mydb.myproc TO 'someuser'@'somehost';

-- ---------- 原文示例 13 ----------
GRANT PROXY ON 'localuser'@'localhost' TO 'externaluser'@'somehost';

-- ---------- 原文示例 14 ----------
GRANT 'role1', 'role2' TO 'user1'@'localhost', 'user2'@'localhost';

-- ---------- 原文示例 15 ----------
CREATE USER 'u1', 'u2';
CREATE ROLE 'r1', 'r2';

GRANT 'u1' TO 'u1';   -- simple loop: u1 => u1
GRANT 'r1' TO 'r1';   -- simple loop: r1 => r1

GRANT 'r2' TO 'u2';
GRANT 'u2' TO 'r2';   -- mixed user/role loop: u2 => r2 => u2

-- ---------- 原文示例 16 ----------
CREATE USER u1;
GRANT SELECT, INSERT, UPDATE, DELETE ON *.* TO u1;
REVOKE INSERT, UPDATE ON schema1.* FROM u1;
REVOKE SELECT ON schema2.* FROM u1;

-- ---------- 原文示例 17 ----------
CREATE ROLE r1;
GRANT INSERT ON schema1.* TO r1;
GRANT SELECT ON schema2.* TO r1;
GRANT r1 TO u1;

