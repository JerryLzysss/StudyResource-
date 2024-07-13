# webpack 模板

```
// 用来处理路径
const path = require('path');

// webpack配置
module.exports = {
  // 入口文件
  entry: './src/index.js',

  // 输出
  output: {
    // 输出文件名
    filename: 'bundle.js',
    // 输出路径 __dirname node.js变量，当前文件的目录绝对路径
    path: path.resolve(__dirname, 'dist'),
  },

  // loader配置
  module: {
    rules: [],
  },

  // 插件配置
  plugins: [],

  // 模式
  mode: 'development',
// mode: 'production',
};
```