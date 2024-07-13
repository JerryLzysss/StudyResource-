# webpack css分离处理

## 使用分离器的原因:
CSS文件目前被打包到JS文件中，当JS文件加载的时候会创建一个style标签,这样对于网站来说，会出现闪屏现象，用户体验不好,如果能提取出单独的CSS文件通过link标签能有效提高加载性能
1.下载包
```
npm i mini-css-extract-plugin -D
```
2.修改style-loader为MiniCssExtractPlugin.loader（不要加" "）
3.导入分离插件
```
const MiniCssExtractPlugin = require("mini-css-extract-plugin");
```
4.添加插件
```
module:{
  rules:
    [
      {
      
      use:["MiniCssExtractPlugin-loader"]
      }
    ]
}
```
5.插件中填入参数
```
plugins:[
      new MiniCssExtractPlugin({
        filename:"dist/css/main.css"//设置路径
      })
],
```
