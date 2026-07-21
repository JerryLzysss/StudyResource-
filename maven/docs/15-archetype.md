---

[← 返回目录](../README.md) | [← Maven 引入外部依赖](./14-external-deps.md) | [Maven 项目文档 →](./16-documentation.md)

---

# Maven 项目模板（Archetype）

Archetype 是项目模板插件，用于按模板生成标准结构。

交互式创建：

```bash
mvn archetype:generate
```

按提示选择原型（默认常为 `maven-archetype-quickstart`）、版本，再填写 groupId、artifactId、version、package。

非交互见第 3、12 章。生成后会得到标准目录、`pom.xml`、`App.java`、`AppTest.java`。

---
