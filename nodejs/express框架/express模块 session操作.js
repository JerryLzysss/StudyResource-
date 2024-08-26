
const express=require('express');
const session=require('express-session');
const MongoStore=require('connect-mongo');
const app=express();
// 1.安装 npm i express-session connect-mango
//2.引入express-session  connect-mango
app.use(session({
    name:'sid',//设置cookie的name 默认值是sid
    secret:'a',//参与加密的字符串（签名）
    saveUninitialized:false,//是否为每次请求设置一个cookie用来存储session
    resave:true ,//是否在每次请求重新保存session 20分钟
    store: MongoStore.create({
        mongoUrl:'mongodb://127.0.0.1:27017/book'//数据库连接
    }),
    cookie:{
        httpOnly:true,//开启前后端无法通过js操作
        maxAge:1000*60//这一条是控制sessionID的过期时间!
    },

}))
app.get('/',(req,res)=>{
    res.send('home');
})
app.get('/login',(req,res)=>{
    //
    if(req.query.username==='admin'&&req.query.password==='admin')
    {
        req.session.username='admin';
        req.session.uid='258aefccc';
        res.send('log ok');
    }
    else
    {
        res.send('log no');
    }
})
app.get('/cart',(req,res)=>{
    /* 检测session是否存在用户数据 */
    if(req.session.username)
    {
        var name=req.session.username;
        res.send('YES,欢迎您 '+name);
    }
    else
    {
        res.send('no');
    }
})
app.get('/logout',(req,res)=>{
    req.session.destroy(()=>{
        res.send('退出成功');
    })
})
app.listen(3000);