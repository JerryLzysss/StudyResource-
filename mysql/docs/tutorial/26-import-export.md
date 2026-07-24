# 26 导出 / 导入数据

> 独立模块。对应 SQL：[`sql/tutorial/26-import-export.sql`](../../sql/tutorial/26-import-export.sql)

---

## 命令行

```bash
mysqldump -u root -p W3CSCHOOL > w3cschool_backup.sql
mysqldump -u root -p W3CSCHOOL w3cschool_tbl > w3cschool_tbl.sql
mysql -u root -p W3CSCHOOL < w3cschool_backup.sql
```

## SQL 方式（需服务器文件权限，默认注释）

[← 返回教程索引](00-index.md)
