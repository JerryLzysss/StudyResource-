# ASAR 归档

> 官方文档：[ASAR Archives | Electron](https://www.electronjs.org/zh/docs/latest/tutorial/asar-archives)

ASAR 是一种简单的类 tar 归档格式，用于打包 Electron 应用源码，提高读取性能并隐藏源码。

```sh
npx asar pack ./app ./app.asar
npx asar list ./app.asar
npx asar extract ./app.asar ./dest
```

在应用中读取 ASAR 文件：

```js
const fs = require('node:fs')
fs.readFileSync('/path/to/example.asar/file.txt')
```
