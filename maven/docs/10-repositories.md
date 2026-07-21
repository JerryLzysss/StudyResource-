---

[← 返回目录](../README.md) | [← Maven 多模块项目](./09-multi-module.md) | [Maven 插件 →](./11-plugins.md)

---

# Maven 仓库

仓库存放 JAR、WAR、POM 等构件。

| 类型 | 位置 | 作用 | 优先级 |
|------|------|------|--------|
| 本地仓库 | `~/.m2/repository` | 缓存 | 1 |
| 中央仓库 | repo.maven.apache.org | 官方默认 | 2.1 |
| 私服 | Nexus 等 | 私有/加速 | 2.2 |
| 其他公共仓 | 阿里云等 | 镜像/补充 | 2.3 |

### 10.1 查找顺序

1. 本地仓库
2. 中央仓库（找到则下载到本地）
3. 若配置了远程仓库则继续搜索
4. 都找不到则构建失败

### 10.2 阿里云镜像（推荐）

在 `settings.xml` 的 `<mirrors>` 中：

```xml
<mirror>
    <id>aliyunmaven</id>
    <mirrorOf>*</mirrorOf>
    <name>阿里云公共仓库</name>
    <url>https://maven.aliyun.com/repository/public</url>
</mirror>
```

### 10.3 私服发布

`pom.xml`：

```xml
<distributionManagement>
    <repository>
        <id>nexus-releases</id>
        <url>http://your-nexus/repository/maven-releases</url>
    </repository>
    <snapshotRepository>
        <id>nexus-snapshots</id>
        <url>http://your-nexus/repository/maven-snapshots</url>
    </snapshotRepository>
</distributionManagement>
```

`settings.xml` 配置同 id 的 username/password，然后：

```bash
mvn deploy
```

---
