# webpack 抖动树
作用:去除无用代码，减少代码体积
前提:必须使用ES6模块化
开启production环境
pagekage.json配置
```
//所有代码都没有副作用（都可以运行）
sideEffects: false
```
副作用:可能会把css / @babel/polyfill文件干掉
处理方式
```
// 要保留的文件
sideEffects: ["*.css"]
```