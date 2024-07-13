const ESLintWebpackPlugin = require("eslint-webpack-plugin");
const HtmlWebpackPlugin = require("html-webpack-plugin");
const path=require("path");//nodejs模块专门处理路径问题
module.exports={
    //入口
    entry:"./src/main.js",//相对路径
    //输出
    output:{
        //文件的输出路径
        /* 开发模式没有输出 */
        path:undefined,
        //入口文件名打包
        filename:'js/main.js',
        /* 清空上次的打包结果 */
       /*  clean:true */
    },
    
    //加载器
    module:{
        rules:[
            {
            test: /\.css$/i,//表示只处理css后缀的资源
            /* loader:'xxx'只能使用一个loader */
            use:["style-loader","css-loader"]//表示使用的loader
            }
            ,
            {
                test: /\.(png|jpe?g|gif|webp)$/,
                type: "asset",
                parser: {
                  dataUrlCondition: {
                    maxSize: 10 * 1024, // 小于10kb的图片会被base64处理
                  },
                },
                generator:{
                    filename:"./imgs/[hash:8][ext][query]"
                }
              },
              {
                test:/\.js$/,
                exclude:/node_modules/,/*排除node_modules不处理  */
                use:{
                  loader:"babel-loader",
                  options:{
                  presets:["@babel/preset-env"],
                  //或者是在根目录使用babel.config.js写入
                  /* module.exports={
                      presets:["@babel/preset-env"]
                  } */
                  }
                }
              }
        ],
    },
    //插件
    plugins:[
      /* plugin的配置 */
      new ESLintWebpackPlugin({
        /* 检查路径下的文件 */
        context:path.resolve(__dirname,"../src")
      }),
      new HtmlWebpackPlugin({
        /* 模板，以public/index.html文件创建新的html文件
          新建html文件特点:
          1.结构和原来一致
          2.自动引入打包输出的资源 */
        template:path.resolve(__dirname,"../public/index.html")
      })
    ],
    /* 开发服务器:不会输出资源，在内存中编译打包的 */
    devServer:{
      host:"localhost",/* 启动服务器域名 */
      port:3000,/* 启动服务器端口号 */
      open:true,/* 是否自动打开浏览器 */
    },
    //模式
    mode:"development",
}
//npx webpack就会去寻找webpack.config.js
/* 然后执行里面的配置 */