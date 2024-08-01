# todolist

## pubsub
```
1.一种组件间通信的方式
2.使用步骤:
1.安装pubsb npm i pubsub-js
2.引入import pubsub from 'pubsub-js'
3.接受数据:A组件想接受数据，则在A组件中订阅信息，订阅的回溯留在A组件本身
4.提供数据:pubsub.publish('xxx',数据)
5.在beforeDestroy钩子，使用PubSub.unsubsceribe(pid)取消订阅
```

## nextTick
语法:this.$nextTick('###')
作用:在下一次DOM更新结束后执行指定的回调
使用时间:在改变数据后，要基于更新后的DOM进行某些操作的时候

## Vue解决跨域
在Vue.config.js中添加如下配置
devServer:{
    proxy:"http://localhost:5000"
}
优点:配置简单，请求资源直接发送给8080即可
缺点:不能配置多个代理，不能灵活的控制请求是否走代理。
工作方式:请求前端不存在资源的时候，请求会转发给服务器

module.exports={
    devServer:{
        proxy:{
            '/api':{//匹配所有以/api开偷的请求路径
            target:'http:localhost:5000'//代理目标的基础路径
            changeOrigin:false,//是否修改访问时的端口
            pathRewrite:['^api':' ']//重写路径
            
            },
    
            '/api2':{//匹配所有以/api开偷的请求路径
                target:'http:localhost:5000'//代理目标的基础路径
             changeOrigin:false,//是否修改访问时的端口
                pathRewrite:['^api':' ']//重写路径
            }
        
        }
    }
}
## Project setup
```
npm install
```

### Compiles and hot-reloads for development
```
npm run serve
```

### Compiles and minifies for production
```
npm run build
```

### Lints and fixes files
```
npm run lint
```

### Customize configuration
See [Configuration Reference](https://cli.vuejs.org/config/).
