/* module.exports可以暴露任意数据 */
function a(){
    console.log('1');
}
function b(){
console.log('2');
}
let str='ss';
module.exports={
    a,
    b,
    str
}
;
/* 不能以exports=value暴露数据 */
