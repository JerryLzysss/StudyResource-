---

[← 返回目录](../README.md) | [← Maven 项目模板（Archetype）](./15-archetype.md) | [Maven 快照（SNAPSHOT） →](./17-snapshot.md)

---

# Maven 项目文档

配置站点插件后生成项目站点：

```xml
<build>
    <plugins>
        <plugin>
            <groupId>org.apache.maven.plugins</groupId>
            <artifactId>maven-site-plugin</artifactId>
            <version>3.3</version>
        </plugin>
        <plugin>
            <groupId>org.apache.maven.plugins</groupId>
            <artifactId>maven-project-info-reports-plugin</artifactId>
            <version>2.7</version>
        </plugin>
    </plugins>
</build>
```

```bash
mvn site
```

打开 `target/site/index.html` 查看。文档引擎为 **Doxia**，支持 Apt、Xdoc、FML、XHTML 等格式。

若出现 `NoClassDefFoundError: ...DocumentContent`，通常是 site 插件版本过低，升级到 3.3+。

---
