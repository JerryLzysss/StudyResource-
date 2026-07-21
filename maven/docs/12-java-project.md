---

[← 返回目录](../README.md) | [← Maven 插件](./11-plugins.md) | [Maven 构建与项目测试 →](./13-build-test.md)

---

# Maven 构建 Java 项目

使用 `maven-archetype-quickstart`：

```bash
mvn archetype:generate "-DgroupId=com.companyname.bank" "-DartifactId=consumerBanking" "-DarchetypeArtifactId=maven-archetype-quickstart" "-DinteractiveMode=false"
```

生成目录说明：

| 路径 | 描述 |
|------|------|
| consumerBanking/ | 含 src 与 pom.xml |
| src/main/java/... | 主代码 |
| src/test/java/... | 测试代码 |
| src/main/resources | 资源（常需手动创建） |

若 IDEA 创建项目卡在 `Generating project in Batch mode`（拉 archetype-catalog 慢），可：

1. 配置阿里云镜像
2. 加参数：`-DarchetypeCatalog=local`

---
