---

[← 返回目录](../README.md) | [← Maven 构建与项目测试](./13-build-test.md) | [Maven 项目模板（Archetype） →](./15-archetype.md)

---

# Maven 引入外部依赖

仓库中没有、仅有本地 jar 时，可用 `system` 作用域：

1. 将 jar 放到如 `src/lib/` 或 `src/main/resources/`
2. 在 pom 中声明：

```xml
<dependency>
    <groupId>ldapjdk</groupId>
    <artifactId>ldapjdk</artifactId>
    <version>1.0</version>
    <scope>system</scope>
    <systemPath>${basedir}/src/lib/ldapjdk.jar</systemPath>
</dependency>
```

或：

```xml
<systemPath>${project.basedir}/src/main/resources/Name_Your_JAR.jar</systemPath>
```

> 注意：`system` 依赖不利于移植与发布，优先考虑 `mvn install:install-file` 装进本地仓，或发布到私服。

---
