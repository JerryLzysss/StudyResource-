---

[← 返回目录](../README.md) | [← Maven 第一个项目](./03-first-project.md) | [Maven 构建生命周期 →](./05-lifecycle.md)

---

# Maven POM

POM（Project Object Model）是 Maven 核心配置文件，默认名为 `pom.xml`。执行目标时，Maven 在当前目录查找 POM，读取配置后执行。

POM 中可配置：项目依赖、插件、执行目标、Profile、版本、开发者、邮件列表等。

### 4.1 必需坐标

所有 POM 都需要 `project` 以及三个必需字段：

| 节点 | 描述 |
|------|------|
| `project` | 根标签 |
| `modelVersion` | 固定为 `4.0.0` |
| `groupId` | 组织标识 |
| `artifactId` | 项目标识 |
| `version` | 版本号 |

```xml
<project>
    <modelVersion>4.0.0</modelVersion>
    <groupId>com.example</groupId>
    <artifactId>my-app</artifactId>
    <version>1.0.0</version>
    <packaging>jar</packaging>
    <name>My Application</name>
    <description>A demo project</description>
    <url>https://example.com</url>
</project>
```

### 4.2 依赖

```xml
<dependencies>
    <dependency>
        <groupId>junit</groupId>
        <artifactId>junit</artifactId>
        <version>4.12</version>
        <scope>test</scope>
    </dependency>
</dependencies>
```

| 元素 | 说明 |
|------|------|
| `groupId` / `artifactId` / `version` | 依赖坐标 |
| `scope` | `compile` / `test` / `provided` / `runtime` 等 |
| `optional` | 是否可选（默认 false） |

### 4.3 插件

```xml
<build>
    <plugins>
        <plugin>
            <groupId>org.apache.maven.plugins</groupId>
            <artifactId>maven-compiler-plugin</artifactId>
            <version>3.8.1</version>
            <configuration>
                <source>1.8</source>
                <target>1.8</target>
            </configuration>
        </plugin>
    </plugins>
</build>
```

### 4.4 properties / repositories / dependencyManagement / profiles

```xml
<properties>
    <java.version>11</java.version>
    <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
</properties>

<repositories>
    <repository>
        <id>aliyun</id>
        <url>https://maven.aliyun.com/repository/public</url>
    </repository>
</repositories>

<dependencyManagement>
    <dependencies>
        <dependency>
            <groupId>org.springframework</groupId>
            <artifactId>spring-core</artifactId>
            <version>5.3.9</version>
        </dependency>
    </dependencies>
</dependencyManagement>

<profiles>
    <profile>
        <id>development</id>
        <properties>
            <environment>dev</environment>
        </properties>
    </profile>
</profiles>
```

### 4.5 继承与聚合

```xml
<!-- 继承 -->
<parent>
    <groupId>com.example</groupId>
    <artifactId>parent-project</artifactId>
    <version>1.0-SNAPSHOT</version>
</parent>

<!-- 聚合 -->
<modules>
    <module>module1</module>
    <module>module2</module>
</modules>
```

### 4.6 Super POM 与 Effective POM

所有 POM 都隐式继承 Super POM（含默认目录、插件、中央仓库等）。查看最终生效配置：

```bash
mvn help:effective-pom
```

---
