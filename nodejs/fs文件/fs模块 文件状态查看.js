const fs=require('fs');
/*资源查看stat*/
/* 执行的相对路径为命令行的工作目录 */
/* dirname 文件所在目录的绝对路径 */
fs.stat('test.txt',(err,data)=>{
    if(err)
    {
        console.log("err");
        return ;
    }
    console.log(data);
    console.log(data.isFile());
})
