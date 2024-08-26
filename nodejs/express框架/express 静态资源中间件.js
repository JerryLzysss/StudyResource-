const express=require('express');
const app=express();
/* 直接建立起文件静态资源可以供网页进行搜索 */
app.use(express.static(__dirname));
app.get('/home',(req,res)=>{

    res.send('home');

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


