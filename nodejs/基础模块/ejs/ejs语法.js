/* EJS是模板引擎分离用户界面和业务数据的技术 */
/* EJS初体验
npm i ejs --save 下载安装EJS
 */

/* <% xxx %>：里面写入的是js语法，
<%= xxx %>：里面是服务端发送给ejs模板转义后的变量，输出为原html
<%- xxx %>：里面也是服务端发送给ejs模板后的变量，不过他会把html输出来 */


/* <% '脚本' 标签，用于流程控制，无输出。
<%_ 删除其前面的空格符
<%= 输出数据到模板（输出是转义 HTML 标签）
<%- 输出非转义的数据到模板
<%# 注释标签，不执行、不输出内容
<%% 输出字符串 '<%'
%> 一般结束标签
-%> 删除紧随其后的换行符
_%> 将结束标签后面的空格符删除 */
const ejs=require('ejs');
let str='good';
let hello='hello';
let result=ejs.render('<%= str2 %> man <%= str3 %>',{str2:str,str3:hello});
console.log(result);
