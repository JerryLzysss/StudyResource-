# webpack html
通过引入html-webpack-plugin 省去自己填写引入资源的麻烦，同时多个JS与CSS资源之间的相互引用关系,单独引用容易导致错误
1.首先安装插件
```
npm i html-webpack-plugin -D
```
2.在webpack.config.js中导入
```
const HtmlWebpackPlugin = require("html-webpack-plugin");
```
3.在处理器中引入htmlwebpackplugins
```
plugins: [
    // 复制一份HTML文件，并自动引入打包资源（js/css）
   new HtmlWebpackPlugin({
    template: "./src/index.html",
    minify: {
        // 移除空格
        collapseWhitespace: true,
        // 移除注释
        removeComments: true,
    }
}),
  ],
```
