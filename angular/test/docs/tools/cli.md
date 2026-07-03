# Angular CLI

Angular CLI 是一个命令行界面工具，允许你直接从命令行搭建、开发、测试、部署和维护 Angular 应用。

Angular CLI 以 `@angular/cli` 包的形式发布在 npm 上，包含名为 `ng` 的二进制文件。

## 安装

```bash
npm install -g @angular/cli
```

## 常用命令

| 命令 | 说明 |
|------|------|
| `ng new <name>` | 创建新项目 |
| `ng serve` | 启动开发服务器 |
| `ng build` | 构建生产版本 |
| `ng test` | 运行单元测试 |
| `ng generate <schematic>` | 生成代码（组件、服务等） |
| `ng add <package>` | 添加并配置 npm 包 |
| `ng update` | 更新 Angular 依赖 |
| `ng deploy` | 部署应用 |

## 代码生成 (Schematics)

```bash
# 生成组件
ng generate component my-component
ng g c my-component

# 生成服务
ng generate service my-service
ng g s my-service

# 生成模块
ng generate module my-module --routing
ng g m my-module --routing
```

## CLI 命令语法

### 布尔选项

- `--this-option` 设置为 `true`
- `--no-this-option` 设置为 `false`

### 数组选项

```bash
--option value1 value2
--option value1 --option value2
```

### 相对路径

文件路径可以是绝对路径，或相对于当前工作目录（通常是工作区或项目根目录）的相对路径。

## 构建器 (Builders)

Angular CLI 使用 builders 执行从源代码到构建输出的复杂转换。默认 builder 基于 Vite 和 esbuild，提供快速的现代化构建流水线。

## ng update

`ng update` 运行自动化代码转换，自动处理例行的破坏性变更，大大简化主版本更新：

```bash
ng update @angular/core @angular/cli
```

---

> 参考：[Angular CLI 文档](https://angular.cn/tools/cli)
