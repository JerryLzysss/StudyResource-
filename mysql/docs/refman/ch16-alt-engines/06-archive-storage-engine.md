# 第 16 章 替代存储引擎 · ARCHIVE

> 对应 SQL：[`sql/refman/ch16-alt-engines/06-archive-storage-engine.sql`](../../../sql/refman/ch16-alt-engines/06-archive-storage-engine.sql)

---

## 16.5 ARCHIVE存储引擎

    存储引擎生成专用表，`ARCHIVE`以非常小的占用空间存储大量未索引的数据。

**表 16.5 ARCHIVE 存储引擎功能**

| 特征 | 支持 |
| --- | --- |
| B树索引 | 不 |
| 备份/时间点恢复（在服务器中实现，而不是在存储引擎中。） | 是的 |
| 集群数据库支持 | 不 |
| 聚簇索引 | 不 |
| 压缩数据 | 是的 |
| 数据缓存 | 不 |
| 加密数据 | 是（通过加密功能在服务器中实现。） |
| 外键支持 | 不 |
| 全文搜索索引 | 不 |
| 地理空间数据类型支持 | 是的 |
| 地理空间索引支持 | 不 |
| 哈希索引 | 不 |
| 索引缓存 | 不 |
| 锁定粒度 | 排 |
| MVCC | 不 |
| 复制支持（在服务器中实现，而不是在存储引擎中。） | 是的 |
| 存储限制 | 没有任何 |
| T树索引 | 不 |
| 交易 | 不 |
| 更新数据字典的统计信息 | 是的 |

**存储引擎包含在`ARCHIVE`MySQL 二进制发行版中。如果您从源代码构建 MySQL，要启用此存储引擎，请使用该 选项 调用CMake 。**`-DWITH_ARCHIVE_STORAGE_ENGINE`

    要检查`ARCHIVE`引擎的源代码，请查看`storage/archive`MySQL 源代码分发目录。

    您可以使用该
    语句
  检查`ARCHIVE`存储引擎是否可用。`SHOW ENGINES`

    创建`ARCHIVE`表时，存储引擎会创建名称以表名开头的文件。数据文件的扩展名为`.ARZ`. `.ARN`在优化操作期间可能会出现
  一个
    文件。

`ARCHIVE`引擎支持

    , `INSERT`,
    `REPLACE`和
    `SELECT`，但不
    支持`DELETE`or
     `UPDATE`。它确实支持
    `ORDER BY`操作、
    `BLOB`列和空间数据类型（请参阅第 11.4.1 节，“空间数据类型”）。不支持地理空间参考系统。该`ARCHIVE`
    引擎使用行级锁定。

`ARCHIVE`引擎支持

    列`AUTO_INCREMENT`属性。该
    `AUTO_INCREMENT`列可以具有唯一或非唯一索引。尝试在任何其他列上创建索引会导致错误。该`ARCHIVE`引擎还支持语句中的`AUTO_INCREMENT`表选项
    `CREATE TABLE`，分别为新表指定初始序列值或为现有表重置序列值。

    `ARCHIVE`不支持将值插入到`AUTO_INCREMENT`小于当前最大列值的列中。尝试这样做会导致
    `ER_DUP_KEY`错误。

如果没有请求，引擎会忽略列，并在阅读时扫描

    过去`ARCHIVE`。
    `BLOB`

`ARCHIVE`存储引擎不支持分区

    。

    **存储：**行在插入时被压缩。该`ARCHIVE`引擎使用
    `zlib`无损数据压缩（请参阅
    [http://www.zlib.net/](http://www.zlib.net/)）。您可以使用
    `OPTIMIZE TABLE`来分析表格并将其打包成更小的格式（关于使用 的原因
    `OPTIMIZE TABLE`，请参阅本节后面部分）。该引擎还支持`CHECK TABLE`. 使用了几种类型的插入：

- 一条INSERT语句只是将行推入压缩缓冲区，并且该缓冲区会根据需要刷新。插入缓冲区受锁保护。ASELECT强制发生冲洗。
- 批量插入只有在完成后才可见，除非同时发生其他插入，在这种情况下只能部分看到。ASELECT永远不会导致批量插入的刷新，除非在加载时发生正常插入。

    **检索**：检索时，行按需解压缩；没有行缓存。一个
    `SELECT`操作执行完整的表扫描：当一个操作`SELECT`发生时，它会找出当前有多少行可用并读取该行数。`SELECT`作为一致读取执行。请注意
    `SELECT`，除非仅使用批量插入，否则插入期间的大量语句会降低压缩率。为了获得更好的压缩效果，您可以使用
    `OPTIMIZE TABLE`或
    `REPAIR TABLE`。`ARCHIVE`报告的表
    中的行数
    `SHOW TABLE STATUS`始终是准确的。参见第 13.7.3.4 节，“OPTIMIZE TABLE 语句”，
    第 13.7.3.5 节，“REPAIR TABLE 语句”，以及
    第 13.7.7.38 节，“显示表状态语句”。

### 其他资源

- 专用于ARCHIVE存储引擎的论坛可在https://forums.mysql.com/list.php?112找到。

---

[← 返回 第 16 章 替代存储引擎 索引](00-index.md) · [← 返回总索引](../00-index.md)
