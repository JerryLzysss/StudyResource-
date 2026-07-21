---

[← 返回目录](../README.md) | [← Maven 快照（SNAPSHOT）](./17-snapshot.md) | [Maven 依赖管理 →](./19-dependency-management.md)

---

# Maven 自动化构建

结合生命周期、命令与 CI，可将构建固化为可重复流水线。

典型本地/CI 流程：

```bash
mvn clean compile test package
# 或
mvn clean verify
mvn clean install
```

要点：

- 用标准阶段代替手工脚本
- 用 Profile 区分环境
- 多模块用 reactor（`-pl` / `-am`）精细构建
- CI（Jenkins、GitHub Actions 等）中固定 JDK/Maven 版本并执行上述命令
- 依赖与插件尽量锁版本，保证可重复

自动化构建与「自动化部署」衔接：构建产物（jar/war）再进入发布仓库或应用服务器。

---
