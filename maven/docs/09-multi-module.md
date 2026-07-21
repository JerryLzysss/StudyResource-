---

[← 返回目录](../README.md) | [← Maven 依赖机制](./08-dependencies.md) | [Maven 仓库 →](./10-repositories.md)

---

# Maven 多模块项目

父项目包含多个子模块，可单独或整体构建。

### 9.1 优势与场景

- 代码复用、职责分离、只构建变更模块、统一依赖与版本
- 适用：分层（web/service/dao）、微服务、common 模块

### 9.2 目录结构

```text
parent-project/
├── pom.xml          # packaging=pom
├── module-a/
│   └── pom.xml
├── module-b/
│   └── pom.xml
└── module-web/
    └── pom.xml
```

### 9.3 父 POM

```xml
<groupId>com.example</groupId>
<artifactId>parent-project</artifactId>
<version>1.0.0</version>
<packaging>pom</packaging>

<modules>
    <module>module1</module>
    <module>module2</module>
</modules>
```

### 9.4 子模块

```xml
<parent>
    <groupId>com.example</groupId>
    <artifactId>parent-project</artifactId>
    <version>1.0.0</version>
</parent>
<artifactId>module1</artifactId>
```

模块间依赖：

```xml
<dependency>
    <groupId>com.example</groupId>
    <artifactId>module1</artifactId>
    <version>${project.version}</version>
</dependency>
```

### 9.5 构建命令

```bash
mvn clean install                    # 全部
mvn -pl module1 clean install        # 单模块
mvn -pl module1 -am clean install    # 模块及其依赖
```

### 9.6 注意

- 避免循环依赖
- 用 `dependencyManagement` 统一版本
- 父 POM 集中管理公共依赖

---
