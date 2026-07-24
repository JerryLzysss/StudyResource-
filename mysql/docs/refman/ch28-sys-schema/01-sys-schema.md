# 第 28 章 MySQL 系统模式 · 章首

> 对应 SQL：[`sql/refman/ch28-sys-schema/01-sys-schema.sql`](../../../sql/refman/ch28-sys-schema/01-sys-schema.sql)

---

# 第 28 章 MySQL 系统模式

    MySQL 8.0 包含
    `sys`架构，一组对象可帮助 DBA 和开发人员解释性能架构收集的数据。`sys`模式对象可用于典型的调优和诊断用例。此架构中的对象包括：

- 将 Performance Schema 数据汇总为更易于理解的形式的视图。
- 执行性能模式配置和生成诊断报告等操作的存储过程。
- 查询 Performance Schema 配置并提供格式化服务的存储函数。

    对于新安装，`sys`如果将**mysqld**与
    `--initialize`或
    `--initialize-insecure`选项一起使用，则在数据目录初始化期间默认安装架构。如果不需要，您可以`sys`
    在初始化后手动删除不需要的模式。

`sys`如果模式存在但没有
    视图，
    则 MySQL 升级过程会产生错误
    `version`，假设该视图的缺失表示用户创建的`sys`
    模式。要在这种情况下升级，请先删除或重命名现有
    `sys`架构。

    `sys`模式对象有
    一个`DEFINER`。
    `'mysql.sys'@'localhost'`使用专用
    `mysql.sys`帐户可以避免在 DBA 重命名或删除`root`帐户时发生的问题。

---

[← 返回 第 28 章 MySQL 系统模式 索引](00-index.md) · [← 返回总索引](../00-index.md)
