---

[← 返回目录](../README.md) | [← Maven 简介](./01-intro.md) | [Maven 第一个项目 →](./03-first-project.md)

---

# Maven 环境配置

Maven 基于 Java，需先安装 JDK（推荐 JDK 8 / 11 / 17）。

### 2.1 系统要求

| 项目 | 要求 |
|------|------|
| JDK | Maven 3.3+ 需 JDK 1.7+；3.2 需 1.6+；3.0/3.1 需 1.5+ |
| 内存 | 无硬性最低要求 |
| 磁盘 | 安装约 10MB；本地仓库建议至少预留 500MB |
| OS | 无特殊要求 |

### 2.2 检查 Java

```bash
java -version
```

### 2.3 下载与解压

下载地址：[http://maven.apache.org/download.cgi](http://maven.apache.org/download.cgi)

| 系统 | 包名示例 | 解压位置示例 |
|------|----------|--------------|
| Windows | `apache-maven-*-bin.zip` | `E:\Maven\apache-maven-3.x.x` |
| Linux / Mac | `apache-maven-*-bin.tar.gz` | `/usr/local/apache-maven-3.x.x` |

### 2.4 配置环境变量

**Windows**

1. 新建系统变量 `MAVEN_HOME` = Maven 解压目录
2. 在 `Path` 中追加：`%MAVEN_HOME%\bin`

**Linux / Mac**

```bash
export MAVEN_HOME=/usr/local/apache-maven-3.x.x
export PATH=${PATH}:${MAVEN_HOME}/bin
# 写入 /etc/profile 后执行：
source /etc/profile
```

### 2.5 验证安装

```bash
mvn -v
```

应输出 Maven 版本、Java 版本、操作系统等信息。

### 2.6 配置本地仓库（可选）

默认路径：

- Windows：`C:\Users\<用户名>\.m2\repository`
- Linux/macOS：`~/.m2/repository`

在 `MAVEN_HOME/conf/settings.xml` 中修改：

```xml
<localRepository>/path/to/your/repo</localRepository>
```

---
