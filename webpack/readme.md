[TOC]
# webpack 介绍
本质上，webpack 是一个用于现代 JavaScript 应用程序的 静态模块打包工具。当 webpack 处理应用程序时，它会在内部从一个或多个入口点构建一个 依赖图(dependency graph)，然后将你项目中所需的每一个模块组合成一个或多个 bundles，它们均为静态资源，用于展示你的内容。
说白了，将资源进行打包起来,就需要通过webpack。
提要: 首先npm install将需要的node_modules安装好再进行package.json的启动
# webpack 目录

* webpack 概念 - webpack.config.js
  - entry:入口
  - output:输出
  - loader:处理非js文件
  - plugins:插件，负责优化与进行webpack完善
  - mode:模式，包括以下几种
    - development 本地调试
      1.process.env.NODE_ENV=development
      2.启用插件
      - NamedChunksPlugin
      - NamedModulesPlugin
      3.仅仅能编译JS的module语法
    - production 上线运行
      1.process.env.NODE_ENV=production
      2.启用插件
        + FlagDependencyUsagePlugin
        + FlagDependencyUsagePlugin
        + FlagIncludedChunksPlugin
        + ModuleConcatenationPlugin
        + NoEmitOnErrorsPlugin
        + TerserPlugin
      3.编译JS的ES中的module语法，还能压缩代码。
* webpack 使用 - webpack使用.md
* webpack 插件
    初始的webpack仅仅能对json与js文件进行处理，那么为了处理其他资源需要引入相关的插件来进行对应的处理
* webpack 模板 - webpack模板.md
* webpack 处理器 
    * webpack - html处理器.md
    * webpack - css处理器.md
      * webpack - css处理器.md
      * webpack - css分离处理器.md
      * webpack - css压缩.md
    * webpack - image处理.md(图片处理)
    * webpack - font处理.md(文字处理)
* webpack 代码检查
    * webpack - babel处理.md
    * webpack - eslint处理.md
* webpack 实时跟踪 - webpack服务器.md
* webpack 环境对比
    * 开发环境
      * 优化打包构建速度
      * 优化代码调试
    * 生产环境
      * 优化打包构建速度
      * 优化代码运行的性能
* webpack 优化
    * 实时处理改动 - webpack热模块.md
    * 代码映射 - webpack源码映射.md
    * 第一匹配 - webpack第一匹配规则.md
    * babel-loader缓存 - webapck babel缓存.md
    * 文件资源缓存 - webpack 资源缓存.md
    * tree shaking - webpack 抖动树.md(直译)
    * code split - webpack 代码分割.md
    * 懒加载和预加载 - webpack 懒加载与预加载.md
    * PWA离线访问 - webpack 离线访问.md
    * 多线程 - Webpack 多进程打包.md
    * 外部拓展external - webpack 外部拓展.md
    * dll打包 -webpack dll打包.md
* webpack 模式 - webpack模式.md
* webpack 参数 - webpack参数.md
* webpack 新旧差异 - webpack新旧差异.md
