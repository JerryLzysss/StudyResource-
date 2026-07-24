# 第 12 章 函数和运算符 · JSON 函数

> 对应 SQL：[`sql/refman/ch12-functions/09-json-functions.sql`](../../../sql/refman/ch12-functions/09-json-functions.sql)

---

## 12.18 JSON函数

    本节中描述的函数对 JSON 值执行操作。有关`JSON`
    数据类型的讨论和显示如何使用这些函数的其他示例，请参阅第 11.5 节，“JSON 数据类型”。

    对于采用 JSON 参数的函数，如果参数不是有效的 JSON 值，则会发生错误。解析为 JSON 的参数由*`json_doc`*;表示 指示的参数*`val`*不被解析。

    返回 JSON 值的函数始终执行这些值的规范化（请参阅JSON 值的规范化、合并和自动包装），从而对它们进行排序。*排序的确切结果随时可能发生变化；不要依赖它在版本之间保持一致*。

    还提供了一组用于操作 GeoJSON 值的空间函数。请参阅第 12.17.11 节，“空间 GeoJSON 函数”。

---

[← 返回 第 12 章 函数和运算符 索引](00-index.md) · [← 返回总索引](../00-index.md)
