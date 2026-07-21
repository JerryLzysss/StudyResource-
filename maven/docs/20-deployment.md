---

[← 返回目录](../README.md) | [← Maven 依赖管理](./19-dependency-management.md) | [Maven Web 应用 →](./21-web-app.md)

---

# Maven 自动化部署

手工部署常见步骤：提交打标 → 拉代码 → 构建 → 上传产物 → 部署生产 → 更新文档与版本；多团队易出错。

推荐组合：

- Maven 构建与发布
- SVN/Git 管理源码
- Nexus / JFrog 管理二进制

使用 **maven-release-plugin**：

```bash
mvn release:clean
mvn release:prepare    # 检查、改版本、打 tag、升 SNAPSHOT 等
mvn release:perform    # checkout 标签并 deploy
mvn release:rollback   # 失败时回滚
```

pom 中需配置 SCM、`distributionManagement`、release 插件等。成功后可在仓库中验证已上传的 JAR/WAR。

---
