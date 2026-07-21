---

[← 返回目录](../README.md) | [← Maven POM](./04-pom.md) | [Maven 构建配置文件（Profile） →](./06-profile.md)

---

# Maven 构建生命周期

Maven 有三个标准生命周期：

| 生命周期 | 作用 |
|----------|------|
| **clean** | 清理项目 |
| **default（build）** | 核心构建 |
| **site** | 生成站点文档 |

每个生命周期由多个 **阶段（phase）** 组成，执行某阶段时会按顺序执行其之前的所有阶段。

### 5.1 clean

| 阶段 | 说明 |
|------|------|
| `pre-clean` | 清理前准备 |
| `clean` | 删除 `target/`（`maven-clean-plugin:clean`） |
| `post-clean` | 清理后收尾 |

```bash
mvn clean
```

### 5.2 default（常用阶段）

| 阶段 | 描述 |
|------|------|
| validate | 校验项目 |
| compile | 编译主代码 |
| test | 单元测试 |
| package | 打包 jar/war |
| verify | 质量检查 |
| install | 安装到本地仓库 |
| deploy | 部署到远程仓库 |

```bash
mvn compile
mvn test
mvn package
mvn install
mvn deploy
```

完整 default 生命周期还有 initialize、process-resources、test-compile、integration-test 等共约 23 个阶段。

### 5.3 site

```bash
mvn site          # 生成到 target/site/
mvn site-deploy   # 部署站点
```

### 5.4 阶段与插件目标混合调用

```bash
mvn clean dependency:copy-dependencies package
```

先执行 clean，再执行插件目标，最后执行 package。

### 5.5 常用组合

```bash
mvn install        # 开发：构建并装本地仓
mvn clean deploy   # 发布：清理后部署（含多模块）
```

---
