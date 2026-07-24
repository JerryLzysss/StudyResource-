# Node.js

简单的说 Node.js 就是运行在服务端的 JavaScript。  
Node.js 是一个基于 Chrome JavaScript 运行时建立的一个平台。  
Node.js 是一个事件驱动 I/O 服务端 JavaScript 环境，基于 Google 的 V8 引擎，V8 引擎执行 JavaScript 的速度非常快，性能非常好。

# 目录结构

| 目录 / 文件 | 说明 |
| --- | --- |
| `readme.md` | 本说明文件 |
| `基础模块/` | 原与本文件同级的散落笔记与示例，已按主题归类 |
| `fs文件/` | `fs` 文件系统读写、目录、上传等示例 |
| `http网站/` | 原生 `http` 模块建站、响应、MIME、模块导出 |
| `express框架/` | Express 路由、中间件、Cookie/Session/Token |
| `mongoose/` | MongoDB / Mongoose CRUD 与插件说明 |

运行示例时，请在**对应子目录**下执行（相对路径依赖同目录配套文件）。

---

# 基础模块

原根目录散落文件已整合至此。相关笔记、脚本与被引用的数据文件放在同一子目录。

## `基础模块/buffer/` — Buffer 缓冲区

| 文件 | 情况 |
| --- | --- |
| `buffer.md` | Buffer 编码、类方法、读写与常用 API 笔记 |
| `buffer缓冲区.js` | 对应示例：创建、编码转换、`copy` / `compare` |

运行：`node buffer缓冲区.js`

## `基础模块/stream/` — Stream 流

| 文件 | 情况 |
| --- | --- |
| `stream.md` | Stream 类型、事件、管道与链式说明 |
| `stream.js` | 读流 / 写流 / `pipe` / zlib 压缩解压示例 |
| `stream.txt` | 示例输入数据（被 `stream.js` 读取） |
| `stream.txt.gz` | 压缩产物（运行 `stream.js` 后生成/更新） |

运行后还会在同目录生成：`output.txt`、`pipe-output.txt`、`decompress-output.txt`。  
运行：`node stream.js`

## `基础模块/ejs/` — EJS 模板

| 文件 | 情况 |
| --- | --- |
| `ejs语法.js` | EJS 标签说明与 `ejs.render` 最小示例（需先 `npm i ejs`） |
| `ejs启用.html` | 带文件上传的表单页（`multipart/form-data`，可配合 `fs文件/fs模块 文件上传.js` 使用） |

运行语法示例：`node ejs语法.js`

## `基础模块/path/` — Path 路径

| 文件 | 情况 |
| --- | --- |
| `Path模块 基本使用.js` | `__dirname` / `__filename`、`resolve`、`sep`、`parse` 等 |

运行：`node "Path模块 基本使用.js"`

## `基础模块/Restful/` — REST / json-server

| 文件 | 情况 |
| --- | --- |
| `Restful API.md` | REST 风格说明与 `json-server` 用法 |
| `json-server.json` | 示例数据（原在 `mongoose/`，已与笔记一并迁入） |

使用：在本目录执行 `npm i -g json-server` 后，运行  
`json-server --watch json-server.json`

## `基础模块/` 根下独立笔记

| 文件 | 情况 |
| --- | --- |
| `npm操作.md` | npm 初始化、依赖、发布、cnpm/yarn/nvm |
| `REPL(交互).md` | Node REPL 用法与常用命令 |

---

# fs文件

`fs` 模块示例，文件操作互不依赖外部数据文件时可直接运行。

| 文件 | 情况 |
| --- | --- |
| `fs模块 文件写入.js` | 异步/追加/流式写入 |
| `fs模块 文件读取.js` | 异步/流式读取 |
| `fs模块 文件删除.js` | `unlink` 删除 |
| `fs模块 文件移动与重命名.js` | 移动与重命名 |
| `fs模块 文件状态查看.js` | `stat` 查看状态 |
| `fs模块 文件夹操作.js` | 创建/读取/删除目录（递归删除用 `fs.rm`） |
| `fs模块 文件上传.js` | Express + formidable 上传；视图引擎为 ejs（可与 `基础模块/ejs/` 配合） |

---

# http网站

原生 HTTP 服务示例。

| 文件 | 情况 |
| --- | --- |
| `HTTP建立.js` / `HTTP建立.html` | 创建服务与配套页面 |
| `HTTP响应报文.js` | 响应头与正文 |
| `HTTP响应文件内容.js` | 将文件内容作为响应 |
| `HTTP MIME类型.js` | 按扩展名设置 MIME 并返回文件内容 |
| `HTTP获取请求路径.js` | 解析请求路径 |
| `HTTP GET 和POST区别.md` | GET/POST 场景与区别笔记 |
| `HTTP模块暴露.js` / `HTTP模块暴露内容.js` | CommonJS 导出说明与示例 |

---

# express框架

Express 应用层示例（多数需安装 `express` 及注释中的依赖包）。

| 文件 | 情况 |
| --- | --- |
| `express 基本使用.js` / `.html` | 基础路由 |
| `express 路由中间件.js` | 中间件与校验示例 |
| `express 静态资源中间件.js` | `express.static` |
| `express 获取请求体数据.js` | `body-parser` 解析表单/JSON |
| `express模块 获取路由参数.js` | 路由参数 |
| `express模块 获取请求报文参数.js` | 查询参数等 |
| `express cookie操作.js` | 设置/读取/清除 Cookie |
| `express模块 session.js` | Session 与 Cookie 对比笔记（注释） |
| `express模块 session操作.js` | `express-session` + `connect-mongo` |
| `express token使用.js` | JWT 签发与校验 |
| `express 防盗链.js` | Referer 防盗链 |
| `express 会话.md` / `express 会话控制.md` | Cookie / Session / Token 概念笔记 |

---

# mongoose

MongoDB / Mongoose 笔记与 CRUD 示例（需本地 MongoDB，连接串见各文件）。

| 文件 | 情况 |
| --- | --- |
| `mongodb数据库.txt` | 安装与 `mongosh` 基础命令 |
| `mongoose插件.txt` | Mongoose 简介与官网 |
| `mongoose运用.js` | 连接与模型、写入 |
| `mongoose读取.js` | 查询读取 |
| `mongoose条件读取.js` | 条件查询 |
| `mongoose个性化读取.js` | `select` / `sort` / `skip` / `limit` |
| `mongoose更新.js` | 更新 |
| `mongoose删除.js` | 删除 |

> `json-server` 示例数据已移至 `基础模块/Restful/`，不再放在本目录。
