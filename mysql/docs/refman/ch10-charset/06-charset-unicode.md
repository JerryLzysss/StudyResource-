# 第 10 章 字符集、排序规则、Unicode · Unicode 支持

> 对应 SQL：[`sql/refman/ch10-charset/06-charset-unicode.sql`](../../../sql/refman/ch10-charset/06-charset-unicode.sql)

---

## 10.9 Unicode 支持

      Unicode 标准包括来自基本多语言平面 (BMP) 的字符和位于 BMP 之外的补充字符。本节介绍 MySQL 中对 Unicode 的支持。有关 Unicode 标准本身的信息，请访问[Unicode Consortium 网站](http://www.unicode.org/)。

      BMP 字符具有以下特点：

- 它们的代码点值介于 0 和 65535（或 U+0000和U+FFFF）之间。
- 它们可以使用 8、16 或 24 位（1 到 3 个字节）以可变长度编码进行编码。
- 它们可以使用 16 位（2 字节）以固定长度编码进行编码。
- 对于主要语言中的几乎所有字符，它们都足够了。

      补充字符位于 BMP 之外：

- 它们的代码点值介于U+10000 和U+10FFFF) 之间。
- Unicode 对增补字符的支持要求字符集的范围在 BMP 字符之外，因此比 BMP 字符占用更多空间（每个字符最多 4 个字节）。

      用于编码 Unicode 数据的 UTF-8（Unicode Transformation Format with 8-bit units）方法是根据 RFC 3629 实现的，它描述了占用 1 到 4 个字节的编码序列。UTF-8的思想是各种Unicode字符使用不同长度的字节序列进行编码：

- 基本的拉丁字母、数字和标点符号使用一个字节。
- 大多数欧洲和中东脚本字母适合 2 字节序列：扩展拉丁字母（带有波浪号、长音符、锐音符、重音符和其他重音符号）、西里尔字母、希腊字母、亚美尼亚字母、希伯来字母、阿拉伯字母、叙利亚字母等。
- 韩文、中文和日文表意文字使用 3 字节或 4 字节序列。

      MySQL 支持这些 Unicode 字符集：

- utf8mb4：Unicode 字符集的 UTF-8 编码，每个字符使用一到四个字节。
- utf8mb3：Unicode 字符集的 UTF-8 编码，每个字符使用一到三个字节。此字符集在 MySQL 8.0 中已弃用，您应该 utfmb4改用。
- utf8: 的别名 utf8mb3。在 MySQL 8.0 中，这个别名已被弃用；改用utf8mb4。 utf8预计在未来的版本中将成为 . 的别名utf8mb4。
- ucs2：Unicode 字符集的 UCS-2 编码，每个字符使用两个字节。在 MySQL 8.0.28 中弃用；您应该期望在未来的版本中删除对该字符集的支持。
- utf16：Unicode 字符集的 UTF-16 编码，每个字符使用两个或四个字节。喜欢 ucs2但带有补充字符的扩展名。
- utf16le: Unicode 字符集的 UTF-16LE 编码。喜欢utf16但小端而不是大端。
- utf32：Unicode 字符集的 UTF-32 编码，每个字符使用四个字节。

笔记

        该`utf8mb3`字符集已弃用，您应该期望在未来的 MySQL 版本中将其删除。请`utf8mb4`改用。
        `utf8`目前是 的别名
        `utf8mb3`，但现在已弃用，`utf8`预计随后会成为 的引用`utf8mb4`。从 MySQL 8.0.28 开始，`utf8mb3`也显示在
        `utf8`Information Schema 表的列和 SQL`SHOW`语句的输出中。

        此外，在 MySQL 8.0.30 中，所有使用前缀的排序规则都使用
        `utf8_`前缀重命名
        `utf8mb3_`。

        为避免 的含义出现歧义`utf8`，请考虑`utf8mb4`明确指定字符集引用。

      表 10.2，“Unicode 字符集一般特性”，总结了 MySQL 支持的 Unicode 字符集的一般特性。

**表 10.2 Unicode 字符集一般特征**

| 字符集 | 支持的字符 | 每个字符所需的存储空间 |
| --- | --- | --- |
| utf8mb3，utf8（已弃用） | 仅 BMP | 1、2 或 3 个字节 |
| ucs2 | 仅 BMP | 2个字节 |
| utf8mb4 | BMP和补充 | 1、2、3 或 4 个字节 |
| utf16 | BMP和补充 | 2 或 4 个字节 |
| utf16le | BMP和补充 | 2 或 4 个字节 |
| utf32 | BMP和补充 | 4字节 |

BMP 之外的字符在转换为仅支持 BMP 字符（或
      ）
    的 Unicode 字符集时
      比较为`REPLACEMENT CHARACTER`并转换为。`'?'``utf8mb3``ucs2`

      如果您使用支持增补字符的字符集，因此比 BMP-only
      和字符集“更宽”，则您的应用程序可能存在不兼容问题；参见第 10.9.8 节，“在 3 字节和 4 字节 Unicode 字符集之间转换”。该部分还描述了如何将表从 (3-byte)转换为 (4-byte)
       ，以及这样做可能适用的约束。
    `utf8mb3``ucs2``utf8mb3``utf8mb4`

      大多数 Unicode 字符集都可以使用一组类似的排序规则。例如，每个都有丹麦语排序规则，其名称为`utf8mb4_danish_ci`、
       `utf8mb3_danish_ci`（已弃用）、
       `utf8_danish_ci`（已弃用）、
       `ucs2_danish_ci`、
      `utf16_danish_ci`和
      `utf32_danish_ci`。例外是
      `utf16le`，它只有两个排序规则。有关 Unicode 归类及其区分属性（包括增补字符的归类属性）的信息，请参阅第 10.10.1 节，“Unicode 字符集”。

      UCS-2、UTF-16 和 UTF-32 的 MySQL 实现以大端字节顺序存储字符，并且不在值的开头使用字节顺序标记 (BOM)。其他数据库系统可能使用小端字节序或 BOM。在这种情况下，在这些系统和 MySQL 之间传输数据时需要执行值的转换。UTF-16LE 的实现是小端。

      MySQL 不对 UTF-8 值使用 BOM。

      使用 Unicode 与服务器通信的客户端应用程序应相应地设置客户端字符集（例如，通过发出`SET NAMES 'utf8mb4'`语句）。某些字符集不能用作客户端字符集。尝试将它们与`SET NAMES`or一起使用`SET CHARACTER SET`会产生错误。请参阅
      不允许的客户端字符集。

      以下部分提供了有关 MySQL 中 Unicode 字符集的更多详细信息。

---

[← 返回 第 10 章 字符集、排序规则、Unicode 索引](00-index.md) · [← 返回总索引](../00-index.md)
