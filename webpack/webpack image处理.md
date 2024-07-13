# webpack image
优化原因:对于图片处理不需要下载额外的配置,而访问图片是会增加服务器负担,因此对于一些图片可以直接渲染改为base64形式来减少请求的发送.
1.基础模板
```
module:
rules:[
     test:/\.png\$/,
           type:"asset",
            parser:{
                dataUrlCondition:{
                    //小于10KB的图片转为base64格式
                    maxSize:10*1024//10kb
                }
            }
    ]
```
2.使用模板
```
module:{
    rules:[
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
    ]
}
```
3.在output的filename表示文件打包输出文件名，其余文件会输出到path
例如对于图片信息的修改可以加上 
hash:8表示hash长度
ext:后缀名
query:询问参数等等
generator:{
        filename:"./imgs/[hash:8][ext][query]"
}