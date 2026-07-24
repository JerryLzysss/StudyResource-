const express= require('express');

const cookieParser=require('cookie-parser')
const app=express();
app.use(cookieParser());
app.get('/',(req,res)=>{
res.send('home');
});
app.get('/set-cookie',(req,res)=>{
    /* res.cookie('name','zhangsan'); 未设置 maxAge 时为会话 cookie，关闭浏览器后失效 */
   res.cookie('name','lisi',{maxAge:60*1000});
   res.send('home'); 
});
app.get('/remove-cookie',(req,res)=>{
    res.clearCookie('name');
    res.send('ok');
});
app.get('/get-cookie',(req,res)=>{
    console.log(req.cookies);
    res.send('ok');
})
app.listen(3000,()=>{
    console.log('服务器启动');
});
