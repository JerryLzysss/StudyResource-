# webpack css处理器

1.对于loader去官方文档寻找对应的加载器loader
https://webpack.docschina.org/loaders
例如需要引入less,那么需要加载上对应的
2.第一步下载对应的loader
npm install --save-dev css-loader
3.main.js引入相应的css资源
import "./css/index.css";
4.第二步对相应的资源进行loader配置
```
module:{
  rules:
    [
      {
      test: /\.css$/i,//表示只处理css后缀的资源(正则)
      loader:'xxx'只能使用一个loader 
      use:["style-loader","css-loader"]//表示使用的loader,此处需要引入的style-loader与css-loader
      }
    ]
}
```