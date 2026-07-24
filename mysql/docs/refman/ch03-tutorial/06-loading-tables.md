# 第 3 章 教程 · 加载数据

> 对应 SQL：[`sql/refman/ch03-tutorial/06-loading-tables.sql`](../../../sql/refman/ch03-tutorial/06-loading-tables.sql)

---

3.3.3 将数据加载到表中_MySQL 8.0 参考手册

Skip to Main Content

			Documentation

Section Menu:

		* MySQL 8.0 参考手册 MySQL 8.0 参考手册 / 第 3 章教程 / 3.3 创建和使用数据库 / 3.3.3 将数据加载到表中 创建表后，您需要填充它。`LOAD DATA`和 语句对此 `INSERT`很有用。 假设您的宠物记录可以描述为此处所示。（注意 MySQL 期望日期 格式；这可能与您习惯的不同。） `'YYYY-MM-DD`*'

| 姓名 | 所有者 | 物种 | 性别 | 诞生 | 死亡 |
| --- | --- | --- | --- | --- | --- |
| 蓬松的 | 哈罗德 | 猫 | F | 1993-02-04 |  |
| 爪子 | 格温 | 猫 | 米 | 1994-03-17 |  |
| 巴菲 | 哈罗德 | 狗 | F | 1989-05-13 |  |
| 芳 | 本尼 | 狗 | 米 | 1990-08-27 |  |
| 鲍泽 | 黛安 | 狗 | 米 | 1979-08-31 | 1995-07-29 |
| 扢 | 格温 | 鸟 | F | 1998-09-11 |  |
| 惠斯勒 | 格温 | 鸟 |  | 1997-12-09 |  |
| 瘦 | 本尼 | 蛇 | 米 | 1996-04-29 |  |

        因为您是从一个空表开始的，所以填充它的一种简单方法是创建一个包含每只动物一行的文本文件，然后使用一条语句将文件的内容加载到表中。

        您可以创建一个文本文件`pet.txt`
        ，每行包含一条记录，值由制表符分隔，并按照列在
        `CREATE TABLE`语句中列出的顺序给出。对于缺失值（例如尚存动物的未知性别或死亡日期），您可以使用`NULL`
        值。要在您的文本文件中表示这些，请使用
        `\N`（反斜杠，大写 N）。例如，Whistler the bird 的记录如下所示（值之间的空格是单个制表符）：

```text
Whistler        Gwen    bird    \N      1997-12-09      \N
```

        要将文本文件加载`pet.txt`到
        `pet`表中，请使用以下语句：

```sql
mysql> LOAD DATA LOCAL INFILE '/path/pet.txt' INTO TABLE pet;
```

        如果您在 Windows 上使用
        `\r\n`用作行终止符的编辑器创建文件，则应改用此语句：

```sql
mysql> LOAD DATA LOCAL INFILE '/path/pet.txt' INTO TABLE pet
       LINES TERMINATED BY '\r\n';
```

        （在运行 macOS 的 Apple 机器上，您可能希望使用
        `LINES TERMINATED BY '\r'`.）

`LOAD DATA`如果愿意，
        您可以在语句中明确指定列值分隔符和行尾标记，但默认值为制表符和换行符。这些足以让语句`pet.txt`正确读取文件。

        如果该语句失败，则可能是您的 MySQL 安装没有默认启用本地文件功能。有关如何更改此设置的信息，
      请参阅第 6.1.6 节“LOAD DATA LOCAL 的安全注意事项” 。

        当您想一次添加一条新记录时，该
        `INSERT`语句很有用。在最简单的形式中，您按照列在
        `CREATE TABLE`语句中列出的顺序为每一列提供值。假设黛安得到了一只名为“马勃”的新仓鼠。”您可以使用如下
        `INSERT`语句添加新记录：

```sql
mysql> INSERT INTO pet
       VALUES ('Puffball','Diane','hamster','f','1999-03-30',NULL);
```

        字符串和日期值在此处指定为带引号的字符串。此外，使用`INSERT`，您可以直接插入
        `NULL`以表示缺失值。您不像`\N`使用
        `LOAD DATA`.

        从此示例中，您应该能够看到，最初使用多个`INSERT`语句而不是单个`LOAD DATA`
        语句来加载记录会涉及更多的输入。

---

[← 返回 第 3 章 教程 索引](00-index.md) · [← 返回总索引](../00-index.md)
