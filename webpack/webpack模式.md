# webpack 模式
对于一般应用需要配置两种模式提供使用，那么如下述所提到的，可以按照如下步骤来进行config布置与使用。
```
1.对config文件进行dev与production两种模式的分配
webpack.dev.js
webpack.prod.js
2.修改路径
3.选择执行的模式
npx webpack serve --config ./webpack.dev.js
4.修改package.json的scripts标签
"start":"npm run dev"
"dev":"webpack serve --config ./config/webpack.dev.js"
"build":"webpack --config ./config/webpack.prod.js"
```