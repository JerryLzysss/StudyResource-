const express= require('express');

const cookieParser=require('cookie-parser')
const app=express();
app.use(cookieParser());
app.get('/',(req,res)=>{
res.send('home');
});
app.get('/set-cookie',(req,res)=>{
    /* res.cookie('name','zhangsan');在服务器关闭时销毁 */
   res.cookie('name','lisi',{maxAge:60*1000});
   res.send('home'); 
});
app.get('/remove-cookie',(req,res)=>{
    res.clearCookie('name');
});
app.get('/get-cookie',(req,res)=>{
    console.log(req.cookies);
    res.send('ok');
})
app.listen(3000,()=>{
    console.log('服务器启动');
});