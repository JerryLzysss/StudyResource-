---

[← 返回目录](../README.md) | [← Maven 构建 Java 项目](./12-java-project.md) | [Maven 引入外部依赖 →](./14-external-deps.md)

---

# Maven 构建与项目测试

进入项目目录：

```bash
mvn clean package
```

关键点：

- 清理后打包，生成 `target/*-SNAPSHOT.jar`
- 测试报告在 `target/surefire-reports`
- 会编译主代码与测试代码并跑测试

运行：

```bash
java -cp target/classes com.companyname.bank.App
```

添加新类后：

```bash
mvn clean compile
java -cp target/classes com.companyname.bank.App
```

---
