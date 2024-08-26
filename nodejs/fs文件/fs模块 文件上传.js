let express = require("express");
let path=require('path');
let app = express();
const formidable=require('formidable');
app.use(express.static(__dirname));　
app.set('view engine','ejs');
app.set('views',path.resolve(__dirname));
app.get('/',(req,res,next)=>{
    res.send("oookk"); 
});
app.get("/login",(req,res)=>{
    res.render('index');
});
app.post("/login",(req,res)=>{
    const form=formidable({
        
        multiples:true,
        uploadDir:__dirname,
        keepExtensions:true
    });
    form.parse(req,(err,fields,files)=>{
        if(err)
        {
            next(err);
            return ;
        }
        let url=__dirname;
        console.log(fields);
        console.log(files);
        res.send(url);
    })
});


app.listen("9000",()=>{
    console.log('start');
})
module.exports=app;
