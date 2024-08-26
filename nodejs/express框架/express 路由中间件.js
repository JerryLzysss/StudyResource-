const express=require('express');
const app=express();
app.get('/home',(req,res)=>{
    /* middleware是一个回调函数
    可以像路由回调一样访问请求对象，相应对象
    中间件的作用就是使用函数封装公共操作，简化代码
     */
    res.send('home');
/* 没一个请求到达服务端之后都会执行全局中间件
声明方法:
let recordMiddleware = function(reques,responsenext{
//实现功能代码
//实现next函数（如果希望执行完中间件函数之后扔然执行路由中的回调函数必须调用next）
next();
}); */
});
let checkCodeMiddleware=(req,res,next)=>{
    if(req.query.code=='521')
    next();
    else
    res.send("error");
}
app.get('/admin',checkCodeMiddleware,(req,res)=>{
    
    res.send('admin');
})
app.all('*',(req,res)=>{
    
    res.send('not found');
})
app.listen(9000,()=>{
    console.log("start");
})


