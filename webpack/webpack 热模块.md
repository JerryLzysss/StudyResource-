# webpack HMR(hot module replacement)
作用：一个模块发生变化，只会重新打包这一个模块（而不是打包所有模块），提升构建速度
样式文件：可以使用HMR功能，style-loader内部实现
js文件：默认没有HMR
注意：只能对非入口文件做HMR
html文件：默认没有HMR
解决：将html文件加入entry入口
```
devServer: {
    // 热模块替换是默认开启的
    // 开启HMR功能，修改配置之后需要重启webpack
    hot: true,
}
```