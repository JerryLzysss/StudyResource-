# webpack 资源缓存
线上代码缓存优化
1、hash: 每次webpack构建打包，都会生成唯一hash
问题：
因为js和css使用同一个hash值
如果重新打包，会导致所有缓存失效，虽然只改动一个文件
2、chunkhash: 根据chunk生成hash值，如果打包来源于同一个chunk，那么hash值就一样
js和css还是使用同一个hash值
因为css是在js中被引入的，所以属于同一个chunk
3、contenthash: 根据文件的内容生成hash值，不同文件hash值不一样