# 配置 Jest

参考文档: [配置 Jest](https://jest.nodejs.cn/docs/configuration)

完整配置与 API 参考见 [配置选项](../配置选项/)：

- [配置 Jest 全文](../配置选项/配置Jest.md)
- [配置选项索引](../配置选项/配置选项索引.md)

## 常用项（速查）

| 选项 | 含义 |
|------|------|
| `testEnvironment` | `node` / `jsdom` 等 |
| `roots` | 搜索测试的根目录 |
| `testMatch` / `testRegex` | 哪些文件是测试 |
| `moduleNameMapper` | 路径别名、静态资源 mock（webpack 场景常用） |
| `moduleDirectories` / `moduleFileExtensions` | 解析目录与扩展名 |
| `setupFilesAfterEnv` | 每个测试文件环境就绪后执行的脚本 |
| `collectCoverageFrom` | 覆盖率收集范围 |
| `transform` | 转译规则（如 babel-jest、ts-jest） |

生成引导配置：`npm init jest@latest`。与 webpack 资源/别名对接见 [与 webpack 一起使用](https://jest.nodejs.cn/docs/webpack)。
