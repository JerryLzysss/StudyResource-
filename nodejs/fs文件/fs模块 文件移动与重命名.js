const fs=require('fs');
/* fs.rename 
第一个参数是旧文件路径
第二个参数是新文件路径
可以通过修改来实现重命名与移动*/
fs.rename('./test3.txt','./test.txt',err=>{
    if(err){
        console.log('gg');
        return ;
    }
    console.log('ok');
})