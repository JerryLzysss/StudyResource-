# webpack 代码分割
作用:针对代码进行不同形式的处理，减少代码量与处理量
# 方式一:入口起点
指定不同的入口
```
module.exports = {
  entry: {
    // 多入口
    index: './index.js',
    home: './home.js',
   },
   output: {
     filename: '[name].[contenthash:4].js'
   }
}
```
# 方式二:防止重复
将node_modules中的代码单独打包一个chunk最终输出
自动分析多入口chunk中，如果有公共的问题件，会打包成单独一个chunk
```
module.exports = {
  optimization: {
    splitChunks: {
        chunks: 'all'
    }
  }
}
```
# 方式三:动态导入
import动态引入语法，能将文件单独打包
```
import(/* webpackChunkName: 'test' */ './test.js').then(()=>{
    // 加载成功
}).catch(()=>{
    // 加载失败
})
```