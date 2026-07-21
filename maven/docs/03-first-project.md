---

[← 返回目录](../README.md) | [← Maven 环境配置](./02-setup.md) | [Maven POM →](./04-pom.md)

---

# Maven 第一个项目

### 3.1 用 Archetype 生成项目

```bash
mvn archetype:generate \
    -DgroupId=com.example \
    -DartifactId=my-first-app \
    -DarchetypeArtifactId=maven-archetype-quickstart \
    -DinteractiveMode=false
```

| 参数 | 说明 |
|------|------|
| `-DgroupId` | 组织标识（常用域名倒写） |
| `-DartifactId` | 项目名（也是目录名） |
| `-DarchetypeArtifactId` | 模板，`quickstart` 为普通 Java 项目 |
| `-DinteractiveMode=false` | 非交互模式 |

### 3.2 生成结构

```text
my-first-app/
├── pom.xml
├── src/
│   ├── main/java/com/example/App.java
│   └── test/java/com/example/AppTest.java
```

### 3.3 示例代码

**App.java**

```java
package com.example;

public class App {
    public static void main(String[] args) {
        System.out.println("Hello Maven!");
    }
}
```

**AppTest.java**

```java
package com.example;

import org.junit.Test;
import static org.junit.Assert.*;

public class AppTest {
    @Test
    public void testApp() {
        assertTrue(true);
    }
}
```

### 3.4 构建与运行

| 命令 | 作用 |
|------|------|
| `mvn compile` | 编译 |
| `mvn test` | 运行测试 |
| `mvn package` | 打包 jar |
| `mvn install` | 安装到本地仓库 |
| `mvn clean` | 清理 target |

```bash
mvn package
java -cp target/my-first-app-1.0-SNAPSHOT.jar com.example.App
# 输出：Hello Maven!
```

### 3.5 添加依赖示例（Gson）

```xml
<dependency>
    <groupId>com.google.code.gson</groupId>
    <artifactId>gson</artifactId>
    <version>2.8.9</version>
</dependency>
```

再执行 `mvn compile`，Maven 会自动下载依赖。

### 3.6 常见问题

**依赖下载失败**：配置阿里云镜像（见第 10 章）。

**编译版本错误**（如 `invalid target release: 11`）：

```xml
<properties>
    <maven.compiler.source>11</maven.compiler.source>
    <maven.compiler.target>11</maven.compiler.target>
</properties>
```

---
