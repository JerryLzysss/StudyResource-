const express=require('express');
const app=express();
/* :代表参数 */
app.get('/:id.html',(req,res)=>{
    console.log(req.params.id);
})
app.listen(9000,()=>{
    console.log("start");
})


