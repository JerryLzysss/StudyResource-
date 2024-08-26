const fs=require('fs');
const path=require('path');
/* 加入/后将会变成绝对路径 */

/* ——_filename绝对路径
   __dirname相对路径 */
   /* 拼接字符 */
console.log(path.resolve(__dirname,'test','tsest'));
/* 获取草案做系统的路径分割符 */
console.log(path.sep);
/* 解析路径兵器返回对象 */
let str='C:\\资料整理\Path.js';
console.log(path.parse(str));
/* 解析路径的基础名称 */
path.basename
/* 获取路径的目录名 */
path.dirname
/* 获取路径的拓展名 */
path.extname;