-- ============================================================
-- 第 5 章 MySQL 服务器管理 · CREATE USER

-- 文档：docs/refman/ch05-server-administration/08-create-user.md
-- ============================================================

-- ---------- 原文示例 1 ----------
CREATE USER 'jeffrey'@'localhost' IDENTIFIED BY 'password';

-- ---------- 原文示例 2 ----------
CREATE USER 'jeffrey'@'localhost'
  IDENTIFIED BY 'new_password' PASSWORD EXPIRE;

-- ---------- 原文示例 3 ----------
CREATE USER 'jeffrey'@'localhost'
  IDENTIFIED WITH caching_sha2_password BY 'new_password'
  PASSWORD EXPIRE INTERVAL 180 DAY
  FAILED_LOGIN_ATTEMPTS 3 PASSWORD_LOCK_TIME 2;

-- ---------- 原文示例 4 ----------
CREATE USER
  'jeffrey'@'localhost' IDENTIFIED WITH mysql_native_password
                                   BY 'new_password1',
  'jeanne'@'localhost' IDENTIFIED WITH caching_sha2_password
                                  BY 'new_password2'
  REQUIRE X509 WITH MAX_QUERIES_PER_HOUR 60
  PASSWORD HISTORY 5
  ACCOUNT LOCK;

-- ---------- 原文示例 5 ----------
CREATE USER 'jeffrey'@'localhost'
  IDENTIFIED WITH mysql_native_password BY 'password';

-- ---------- 原文示例 6 ----------
CREATE USER 'joe'@'10.0.0.1' DEFAULT ROLE administrator, developer;

