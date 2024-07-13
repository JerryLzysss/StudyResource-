# webpack 多进程打包
顾名思义:多个线程加快速度
1. 安装
```
npm install --save-dev thread-loader
```
2. 配置
```
module.exports = {
  module: {
    rules: [
      {
        test: /\.js$/,
        include: path.resolve('src'),
        use: [
          "thread-loader",
          // 耗时的 loader （例如 babel-loader）
        ],
      },
    ],
  },
};
```