---

[← 返回目录](../README.md) | [← Maven 构建配置文件（Profile）](./06-profile.md) | [Maven 依赖机制 →](./08-dependencies.md)

---

# Maven 常用命令

命令模式：

```text
mvn [选项] [生命周期阶段] [目标]
```

### 7.1 基础构建

| 命令 | 作用 |
|------|------|
| `mvn -v` | 版本信息 |
| `mvn clean` | 清理 target |
| `mvn compile` | 编译主代码 |
| `mvn test` | 运行测试 |
| `mvn package` | 打包 |
| `mvn install` | 安装到本地仓 |
| `mvn deploy` | 部署到远程仓 |
| `mvn site` | 生成站点 |

### 7.2 依赖

| 命令 | 作用 |
|------|------|
| `mvn dependency:tree` | 依赖树 |
| `mvn dependency:analyze` | 分析未用/未声明依赖 |
| `mvn dependency:copy-dependencies` | 复制依赖到目录 |
| `mvn versions:display-dependency-updates` | 检查依赖更新 |

### 7.3 项目创建

```bash
# Java 项目
mvn archetype:generate -DgroupId=com.mycompany.app -DartifactId=my-app \
  -DarchetypeArtifactId=maven-archetype-quickstart -DinteractiveMode=false

# Web 项目
mvn archetype:generate -DgroupId=com.mycompany.app -DartifactId=my-web-app \
  -DarchetypeArtifactId=maven-archetype-webapp -DinteractiveMode=false
```

### 7.4 测试相关

```bash
mvn test -Dtest=UserServiceTest
mvn test -Dtest=UserServiceTest#testCreate
mvn package -DskipTests
```

### 7.5 多模块

```bash
mvn -pl service compile
mvn -am -pl web compile
mvn -rf moduleName install
```

### 7.6 高级选项

| 选项 | 作用 |
|------|------|
| `-U` | 强制更新 SNAPSHOT |
| `-o` | 离线模式 |
| `-X` | 调试输出 |
| `-T 4` | 4 线程并行构建 |
| `-P production` | 激活 Profile |

```bash
mvn clean install
mvn clean package -DskipTests
mvn clean install -U
```

---
