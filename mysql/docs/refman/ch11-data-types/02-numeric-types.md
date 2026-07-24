# 第 11 章 数据类型 · 数值类型

> 对应 SQL：[`sql/refman/ch11-data-types/02-numeric-types.sql`](../../../sql/refman/ch11-data-types/02-numeric-types.sql)

---

## 11.1 数值数据类型

      MySQL 支持所有标准的 SQL 数字数据类型。这些类型包括精确数值数据类型（`INTEGER`、
       `SMALLINT`、
      `DECIMAL`和
      `NUMERIC`），以及近似数值数据类型（`FLOAT`、
      `REAL`和
      `DOUBLE PRECISION`）。关键字
      `INT`是 的同义词
      `INTEGER`，关键字
      `DEC`和
      `FIXED`是 的同义词
      `DECIMAL`。MySQL 将
      其视为（非标准扩展）`DOUBLE`的同义词
      。除非启用 SQL 模式
    ，否则`DOUBLE PRECISION`MySQL 也将其视为
      （非标准变体）
      `REAL`
      的同义词。`DOUBLE PRECISION``REAL_AS_FLOAT`

数据类型存储位值并
      `BIT`支持
      、`MyISAM`、
      `MEMORY`和
      表。
    `InnoDB``NDB`

      有关 MySQL 如何处理将超出范围的值分配给列以及表达式评估期间溢出的信息，请参阅
      第 11.1.7 节，“超出范围和溢出处理”。

      有关数字数据类型的存储要求的信息，请参阅第 11.7 节，“数据类型存储要求”。

      有关对数值进行运算的函数的说明，请参阅
      第 12.6 节，“数值函数和运算符”。用于数字操作数计算结果的数据类型取决于操作数的类型和对它们执行的操作。有关详细信息，请参阅第 12.6.1 节，“算术运算符”。

---

[← 返回 第 11 章 数据类型 索引](00-index.md) · [← 返回总索引](../00-index.md)
