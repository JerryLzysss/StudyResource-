[TOC]
# webpack 参数
# entry 入口
```
const path = require('path');
const HtmlWebpackPlugin = require('html-webpack-plugin');
module.exports = {
    entry: './src/index.js',
    output: {
        filename: 'build.js',
        path: path.resolve(__dirname, 'dist')
    },
    plugins: [
        new HtmlWebpackPlugin()
    ],
    mode: 'development'
}
```
## string 单入口 
输出一个文件，打包chunk默认名：main
```
entry: './src/index.js'
```
## array 多入口
最终形成一个chunk, 使用场景：html热更新
```
entry: ['./src/index.js', './src/add.js']
```
## object 多入口
有几个入口文件就输出几个chunk，chunk名称是key
```
entry: {
    index: './src/index.js', 
    add: './src/add.js'
}
entry: {
    // 多个入口最终生成一个chunk
    index: ['./src/index.js', './src/count.js']
    // 生成一个chunk
    add: './src/add.js'
}
```
# output 输出
output: {
    // 文件名称（目录 + 名称）
    filename: 'js/[name].js',
    // 所有资源输出的公共目录
    path: path.resolve(__dirname, 'dist'),
    // 所有输出资源引入公共路径前缀
    publicPath: '/'
    // 非入口chunk的名称
    chunkFilename: [name]_chunk.js,
    // 整个库对外暴露的变量名
    library: '[name]',
     // 变量名添加到哪个变量上 window(browser), global(node)
    libraryTarget: 'window', // 'global'、'commonjs'
},
# module 模块
```
module: {
    rules: [
        // loader配置
        {
            test: /\.css$/,
            // 多个loader用use
            use: [
                'style-loader',
                'css-loader'
            ]
        },

         {
            test: /\.js$/,
            // 排除node_modules文件夹下文件
            exclude: /node_modules/,
            // 只检查src下的js文件
            include: path.resolve(__dirname, 'src'),
            // 单个loader用loader
            loader: 'babel-loader',
            // 优先执行
            exforce: 'pre',
            // 延后执行
            // exforce: 'post',  
            // 参数配置
            options: {}
        },

        // 以下配置只会生效一个
        oneOf: []

    ]
}
```
# resolve 解析
```
resolve: {
    // 配置解析模块路径别名，
    // 优点：编码时简写路径
    // 缺点：没有路径提示
    alias: {
        '@': path.resolve(__dirname, 'src')
    },

    // 配置省略文件路径的后缀
    extensions: ['.js', '.json', '.css'],

    // 告诉webpack解析模块去哪个目录找
    modules: ['node_modules']
}
```
# devServer 服务器
```
devServer: {
    // 运行代码的目录
    contentBase: resolve(__dirname, 'dist'),
    // 监视contentBase目录下文件，一旦变化就reload
    watchContentBase: true,
    watchOptions: {
        // 忽略文件
        ignored: /node_modules/
    },

    // 启动gzip压缩
    compress: true,
    // 端口号
    port: 5000,
    // 域名
    host: 'localhost',
    // 自动打开浏览器
    open: true,
    // 开启HMR
    hot: true,
    // 不要显示启动服务器日志信息
    clientLogLevel: 'none'
    // 除了一些基本启动信息外，其他内容都不要显示
    quiet: true,
    // 如果出错，不要全屏提示
    overlay: false,
    // 服务器代理，解决开发环境跨域问题
    proxy: {
        // 一旦接收 /api 开头的请求，就会把请求转发到另一个服务器
        '/api': {
            target: 'http://localhost:3000',
            // 发送请求时，请求路径重写, 去掉 /api
            pathRewrite: {
                '^/api': ''
            }
        }
    }
}
```
# optimization 优化
```
output: {
    chunkFilename: 'js/[name].[contenthash:10]_chunk.js'
}
optimization: {
    // 提取公共代码
    splitChunks: {
        chunks: 'all',
        // 一下均为默认值，可以不写
        // 分割的chunk最小为30kb
        minSize: 30  * 1024, 
        // 最大没有限制
        maxSize: 0, 
        // 要提取的chunk最少被引用1次
        minChunks: 1
        // 按需加载时并行加载文件的最大数量
        maxAsyncRequests: 5,
        // 入口文件最大并行请求数量
        maxInitialRequests: 3,
        // 名称连接符
        automaticNameDelimiter: '~'
        // 可以使用命名规则
        name: true,
        // 分割chunk的组
        cacheGroups: {
            // node_modules 文件会被打爆到vendors组的chunk中：verdors~xxx.js
            // 满足上面的公共规则，如：大小超过30kb，至少被引用1次
            verdors: {
                test: /[\\/]node_modules[\\/]/,
                // 优先级
                priority: -10
            },
            default: {
                // 至少被引用2次
                minChunks: 2,
                // 优先级
                priority: -20,
                // 如果当前要打包的模块，和之前已经被提取的模块是同一个，就会复用，而不是重新打包模块
                reuseExistingChunk: true
            }
        }
    },
    // 将当前模块的记录其他模块的hash单独打包为一个文件 runtime
    // 解决：修改a文件，导致b文件的contenthash变化，导致缓存失效
    runtimeChunk: {
        name: entrypoint => `runtime-${entrypoint.name}`
    },

    // 配置生产环境的压缩方案：js和css
    minimizer: [
        new TerserWebpackPlugin({
            // 开启缓存
            cache: true,
            // 开启多进程打包
            parallel: true,
            // 启动source-map
            sourceMap: true
        })
    ]
}
```