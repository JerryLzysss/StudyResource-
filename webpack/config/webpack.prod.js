const ESLintWebpackPlugin = require("eslint-webpack-plugin");
const HtmlWebpackPlugin = require("html-webpack-plugin");
const path=require("path");//nodejs模块专门处理路径问题
const MiniCssExtractPlugin = require('mini-css-extract-plugin');
const CssMinimizerPlugin = require("css-minimizer-webpack-plugin");

module.exports={
    //入口
    entry:"./src/main.js",//相对路径
    //输出
    output:{
        //文件的输出路径
        path:path.resolve(__dirname,"../dist"),//绝对路径
        //入口文件名打包
        filename:'js/main.js',
       
        clean:true 
    },
    
    //加载器
    module:{
        rules:[
            {
            test: /\.css$/i,//表示只处理css后缀的资源
            /* loader:'xxx'只能使用一个loader */
            use:[MiniCssExtractPlugin.loader,
            "css-loader",
            {
              loader:"postcss-loader",/* 如果没有配置可以直接添加loader */
              options:{
                postcssOptions:{
                  plugins:[
                    "postcss-preset-env",/* 解决大多数样式兼容性问题 */
                  ]
                }
              }
            }]//表示使用的loader
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
      }),
      new MiniCssExtractPlugin({
        filename:"dist/css/main.css"//设置路径
      }),
      new CssMinimizerPlugin()
    ],
  
    //模式
    mode:"development",
}
//npx webpack就会去寻找webpack.config.js
/* 然后执行里面的配置 */