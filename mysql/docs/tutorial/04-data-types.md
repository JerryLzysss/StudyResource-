# 04 数据类型

> 独立模块。对应 SQL：[`sql/tutorial/04-data-types.sql`](../../sql/tutorial/04-data-types.sql)

---

## 数值类型

| 类型 | 大小 | 用途 |
|------|------|------|
| TINYINT | 1 字节 | 小整数 |
| SMALLINT | 2 字节 | 整数 |
| INT / INTEGER | 4 字节 | 常用整数 |
| BIGINT | 8 字节 | 大整数 |
| FLOAT | 4 字节 | 单精度浮点 |
| DOUBLE | 8 字节 | 双精度浮点 |
| DECIMAL(M,D) | 视 M,D | 精确小数（金额等） |

## 日期时间类型

| 类型 | 格式 | 用途 |
|------|------|------|
| DATE | YYYY-MM-DD | 日期 |
| TIME | HH:MM:SS | 时间 |
| DATETIME | YYYY-MM-DD HH:MM:SS | 日期时间 |
| TIMESTAMP | 时间戳 | 自动更新场景常用 |
| YEAR | YYYY | 年份 |

## 字符串类型

| 类型 | 用途 |
|------|------|
| CHAR(n) | 定长字符串 |
| VARCHAR(n) | 变长字符串 |
| TEXT / BLOB | 长文本 / 二进制 |
| ENUM / SET | 枚举 / 集合 |

[← 返回教程索引](00-index.md)
