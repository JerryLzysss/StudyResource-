# Java 运行环境介绍

Java 程序的运行依赖 JDK / JRE / JVM 三层结构：

| 名称 | 全称 | 作用 |
|------|------|------|
| JVM | Java Virtual Machine | Java 虚拟机，负责执行字节码 |
| JRE | Java Runtime Environment | 运行环境，包含 JVM + 核心类库 |
| JDK | Java Development Kit | 开发工具包，包含 JRE + 编译/调试等工具 |

常用 JDK 工具：

- `javac`：编译 `.java` 源文件为 `.class` 字节码
- `java`：启动 JVM 运行程序
- `jdb`：调试工具
- `jhat`：堆内存分析工具（较旧，现代多用其他分析工具）

说明：从 JDK 9 起，JRE 不再单独发行，运行环境已整合进 JDK。

详见同目录下的 `jvm和跨平台.md`、`环境变量配置.md`。
