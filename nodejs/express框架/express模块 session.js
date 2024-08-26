/* session保存服务端数据，保存当前用户的相关信息
session创建session信息，通过seesion_id的值响应头返回给浏览器
cookie在下次发送请求会自动感谢爱cookie,通过其中的session_id确定用户信息 */




/* session与cookie的区别
 cookie:浏览器
 session:服务端
 cookie以明文存放客户端，安全性差
 session存放服务器
 cookie设置过多会增大报文体积，影响传输
 session存储在服务器，通过cookie传递id不影响传输效率
 ccookie保存数据不能超过4K，单个域名存储数量有限制
 session存储在服务器没有限制 */