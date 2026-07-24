# 25 SQL 注入防范

> 概念模块（无独立 SQL）

---

不要把用户输入直接拼进 SQL。应使用：

- 预编译 / 参数绑定（Prepared Statement）
- 对输入做校验与转义
- 最小权限账号访问数据库

危险示例（勿在生产使用）：

```sql
-- 假设输入 author = "' OR '1'='1"
-- SELECT * FROM w3cschool_tbl WHERE w3cschool_author = '' OR '1'='1';
```

正确思路：使用占位符 `?` 绑定参数，而不是字符串拼接。

[← 返回教程索引](00-index.md)
