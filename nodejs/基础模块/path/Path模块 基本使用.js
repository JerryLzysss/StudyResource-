const fs=require('fs');
const path=require('path');
/* 加入/后将会变成绝对路径 */

/* __filename：当前文件的绝对路径
   __dirname：当前目录的绝对路径 */
   /* 拼接路径 */
console.log(path.resolve(__dirname,'test','test'));
/* 获取当前操作系统的路径分隔符 */
console.log(path.sep);
/* 解析路径并返回对象 */
let str='C:\\资料整理\\Path.js';
console.log(path.parse(str));
/* 解析路径的基础名称 */
path.basename
/* 获取路径的目录名 */
path.dirname
/* 获取路径的拓展名 */
path.extname;
