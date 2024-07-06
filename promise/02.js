const fs=require('fs');
/* 回调函数 形式 */
/* fs.readFile('./',(err,data)=>{
    if(err)
    throw err;
    console.log(data.toString());
}); */
let p=new Promise((resolve,reject)=>{

    fs.readFile('./readme.md',(err,data)=>{
        if(err)
        reject(err);
        resolve(data);
    });

});
p.then(value=>{
        console.log(value.toString());
},reason=>{
    console.log(reason);
})