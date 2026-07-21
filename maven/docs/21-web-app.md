---

[← 返回目录](../README.md) | [← Maven 自动化部署](./20-deployment.md) | [Maven 与 IDE 集成 →](./22-ide.md)

---

# Maven Web 应用

使用 `maven-archetype-webapp`：

```bash
mvn archetype:generate -DgroupId=com.companyname.automobile \
  -DartifactId=trucks -DarchetypeArtifactId=maven-archetype-webapp \
  -DinteractiveMode=false
```

目录要点：

| 路径 | 描述 |
|------|------|
| src/main/webapp | index.jsp、静态资源 |
| src/main/webapp/WEB-INF | web.xml |
| packaging | `war` |

构建：

```bash
mvn clean package
# 生成 target/trucks.war
```

将 war 复制到应用服务器 webapps 目录并重启，访问：

```text
http://host:port/trucks/index.jsp
```

---
