# webpack 源码映射
# 作用
一种提供源代码到构建后代码映射技术
如果构建后的代码出错，可以通过映射关系追踪到源代码出错位置
# 调试工具
```
devtool: 'source-map'
```

# 模式
```[inline- | hidden- | eval- ][nosources-][cheap-[module-]]source-map```
# 组合值
值|说明|错误提示
---|---|---
source-map|外部|错误代码的准确信息，源代码的错位位置
inline-source-map|内联|只生成一个内联source-map错误代码的准确信息，源代码的错位位置
hidden-source-map|外部|错误代码的原因，没有源代码错误位置，只有构建后代码位置
eval-source-map|内联|每个文件都生成对应的source-map都在eval里错误代码的准确信息,源代码的错位位置
nosources-source-map|外部|有错误代码准确信息，没有源代码位置
cheap-source-map|外部|有错误代码准确信息，有源代码信息，只能精确到行
cheap-module-source-map|外部|错误代码的准确信息，源代码的错位位置
# 内联和外部
内联：构建速度快
外部：生成单独文件，内联没有
1、开发环境
速度快，调试更友好
速度快：
eval > inline > cheap > 
eval-cheap-source-map
eval-source-map
调试更友好
source-map
cheap-module-source-map
cheap-source-map
module会将loader的source map加入
eval-source-map / eval-cheap-module-source-map
2、生产环境
源代码要不要隐藏，调试要不要更友好
内联会让代码体积变大，所以生产环境不使用内联
nosources-source-map 全部隐藏
hidden-source-map 只会隐藏源代码，会提示构建后代码错误
source-map / cheap-module-source-map