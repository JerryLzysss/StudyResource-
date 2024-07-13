# webpack eslint
# 作用
Eslint 可组装的javascript和jsx检查工具
用来检测js和jsx的语法，可以配置各项功能。
# 步骤
1.配置文件
.eslintrc.* 新建文件位于项目跟目录
.eslintrc
.eslintrc.js
.eslintrc.json
区别在于配置格式不一样
2.首先需要安装eslint-webpack-plugin,
npm install eslint-webpack-plugin --save--dev
3.具体配置
以.eslintrc.js为例子
```
module.exports={
	解析选项
	parserOptions:{
	ecmaVersion:6,//ES语法版本
	sourceType:"module",//ES模块化
	ecmaFeatures:{
	}//ES其他特性	
}
	规则
	rules:{
	/*off或0表示关闭规则，一般用于规则替换
	  warn或1表示开启规则，使用警告错误
	   error或2表示开启规则，使用错误级别规范	*/	
}
	继承
	extends:[
	/*考虑到手写的困难，因此可以直接使用官方规则
	eslint:recommended eslint官方规则
	plugin:vue/essential vue官方规则
	react:app react官方规则 
	对于不需要的规则可以直接进行覆盖操作*/
	]	
}
```
4. webpack4配置(在步骤3的基础之上)
```
module.exports = {
  // loader配置
  module: {
    rules: [
        {
            test: /\.js$/,
            // 注意：只检查自己写的代码，不检查第三方库
            exlude: /node_modules/,
            loader: 'eslint-loader',
            options: {
                // 自动修复
                fix: true
            }
        }
    ]
  },
};
```
5. webpack5配置
```
// webpack.config.js
const ESLintPlugin = require("eslint-webpack-plugin");

// webpack配置
module.exports = {

  // 插件配置
  plugins: [
    // 使用eslint对代码检查
    new ESLintPlugin({
      fix: true,
    }),
  ],
};
```