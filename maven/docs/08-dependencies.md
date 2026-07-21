---

[← 返回目录](../README.md) | [← Maven 常用命令](./07-commands.md) | [Maven 多模块项目 →](./09-multi-module.md)

---

# Maven 依赖机制

在 `pom.xml` 中声明依赖后，Maven 从仓库自动下载该库及其传递依赖。

### 8.1 坐标

- `groupId`：组织（如 `org.apache`）
- `artifactId`：构件名（如 `commons-lang3`）
- `version`：版本（如 `3.12.0`）

### 8.2 依赖范围（Scope）

| Scope | 编译 | 测试 | 运行 | 是否打包 | 典型用途 |
|-------|------|------|------|----------|----------|
| compile（默认） | ✓ | ✓ | ✓ | 是 | 核心依赖 |
| provided | ✓ | ✓ | ✗ | 否 | 容器/JDK 提供 |
| runtime | ✗ | ✓ | ✓ | 是 | JDBC 驱动等 |
| test | ✗ | ✓ | ✗ | 否 | JUnit |
| system | ✓ | ✓ | ✗ | 否 | 本地 jar（需 systemPath） |

### 8.3 传递性依赖

A → B → C 时，A 自动获得 C。可用 exclusions 排除、optional 标记可选。

```xml
<dependency>
    <groupId>com.example</groupId>
    <artifactId>example-library</artifactId>
    <version>1.0</version>
    <exclusions>
        <exclusion>
            <groupId>org.unwanted</groupId>
            <artifactId>unwanted-dependency</artifactId>
        </exclusion>
    </exclusions>
</dependency>
```

### 8.4 依赖调解

版本冲突时：

1. **最短路径优先**
2. 路径长度相同时，**先声明优先**

### 8.5 BOM 导入

```xml
<dependencyManagement>
    <dependencies>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-dependencies</artifactId>
            <version>2.6.4</version>
            <type>pom</type>
            <scope>import</scope>
        </dependency>
    </dependencies>
</dependencyManagement>
```

### 8.6 最佳实践

- 明确版本，避免 `LATEST` / `RELEASE`
- 定期 `mvn versions:display-dependency-updates`
- 大型框架用 BOM
- 定期 `mvn dependency:analyze` 清理无用依赖

---
