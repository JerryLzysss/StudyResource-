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
fs.readdir('./',(err,data)=>{
    if(err)
    {
        console.log("err");
        return ;
    }
    console.log(data);
})

/* 删除文件夹 */
fs.rmdir('./htmlC',err=>{
    if(err)
    {
        console.log("err");
        return ;
    }
    console.log("ok");
})

/* 递归删除（推荐使用 fs.rm） */
fs.rm('./html',{recursive : true},err=>{
    if(err)
    {
        console.log("err");
        return ;
    }
    console.log("ok");
})
