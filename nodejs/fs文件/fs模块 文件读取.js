const fs=require('fs');
/* 异步读取*/
fs.readFile('./test.txt',(err,data)=>{
    if(err)
    {
    console.log('error');
return ;    
}
    console.log(data.toString());
})
/* 同步读取 */
/* fs.readFileSync */




/* 流式读取 */
const fs=require('fs');
let fss=fs.createReadStream('./test2.txt');
fss.on('data',chunk=>{
    console.log(chunk.toString());
    });
    fss.on('end',()=>{
   console.log("gg");    
    });