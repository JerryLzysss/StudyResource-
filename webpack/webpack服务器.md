# webpack 服务器
开发服务器，自动化开发（自动编译，自动打开浏览器，自动刷新浏览器）
特点：只会在内存中编译打包，不会有任何输出

1.下载包
npm i webpack-dev-server -D

2.webpack4配置
```
module.exports = {
    devServer: {
        // 项目构建后路径
        contentBase: resolve(__dirname, 'dist'),
        // 启动gzip压缩
        compress: true,
        // 端口号
        port: 3000,
        // 自动打开浏览器
        open: true
    }
}
```
3.webpack5配置
```
module.exports = {{
    // 开发服务器配置
  devServer: {
    // 从目录提供静态文件
    static: {
      directory: path.join(__dirname, "public"),
      publicPath: "/",
    },
    // 启动后打开浏览器
    open: true,
    // 监听请求的端口号
    port: 8080,
  },
}}
```
4.配置启动命令
```
package.json
{
    "scripts": {
    "dev": "webpack serve",
    "build": "webpack"
  },
}
```
5. 启动就可以使用npm run dev