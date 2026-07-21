---

[← 返回目录](../README.md) | [← Maven 构建生命周期](./05-lifecycle.md) | [Maven 常用命令 →](./07-commands.md)

---

# Maven 构建配置文件（Profile）

Profile 可为不同环境（开发 / 测试 / 生产）定制构建参数。

### 6.1 定义位置

| 类型 | 位置 |
|------|------|
| 项目级 | 项目 `pom.xml` |
| 用户级 | `~/.m2/settings.xml` |
| 全局 | `$M2_HOME/conf/settings.xml` |

### 6.2 激活方式

1. 命令行显式：`mvn test -Ptest`
2. settings.xml 中 `activeProfiles`
3. 环境变量 / `-D` 属性
4. 操作系统条件
5. 文件存在或缺省

示例（命令行）：

```bash
mvn test -Pprod
```

settings.xml：

```xml
<activeProfiles>
    <activeProfile>test</activeProfile>
</activeProfiles>
```

基于属性：

```xml
<profile>
    <id>test</id>
    <activation>
        <property>
            <name>env</name>
            <value>test</value>
        </property>
    </activation>
</profile>
```

```bash
mvn test -Denv=test
```

---
