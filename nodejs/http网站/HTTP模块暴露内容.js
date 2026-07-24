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
/* 不能用 exports = value 覆盖导出；应使用 module.exports = … */
