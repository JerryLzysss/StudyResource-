# webpack 差异

1.自动删除Node.js Polyfill: V5不自动加载node.js模块
2.chunk和模块ID 添加了新的算法
3.chunkID 命名规则优化
4.Tree Shaking 能够处理嵌套模块、多模块关系、commonjs
5.output V4只输出ES5,V5支持ES5
6.SplitChunk js和css大小单独划分
7.Caching 磁盘存储
8.监视输出文件 看是否变化再决定要不要输出全部文件
9.添加了默认值