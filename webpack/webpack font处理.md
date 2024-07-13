# webpack font处理
与处理图片资源类似，可以通过转化成base64格式减少数据的请求
```
module:{
    rules:[
      
        test:/\.(ttf|woff2?)\$/,
        {
            type:"asset/resource",
            parser:{
                dataUrlCondition:{
                    //小于10KB的图片转为base64格式
                    maxSize:10*1024//10kb
                }
            }
        }
    ]
}
```