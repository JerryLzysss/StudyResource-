# webpack dll打包
作用:将第三方库打包到dll文件,单独对某些包进行打包.
# 配置
webpack.dll.config.js
```
/**
 * 使用dll技术，对某些库（第三方库：jQuery,vue, react...）进行单独打包
 */
const path = require("path");
const webpack = require("webpack");

// webpack配置
module.exports = {
  // 入口文件
  entry: {
    vendors: ["jquery"],
  },

  // 输出
  output: {
    filename: "[name].dll.js",
    path: path.resolve(__dirname, "dll"),
    // 打包库对外暴露的名字
    library: "[name]_[fullhash:10]",
    clean: true,
  },

  // 插件配置
  plugins: [
    // 提供映射表
    new webpack.DllPlugin({
      name: "[name]_[fullhash:10]",
      path: path.resolve(__dirname, "[name].manifest.json"),
    }),
  ],

  // 模式
  mode: "production",
};
```
# 运行
```
$ npx webpack --config webpack.dll.config.js
```
# 引入
将dll文件引入到html中
```
$ npm i add-asset-html-webpack-plugin -D
```
add-asset-html-webpack-plugin: 添加js或css资源到html中 
https://github.com/SimenB/add-asset-html-webpack-plugin

```
// webpack.config.js
const path = require("path");
const webpack = require("webpack");
const HtmlWebpackPlugin = require("html-webpack-plugin");
const AddAssetHtmlPlugin = require('add-asset-html-webpack-plugin');

// webpack配置
module.exports = {
  // 入口文件
  entry: "./src/index.js",

  // 输出
  output: {
    filename: "[name].[contenthash:10].js",
    path: path.resolve(__dirname, "dist"),
    publicPath: "/dist/",
    // 在生成文件之前清空 output 目录
    clean: true,
  },

  // 插件配置
  plugins: [
    // 复制一份HTML文件，并自动引入打包资源（js/css）
    new HtmlWebpackPlugin({
      template: "./src/index.html",
    }),

    // 告诉webpack 哪些库不参与打包
    new webpack.DllReferencePlugin({
      context: path.join(__dirname),
      manifest: path.resolve(__dirname, "vendors.manifest.json"),
    }),

    // 将某个文件打包输出，并在HTML文件中引入
    new AddAssetHtmlPlugin({
      filepath: path.resolve(__dirname, "dll/vendors.dll.js"),
    }),
  ],

  // 模式
  // mode: "development",
  mode: "production",
};

//index.js
import $ from 'jquery';
console.log($);
```
# 配置config
```
$ npx webpack --config webpack.config.js
```