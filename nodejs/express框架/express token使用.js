/* token是服务端生成饼返回给HTTP客户端的一串加密字符串，token保存用户信息 */
/* token作用实现绘画控制，可以识别用户的身份，用于移动端app*/
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
let t='eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InpoYW5nc2FuIiwiaWF0IjoxNjk1NjU3NDkzLCJleHAiOjE2OTU2NTc1NTN9.HweQ6qsJhAEGTVYpRsWcpa0L8SmELw5cfZrgtVaGeqg'
jwt.verify(t,'at',(err,data)=>{
    if(err){
        console.log('error');
        return
    }
    console.log(data);
})