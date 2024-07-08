//1.引入express
const express=require('express');
//2.创建引用对象
const app=express();
//3.创建路由规则
//request是对请求报文封装
//response是对响应报文的封装
app.get('/',(request,response)=>{
    response.send('hello express');
});


//4.监听端口启动
app.listen(8000,()=>{
    console.log("服务启动");   
})

/* 
安装express
npm install express --save */