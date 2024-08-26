const express= require('express');
const app=express();

app.use((req,res,next)=>{
    let referer=req.get('referer');
    if(referer)
    {
    let url=new URL(referer);
    let hostname=url.hostname;
    console.log(hostname);
    if(hostname!=='127.0.0.1')
    {
    res.status(404).send("not found");
    return ;    
    }
}
    next();
    
});
app.listen(9000,()=>{
    console.log("ook");
});