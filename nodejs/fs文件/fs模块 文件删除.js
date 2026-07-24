const fs=require('fs');
/* unlink或者unlinkSync；rm或者rmSync */
fs.unlink('test2.txt',err=>{
    if(err)
    {
        console.log("err");
        return ;
    }
    console.log("ok");
})
