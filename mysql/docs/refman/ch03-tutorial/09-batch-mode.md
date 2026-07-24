# 第 3 章 教程 · 批处理模式

> 对应 SQL：[`sql/refman/ch03-tutorial/09-batch-mode.sql`](../../../sql/refman/ch03-tutorial/09-batch-mode.sql)

---

## 3.5 在批处理模式下使用 mysql

      在前面的部分中，您以交互方式使用**mysql**
      输入语句并查看结果。您还可以以批处理模式运行**mysql**。为此，将要运行的语句放在文件中，然后告诉
      **mysql**从文件中读取其输入：

```text
$> mysql  mysql -e "source batch-file"
```

      如果您需要在命令行上指定连接参数，该命令可能如下所示：

```text
$> mysql -h host -u user -p

- 如果您重复运行查询（例如，每天或每周），将其设为脚本可以避免每次执行时都重新输入。
- 您可以通过复制和编辑脚本文件从现有的类似查询生成新查询。
- 在开发查询时，批处理模式也很有用，特别是对于多行语句或多语句序列。如果您输入错误，您不必重新输入所有内容。只需编辑您的脚本以更正错误，然后告诉mysql再次执行它。
- 如果您有一个产生大量输出的查询，您可以通过寻呼机运行输出而不是看着它从屏幕顶部滚动： ```text $> mysql  mysql mysql.out ```
- 您可以将脚本分发给其他人，以便他们也可以运行这些语句。
- 有些情况不允许交互式使用，例如，当您从cron作业运行查询时。在这种情况下，您必须使用批处理模式。

当你以批处理模式运行**mysql**
      时，默认输出格式与你交互使用它时不同（更简洁）
       。例如，交互式运行
    **mysql**`SELECT DISTINCT species FROM pet`时的输出如下所示
      ：****

```text
+---------+
| species |
+---------+
| bird    |
| cat     |
| dog     |
| hamster |
| snake   |
+---------+
```

      在批处理模式下，输出看起来像这样：

```text
species
bird
cat
dog
hamster
snake
```

      如果要以批处理模式获取交互式输出格式，请使用**mysql -t**。要将执行的语句回显到输出中，请使用**mysql -v**。

      您还可以使用命令或
      命令从**mysql**提示符使用脚本：
    `source``\.`

```sql
mysql> source filename;
mysql> \. filename
```

      有关更多信息，请参阅第 4.5.1.5 节，“从文本文件执行 SQL 语句”。

---

[← 返回 第 3 章 教程 索引](00-index.md) · [← 返回总索引](../00-index.md)
