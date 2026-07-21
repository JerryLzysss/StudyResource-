---

[← 返回目录](../README.md) | [← Maven Web 应用](./21-web-app.md) | [附录 →](./23-appendix.md)

---

# Maven 与 IDE 集成

### 22.1 Eclipse（m2e）

新版 Eclipse 自带 Maven。能力包括：运行目标、看控制台输出、更新依赖、按 pom 管理 classpath、工作区项目互依赖、从远程下源码、新建/导入向导、仓库搜索等。

导入：`File > Import > Maven > Existing Maven Projects`。

构建：右键项目 → `Run As` → `Maven package`。

若没有 Maven 选项，可将工程转为 Maven Project，或执行 `mvn eclipse:clean` 后重新 Convert。

### 22.2 NetBeans

NetBeans 6.7+ 内置 Maven。打开：`File > Open Project`（选含 pom 的目录）。构建：右键 → `Clean and Build`。运行：右键主类 → `Run File`。

### 22.3 IntelliJ IDEA

IDEA 内置 Maven。导入：`File > New > Project from Existing Sources`（或 Open）选 pom。构建：`Build > Rebuild Project`。运行：右键 `App.main()`。Maven 工具窗口可执行各生命周期与目标。

---
