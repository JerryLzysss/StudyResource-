# 第 2 章 安装和升级 MySQL · 2.11 升级 MySQL

> 对应 SQL：[`sql/refman/ch02-installing/08-upgrading.sql`](../../../sql/refman/ch02-installing/08-upgrading.sql)

---

## 2.11 升级MySQL

    本节介绍升级 MySQL 安装的步骤。

    升级是一个常见的过程，因为您在同一个 MySQL 版本系列中获取错误修复或在主要 MySQL 版本之间获取重要功能。您首先在一些测试系统上执行此过程以确保一切顺利，然后在生产系统上执行。

笔记

      在下面的讨论中，必须使用具有管理权限的 MySQL 帐户运行的 MySQL 命令包括在命令行中以指定 MySQL用户。需要密码的命令还包括一个
      选项。因为后面没有选项值，所以此类命令提示输入密码。出现提示时键入密码，然后按 Enter。
    `-u root` `root``root``-p``-p`

      可以使用**mysql**
      命令行客户端执行 SQL 语句（连接 as`root`以确保您具有必要的权限）。

---

[← 返回 第 2 章 安装和升级 MySQL 索引](00-index.md) · [← 返回总索引](../00-index.md)
