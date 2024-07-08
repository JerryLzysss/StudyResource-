//1.引入express
const express=require('express');
//2.创建引用对象
const app=express();
//3.创建路由规则
//request是对请求报文封装
//response是对响应报文的封装

/* Uncaught Error Error:
 listen EADDRINUSE:
 address already in use :::8000
 解决方案:ctrl+c解决端口 */

app.all('/json-server',(request,response)=>{
    response.setHeader('Access-Control-Allow-Origin','*');
    const data={
        name:"gcads"
    };
    let str=JSON.stringify(data);
 
    response.send(str);
});

//4.监听端口启动
app.listen(8000,()=>{
    console.log("服务启动");   
})
/* app.all接受任何信息 */
/* 
安装express
npm install express --save */
/* 安装nodemon
npm install nodemon; 
nodemon Ajax相应JSON
*/

