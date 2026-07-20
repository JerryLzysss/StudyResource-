# JVM 和跨平台

## JVM（Java Virtual Machine）

JVM 是 Java 虚拟机。不同操作系统（Windows、Linux、macOS 等）各自有对应的 JVM 实现。

开发者只需把 `.java` 编译成平台无关的字节码（`.class`），由目标平台上的 JVM 解释/执行。这就是常说的「一次编译，到处运行」。

## JDK 和 JRE

| 名称 | 含义 |
|------|------|
| JDK（Java Development Kit） | Java 开发工具包 |
| JRE（Java Runtime Environment） | Java 运行环境，包含 JVM 以及核心类库 |

从 JDK 9 之后，JRE 被整合进 JDK，一般不再单独安装 JRE。
