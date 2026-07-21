---

[← 返回目录](../README.md) | [Maven 环境配置 →](./02-setup.md)

---

# Maven 简介

Maven 翻译为「专家」「内行」，是 Apache 旗下用纯 Java 开发的开源项目管理工具。基于 **项目对象模型（POM）**，Maven 用一份中央配置管理项目的构建、报告与文档。

Maven 主要解决两件事：

1. **软件如何构建**
2. **软件的依赖关系**

也可用于构建和管理 C#、Ruby、Scala 等语言的项目。它曾是 Jakarta 子项目，现为 Apache 独立项目。

### 1.1 阅读前需要的基础

- Java 基础

### 1.2 Maven 功能

- 构建
- 文档生成
- 报告
- 依赖管理
- SCMs
- 发布 / 分发
- 邮件列表

### 1.3 Maven 特点

1. **约定优于配置**：标准化目录结构与构建生命周期
2. **依赖管理**：自动处理依赖关系
3. **插件体系**：用插件完成各类构建任务
4. **多模块支持**：便于大型项目管理
5. **中央仓库**：共享全球库资源

### 1.4 标准目录约定

| 目录 | 目的 |
|------|------|
| `${basedir}` | 存放 `pom.xml` 及所有子目录 |
| `${basedir}/src/main/java` | 主 Java 源码 |
| `${basedir}/src/main/resources` | 主资源（properties、spring 配置等） |
| `${basedir}/src/test/java` | 测试源码（如 JUnit） |
| `${basedir}/src/test/resources` | 测试资源 |
| `${basedir}/src/main/webapp/WEB-INF` | Web 应用（web.xml、JSP 等） |
| `${basedir}/target` | 打包输出目录 |
| `${basedir}/target/classes` | 编译输出 |
| `${basedir}/target/test-classes` | 测试编译输出 |
| `*Test.java` | Maven 默认只自动运行符合该命名规则的测试类 |
| `~/.m2/repository` | 默认本地仓库 |

### 1.5 与其他构建工具对比

| 工具 | 特点 | 适用场景 |
|------|------|----------|
| Maven | XML 配置，依赖管理强，流程标准化 | 传统 Java 项目 |
| Gradle | Groovy/Kotlin DSL，更灵活、性能更好 | Android、Kotlin、需高度自定义 |
| Ant | 手动编写构建步骤 | 遗留项目、需精细控制 |

### 1.6 SNAPSHOT 与 Release（补充）

- **SNAPSHOT**：不稳定、开发中版本；构建时会检查远程是否有更新
- **Release**：稳定版本；同版本一般不再重复下载
- 协同开发中频繁变更的构件宜用 SNAPSHOT；**正式环境不要使用 SNAPSHOT 依赖**

---
