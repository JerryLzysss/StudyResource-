const fs=require('fs');

/* 创建 */
fs.mkdir('./html',err=>{
    if(err)
    {
        console.log("err");
        return ;
    }
    console.log("ok");
})
/* 递归创建 */
fs.mkdir('./html/ABC',{recursive : true},err=>{
    if(err)
    {
        console.log("err");
        return ;
    }
    console.log("ok");
})

/* 读取文件夹 */
const fs=require('fs');
fs.readdir('./',(err,data)=>{
    if(err)
    {
        console.log("err");
        return ;
    }
    console.log(data);
})

/* 递归创建 */
fs.rmdir('./htmlC',err=>{
    if(err)
    {
        console.log("err");
        return ;
    }
    console.log("ok");
})

/* 递归删除 */
fs.rmdir('./html',{recursive : true},err=>{
    if(err)
    {
        console.log("err");
        return ;
    }
    console.log("ok");
})
