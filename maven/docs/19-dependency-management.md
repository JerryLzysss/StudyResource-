---

[← 返回目录](../README.md) | [← Maven 自动化构建](./18-automation.md) | [Maven 自动化部署 →](./20-deployment.md)

---

# Maven 依赖管理

多模块时依赖图复杂，Maven 通过传递依赖与多种控制手段管理。

| 功能 | 说明 |
|------|------|
| 依赖调解 | 冲突时最短路径优先；同深度则先声明优先 |
| 依赖管理 | 用 `dependencyManagement` 锁定版本 |
| 依赖范围 | 控制各阶段是否参与 |
| 依赖排除 | `exclusions` 去掉传递依赖 |
| 依赖可选 | `optional=true` 不向下游传递 |

父 POM 集中声明公共依赖后，子模块继承；Web 模块只需声明对本模块的直接依赖，传递依赖由 Maven 解析。

Scope 补充：**import** 仅用于 `dependencyManagement` 中导入 BOM 型 pom。

---
