const express= require('express');
const app=express();
const bodyParser= require('body-parser');


/* 解析json */
const jsonparser=bodyParser.json();
/* 解析querystring */
const urlencodedParser=bodyParser.urlencoded({extended:false});
app.get('/login',(req,res)=>{
    res.sendFile(__dirname+'/1.html');
});
app.post('/login',urlencodedParser,(req,res)=>{
    console.log(req.body);
    res.send('数据');
});
app.listen(9000,()=>{
    console.log("ook");
});