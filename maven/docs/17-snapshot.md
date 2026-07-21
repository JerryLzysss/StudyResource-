---

[← 返回目录](../README.md) | [← Maven 项目文档](./16-documentation.md) | [Maven 自动化构建 →](./18-automation.md)

---

# Maven 快照（SNAPSHOT）

多团队协作时，若后台库频繁更新，每次升 Release 版本会导致：

- 需不断通知依赖方
- 依赖方需频繁改 pom 版本号

**SNAPSHOT** 表示开发中副本；同坐标（如 `1.0-SNAPSHOT`）每次构建可检查并拉取最新快照。Release（如 `1.0`）一旦下载，同版本一般不再更新。

依赖 SNAPSHOT：

```xml
<dependency>
    <groupId>data-service</groupId>
    <artifactId>data-service</artifactId>
    <version>1.0-SNAPSHOT</version>
</dependency>
```

强制更新：

```bash
mvn clean package -U
```

**正式生产环境勿使用 SNAPSHOT 依赖**，以保证可重复构建。

---
