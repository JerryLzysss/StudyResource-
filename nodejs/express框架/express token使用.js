/* token是服务端生成并返回给HTTP客户端的一串加密字符串，token保存用户信息 */
/* token作用实现会话控制，可以识别用户的身份，用于移动端app*/
/*  token填写账号和密码响应token,返回客户端*/
/* 需要手动将token填写报文 */

/* JWT json web token目前流行的跨域认证解决 可以用于token身份验证
jsonwebtoken包操控Token*/
const jwt=require('jsonwebtoken');
let token=jwt.sign({
    username:'zhangsan'
},'at',{
    expiresIn:60,/* 单位是秒 */
})
console.log(token);
/* 验证时应使用刚生成的 token；硬编码的旧 token 会因过期而校验失败 */
jwt.verify(token,'at',(err,data)=>{
    if(err){
        console.log('error');
        return
    }
    console.log(data);
})
