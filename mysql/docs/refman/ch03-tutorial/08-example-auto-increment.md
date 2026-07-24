# 第 3 章 教程 · 使用 AUTO_INCREMENT

> 对应 SQL：[`sql/refman/ch03-tutorial/08-example-auto-increment.sql`](../../../sql/refman/ch03-tutorial/08-example-auto-increment.sql)

---

3.6.9 使用 AUTO_INCREMENT_MySQL 8.0 参考手册

- Skip to Main Content Documentation Section Menu:  MySQL 8.0 参考手册 MySQL 8.0 参考手册 / 第 3 章教程 / 3.6 常见查询示例 / 3.6.9 使用 AUTO_INCREMENT 该AUTO_INCREMENT属性可用于为新行生成唯一标识： ```sql CREATE TABLE animals ( id MEDIUMINT NOT NULL AUTO_INCREMENT, name CHAR(30) NOT NULL, PRIMARY KEY (id) ); INSERT INTO animals (name) VALUES ('dog'),('cat'),('penguin'), ('lax'),('whale'),('ostrich'); SELECT * FROM animals; ``` 哪个返回： ```text +----+---------+ | id | name | +----+---------+ | 1 | dog | | 2 | cat | | 3 | penguin | | 4 | lax | | 5 | whale | | 6 | ostrich | +----+---------+ ``` 没有为该AUTO_INCREMENT 列指定值，因此 MySQL 自动分配了序列号。NO_AUTO_VALUE_ON_ZERO除非启用了 SQL 模式，否则您也可以显式地将 0 分配给该列以生成序列号 。例如： ```sql INSERT INTO animals (id,name) VALUES(0,'groundhog'); ``` 如果声明了该列NOT NULL，也可以为该NULL列赋值以生成序号。例如： ```sql INSERT INTO animals (id,name) VALUES(NULL,'squirrel'); ``` 当您将任何其他值插入到 AUTO_INCREMENT列中时，该列将设置为该值并重置序列，以便下一个自动生成的值从最大的列值开始按顺序排列。例如： ```sql INSERT INTO animals (id,name) VALUES(100,'rabbit'); INSERT INTO animals (id,name) VALUES(NULL,'mouse'); SELECT * FROM animals; +-----+-----------+ | id | name | +-----+-----------+ | 1 | dog | | 2 | cat | | 3 | penguin | | 4 | lax | | 5 | whale | | 6 | ostrich | | 7 | groundhog | | 8 | squirrel | | 100 | rabbit | | 101 | mouse | +-----+-----------+ ``` 更新现有AUTO_INCREMENT列值也会重置AUTO_INCREMENT 序列。 您可以使用SQL 函数或C API 函数 检索最近自动生成 AUTO_INCREMENT的值 。这些函数是特定于连接的，因此它们的返回值不受另一个也在执行插入的连接的影响。 LAST_INSERT_ID()mysql_insert_id()AUTO_INCREMENT对大到足以容纳您需要的最大序列值 的列使用最小的整数数据类型 。当该列达到数据类型的上限时，下一次尝试生成序列号将失败。如果可能，请使用该 UNSIGNED属性以允许更大的范围。例如，如果您使用 TINYINT，则最大允许序列号为 127。对于 TINYINT UNSIGNED，最大值为 255。请参阅 第 11.1.2 节“整数类型（精确值）- INTEGER、INT、SMALLINT、TINYINT、MEDIUMINT、BIGINT”了解所有整数类型的范围。 笔记 对于多行插入， LAST_INSERT_ID()实际上 mysql_insert_id()从插入的第一AUTO_INCREMENT行返回键 。这使得多行插入能够在复制设置中的其他服务器上正确复制。 要以AUTO_INCREMENT1 以外的值开始，请使用CREATE TABLE或设置该值ALTER TABLE，如下所示： ```sql mysql> ALTER TABLE tbl AUTO_INCREMENT = 100; ``` #### InnoDB 注释 有关AUTO_INCREMENT特定于 的用法的信息InnoDB，请参阅 第 15.6.1.6 节，“InnoDB 中的 AUTO_INCREMENT 处理”。 #### MyISAM 注释 对于MyISAM表，您可以 AUTO_INCREMENT在多列索引中的辅助列上指定。在这种情况下，AUTO_INCREMENT列的生成值计算为 。当您想要将数据放入有序组中时，这很有用。 MAX(auto_increment_column) + 1 WHERE prefix=given-prefix ```sql CREATE TABLE animals ( grp ENUM('fish','mammal','bird') NOT NULL, id MEDIUMINT NOT NULL AUTO_INCREMENT, name CHAR(30) NOT NULL, PRIMARY KEY (grp,id) ) ENGINE=MyISAM; INSERT INTO animals (grp,name) VALUES ('mammal','dog'),('mammal','cat'), ('bird','penguin'),('fish','lax'),('mammal','whale'), ('bird','ostrich'); SELECT * FROM animals ORDER BY grp,id; ``` 哪个返回： ```text +--------+----+---------+ | grp | id | name | +--------+----+---------+ | fish | 1 | lax | | mammal | 1 | dog | | mammal | 2 | cat | | mammal | 3 | whale | | bird | 1 | penguin | | bird | 2 | ostrich | +--------+----+---------+ ``` 在这种情况下（当该AUTO_INCREMENT 列是多列索引的一部分时）， 如果您删除任何组中AUTO_INCREMENT具有最大值的行，则会重用这些 值。AUTO_INCREMENT即使对于通常不重用值 的MyISAM表，也会发生这种情况。AUTO_INCREMENT
- 如果该AUTO_INCREMENT列是多个索引的一部分，MySQL 会使用以该 AUTO_INCREMENT列开头的索引生成序列值（如果有的话）。例如，如果animals表包含索引PRIMARY KEY (grp, id) 和INDEX (id)，MySQL 将忽略 PRIMARY KEY生成序列值。因此，该表将包含单个序列，而不是每个grp值的序列。

#### 进一步阅读

          有关更多信息，`AUTO_INCREMENT`请参见此处：

- 如何将AUTO_INCREMENT 属性分配给列：第 13.1.20 节，“CREATE TABLE 语句”和 第 13.1.9 节，“ALTER TABLE 语句”。
- 行为如何AUTO_INCREMENT取决于 NO_AUTO_VALUE_ON_ZERO SQL 模式：第 5.1.11 节，“服务器 SQL 模式”。
- 如何使用该 LAST_INSERT_ID()函数查找包含最新 AUTO_INCREMENT值的行： 第 12.16 节，“信息函数”。
- 设置AUTO_INCREMENT要使用的值：第 5.1.8 节，“服务器系统变量”。
- 第 15.6.1.6 节，“InnoDB 中的 AUTO_INCREMENT 处理”
- AUTO_INCREMENT和复制： 第 17.5.1.1 节，“复制和 AUTO_INCREMENT”。
- 与可用于复制 的AUTO_INCREMENT (auto_increment_increment 和 ) 相关的服务器系统变量 ：第 5.1.8 节，“服务器系统变量”。 auto_increment_offset

---

[← 返回 第 3 章 教程 索引](00-index.md) · [← 返回总索引](../00-index.md)
