//引入fs
//const fs=require('fs');
//调用方法
/* fs.readFile('./m1.js',(err,data)=>{
if(err)throw (err);
console.log(data);
        }); */
        
const p=new Promise(function(resolve,reject){
        const fs=require('fs');
        fs.readFile('./m1.js',(err,data)=>{
                if(err) reject(err);
                resolve(data);
        });
});
p.then(function(value){
        console.log(value.toString());
},function(reason){
        console.log("err");
});
/* 调用then方法返回的是promise对象，对象状态由回调函数执行结果决定
如果非promise类型属性，状态成功，返回为对象成功的值 */
