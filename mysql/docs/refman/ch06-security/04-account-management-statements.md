# 第 6 章 安全 · 账户管理语句

> 对应 SQL：[`sql/refman/ch06-security/04-account-management-statements.sql`](../../../sql/refman/ch06-security/04-account-management-statements.sql)

---

13.7.1 账户管理报表_MySQL 8.0 参考手册

Skip to Main Content

			Documentation

Section Menu:

		* MySQL 8.0 参考手册 MySQL 8.0 参考手册 / 第 13 章 SQL 语句 / 13.7 数据库管理语句 / 13.7.1 账户管理报表 MySQL 帐户信息存储在 `mysql`系统模式的表中。该数据库和访问控制系统在第 5 章MySQL 服务器管理*中进行了广泛讨论
      ，您应该查阅该章以获取更多详细信息。

重要的

        一些 MySQL 版本引入了对授权表的更改以添加新的权限或功能。为确保您可以利用任何新功能，请在升级 MySQL 时将授权表更新为当前结构。请参阅
        第 2.11 节，“升级 MySQL”。

`read_only`启用系统变量后，除了任何其他所需的权限外，帐户管理语句还需要

      权限（`CONNECTION_ADMIN`或已弃用的权限）。`SUPER`这是因为它们修改了`mysql`系统模式中的表。

      账户管理报表是原子的并且是崩溃安全的。有关详细信息，请参阅第 13.1.1 节，“原子数据定义语句支持”。

---

[← 返回 第 6 章 安全 索引](00-index.md) · [← 返回总索引](../00-index.md)
