[TOC]
# webpack babel
## 作用
主要用于将ES6语法编写的代码转换为向后兼容的js语法，以便于运用在当前和旧版本的浏览器或者其他环境.
## 内容
1.@babel/preset-env 基本js兼容性处理
问题：只能转换基本js语法。如，不能转换高级语法Promise（IE不支持）
2.@babel/polyfill 全部js兼容性处理
问题：将所有兼容性代码全部引入，体积太大
3.core-js 按需加载：只加载需要处理兼容性的语法
## 步骤
1.配置文件:
babel.config.* 新建文件位于项目根目录
babel.config.js
babel.config.json
.babelrc.* 新建文件，位于项目根目录
.babelrc
.babelrc.js
.babelrc.json
package.json中的babel:不需要创建文件，在原有文件基础.
babel会自动查找并寻找
2.首先需要安装babel-loader与babel
npm install -D babel-loader @babel/core @babel/preset-env
3.具体配置(babel-loader):
我们以babel.config.js配置文件为例
```
module.exports = {
    module: {
      rules: [
          {
            // js兼容性处理
            test: /\.js$/,
            exclude: /node_modules/,
            loader: 'babel-loader',
            options: {
                // 预设，提示babel怎么样做兼容性处理
                // 基本的兼容性处理，
                presets: ['@babel/preset-env']
            }
        }
    ]
  }
}
```
@babel/preset-any：智能预设，允许使用个最新的javascript
@babel/preset-react:用来编译React.jsx语法的预设
@babel/preset-typescript:用来编译typescript语法的预设
4.具体配置(polyfill):
npm i @babel/polyfill -S
直接引入import '@babel/polyfill';
5.具体配置(core-js)
npm i core-js -D
```
module.exports = {
    module: {
      rules: [
          {
            // js兼容性处理
            test: /\.js$/,
            exclude: /node_modules/,
            loader: 'babel-loader',
            options: {
                // 预设，提示babel怎么样做兼容性处理
                // 基本的兼容性处理，
                presets: [[
                '@babel/preset-env',
                {
                // 按需加载
                useBuiltIns: 'usage',
                // 指定core-js版本
                corejs: {
                    version: 3
                },
                // 指定兼容性到哪个版本浏览器
                targets: {
                    chrome: '60',
                    firefox: '60',
                    ie: '9',
                    safari: '10',
                    edge: '17'
                 }

                }
              ]]
            }
        }
    ]
  }
}
```
 