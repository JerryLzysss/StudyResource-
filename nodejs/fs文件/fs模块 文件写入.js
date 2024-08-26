const fs=require('fs');
/* 异步写入 */
fs.writeFile('./test.txt','gggg',err=>{
    if(err)
    {
    console.log('error');
return ;    
}
    console.log('ok');
})
/* 同步写入 */
/* fs.writeFileSync */

/* 异步最后加入 */
fs.appendFile('./test.txt','\r\ngggg',err=>{
    if(err)
    {
    console.log('error');
return ;    
}
    console.log('ok');
})
/* 同步最后加入
fs.appendFileSync */


/* 流式写入 */
const fs=require('fs');
let fss=fs.createWriteStream('./test2.txt');
fss.write('gggg');
fss.write('\r\nhhhh');
fss.close();