# MySQL 学习文档（模块化）

基于 [W3Cschool MySQL 教程](https://www.w3cschool.cn/mysql/mysql-tutorial.html) 与 MySQL 8.0 参考手册，按**一个主题 / 一个小节一个模块**组织。

## 目录结构

```
mysql/
├── README.md
├── docs/
│   ├── tutorial/              # 入门实操（按主题）
│   ├── functions/             # 函数专项（按函数组）
│   └── refman/                # 官方手册第 1–28 章
│       ├── 00-index.md        # 总索引
│       └── chXX-name/         # 每一章一个目录
│           ├── 00-index.md    # 章内小节索引
│           └── NN-*.md        # 每个小节独立文档
└── sql/
    ├── tutorial/
    ├── functions/
    └── refman/
        └── chXX-name/
            ├── 00-local-demo.sql   #（如有）章级本地演示
            └── NN-*.sql            # 与小节一一对应
```

## 快速开始

```bash
# 入门示例库
mysql -u root -p < sql/tutorial/00-setup.sql

# 官方手册：按「章目录 → 小节」执行
mysql -u root -p < sql/refman/ch10-charset/01-charset.sql
mysql -u root -p < sql/refman/ch28-sys-schema/03-sys-schema-usage.sql
```

## 模块索引

| 系列 | 索引 | 说明 |
|------|------|------|
| 官方手册 1–28 章 | [docs/refman/00-index.md](docs/refman/00-index.md) | **按章 → 按小节**拆分；原文已导入 |
| 入门实操 | [docs/tutorial/00-index.md](docs/tutorial/00-index.md) | 建库表、CRUD、JOIN、事务等 |
| 函数专项 | [docs/functions/00-index.md](docs/functions/00-index.md) | 日期/字符串/数学/高级函数 |

## 示例库

统一使用库 `W3CSCHOOL`、表 `w3cschool_tbl`（由 `sql/tutorial/00-setup.sql` 创建）。

## 参考

- [W3Cschool MySQL 入门教程](https://www.w3cschool.cn/mysql/mysql-tutorial.html)
- MySQL 8.0 参考手册（中文）
