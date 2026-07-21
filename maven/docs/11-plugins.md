---

[← 返回目录](../README.md) | [← Maven 仓库](./10-repositories.md) | [Maven 构建 Java 项目 →](./12-java-project.md)

---

# Maven 插件

Maven 是依赖插件执行的框架；生命周期阶段由插件 **目标（goal）** 实现。

```bash
mvn [plugin-name]:[goal-name]
# 例：
mvn compiler:compile
```

### 11.1 内置绑定示例

| 阶段 | 插件目标 |
|------|----------|
| compile | maven-compiler-plugin:compile |
| test | maven-surefire-plugin:test |
| package | maven-jar-plugin:jar / maven-war-plugin:war |

### 11.2 常用插件

| 插件 | 作用 |
|------|------|
| maven-compiler-plugin | 编译，指定 Java 版本 |
| maven-resources-plugin | 资源处理 |
| maven-surefire-plugin | 单元测试 |
| maven-failsafe-plugin | 集成测试 |
| maven-jar-plugin / war-plugin | 打包 |
| maven-assembly-plugin | 自定义打包 |
| maven-install-plugin / deploy-plugin | 安装 / 部署 |
| maven-clean-plugin | 清理 |
| maven-javadoc-plugin | 生成 Javadoc |
| maven-antrun-plugin | 运行 Ant 任务 |

可执行 JAR 示例：

```xml
<plugin>
    <groupId>org.apache.maven.plugins</groupId>
    <artifactId>maven-jar-plugin</artifactId>
    <version>3.2.0</version>
    <configuration>
        <archive>
            <manifest>
                <mainClass>com.example.Main</mainClass>
            </manifest>
        </archive>
    </configuration>
</plugin>
```

插件分 **Build plugins**（在 `<build>`）与 **Reporting plugins**（在 `<reporting>`）。

---
