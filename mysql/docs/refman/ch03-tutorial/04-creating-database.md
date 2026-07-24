# 第 3 章 教程 · 创建和使用数据库

> 对应 SQL：[`sql/refman/ch03-tutorial/04-creating-database.sql`](../../../sql/refman/ch03-tutorial/04-creating-database.sql)

---

3.3.1 创建和选择数据库_MySQL 8.0 参考手册

**Skip to Main Content Documentation Section Menu:  MySQL 8.0 参考手册 MySQL 8.0 参考手册 / 第 3 章教程 / 3.3 创建和使用数据库 / 3.3.1 创建和选择数据库 如果管理员在设置您的权限时为您创建了数据库，您就可以开始使用它了。否则，您需要自己创建它： ```sql mysql> CREATE DATABASE menagerie; ``` 在 Unix 下，数据库名称区分大小写（与 SQL 关键字不同），因此您必须始终将数据库称为 `menagerie`，而不是 `Menagerie`、`MENAGERIE`或其他变体。表名也是如此。（在 Windows 下，此限制不适用，尽管您必须在整个给定查询中使用相同的字母大小写来引用数据库和表。但是，出于各种原因，推荐的最佳实践始终使用与查询时使用的字母大小写相同的字母大小写数据库已创建。） 笔记 如果您在尝试创建数据库时遇到诸如ERROR 1044 (42000): Access denied for user 'micah'@'localhost' to database 'menagerie' 之类的错误，这意味着您的用户帐户没有必要的权限来执行此操作所以。与管理员讨论这个问题或参见第 6.2 节“访问控制和帐户管理”。 创建数据库并没有选择它来使用；你必须明确地这样做。要创建`menagerie`当前数据库，请使用以下语句： ```sql mysql> USE menagerie Database changed ``` 您的数据库只需创建一次，但您必须在每次开始mysql**
        会话时选择它以供使用。您可以通过发出
        `USE`示例中所示的语句来执行此操作。或者，您可以在调用**mysql**时在命令行上选择数据库。只需在您可能需要提供的任何连接参数之后指定其名称。例如：

```text
$> mysql -h host -u user -p menagerie
Enter password: ********
```

重要的

          `menagerie`在刚刚显示的命令中
          **不是**您的密码。如果您想在
          `-p`选项后的命令行中提供您的密码，则必须中间没有空格（例如，as
           ，而不是 as ）。但是，不建议将密码放在命令行中，因为这样做会使密码暴露给登录到您机器上的其他用户窥探。
`-ppassword``-p password`

笔记

          您可以随时使用查看当前选择的数据库。
`SELECT`
          `DATABASE()`

---

[← 返回 第 3 章 教程 索引](00-index.md) · [← 返回总索引](../00-index.md)
