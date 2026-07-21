# Jest 平台

参考文档: [Jest 平台](https://jest.nodejs.cn/docs/jest-platform)

Jest 不只是一个测试运行器，而是一组可独立使用的包（Jest Platform）。常见包括：

| 包 | 作用 |
|----|------|
| `jest-cli` | 命令行入口 |
| `jest-runner` | 测试运行逻辑 |
| `jest-environment-node` / `jest-environment-jsdom` | 测试环境 |
| `jest-haste-map` | 文件/依赖图 |
| `jest-resolve` | 模块解析 |
| `jest-mock` | 模拟实现 |
| `jest-snapshot` | 快照 |
| `pretty-format` | 可读格式化输出 |
| `expect` | 断言库（也可单独用） |

需要定制测试流程时，可按需组合这些包，而不必整套绑定默认 Jest 行为。
