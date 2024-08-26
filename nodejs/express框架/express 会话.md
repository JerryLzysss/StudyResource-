[TOC]
# express 会话跟踪
HTTP协议本身是无状态的。什么是无状态？即服务器无法判断用户身份, 也就是说无法知道上一次请求的对象是谁, 此时就要使用到会话跟踪技术。

# Cookie简介
## cookie定义
cookie是由Web服务器保存在用户浏览器上的一小段文本，格式：key=value，包含用户相关的信息。

## cookie鉴权原理
当客户端第一次访问服务器的时候，那么服务器就会生成Cookie信息，并且在响应头的
set-cookie里面把生成的cookie信息发送给客户端。
当客户端第2-N次访问服务器的时候，那么客户端就会在请求头的cookie带上cookie信
息，从而实现鉴权。


## cookie的分类
### 会话cookie：保存在内存，当浏览器关闭之后就会自动化清除cookie。
## 持久cookie：保存在 硬盘 ，浏览器关闭后不会清除，只有当失效时间到了才会自动清除。
# Session简介
## session的定义
session是依赖Cookie实现的，session是服务器端对象，是浏览器和服务器会话过程中，服务器分配的一块储存空间。
服务器默认为浏览器在cookie中设置 sessionid，浏览器在向服务器请求过程中传输 cookie 包含 sessionid ，服务器根据 sessionid 获取出会话中存储的信息，然后确定会话的身份信息。

## session会话机制
客户端A访问服务器，服务器存储A的数据value；
把key返回给客户端A，客户端A下次带着key（session ID）来访问服务器；
服务器就能给出客户端A的数据。
如果做了负载均衡，客户端A访问了另一个服务器，则另一个服务器没有客户端A的数据

 

## Session的缺点
Session 机制的缺点，比如： A 服务器存储了 Session，如果做了负载均衡后，
假如一段时间内 A 的访问量激增，会转发到 B 进行访问，
但是 B 服务器并没有存储 A 的 Session，会导致 Session 的失效。 

# cookie与session区别
## 存储位置
cookie数据存：放在客户端浏览器上或本地
session数据：只能放在服务器上

## 安全性
cookie：安全性较差，别人可以分析存放在本地的Cookie并进行Cookie欺骗，以攻击网站        
session：安全性相对更高

## 占用服务器资源
cookie：服务器性能消耗小
session：一定时间内保存在服务器上，当访问增多，会比较占用服务器性能，考虑到减轻服务器性能压力，应当使用cookie

## 存储空间
单个cookie：保存的数据不能超过4K，很多浏览器都限制一个站点最多保存20个cookie
session：没有大小限制和服务器的内存大小有关

## 存储类型
cookie：只能存储 String 类型的对象
session：能够存储任意的 java 对象

## 总结建议
将登陆等重要信息存放为Session；其他信息如果需要保留，可以放在Cookie中

# Token简介
## token的引入
Token是在客户端频繁向服务端请求数据，服务端频繁的去数据库查询用户名和密码并进行对比，
判断用户名和密码正确与否，并作出相应提示，在这样的背景下，Token便应运而生。

## token的定义
Token是服务端生成的一串字符串，以作客户端进行请求的一个令牌；
当第一次登录后，服务器生成一个Token便将此Token返回给客户端；
以后客户端只需带上这个Token前来请求数据即可，无需再次带上用户名和密码。

## 使用Token的目的
Token的目的是为了减轻服务器的压力，减少频繁的查询数据库，使服务器更加健壮。

## token鉴权原理
Token令牌：客户端A访问服务器，服务器给了客户端token，客户端A拿着token访问服务器，服务器验证token，返回该token用户对应的数据
总之，Token 是在服务端产生的。如果前端使用用户名/密码向服务端请求认证，服务端认证成功，那么在服务端会返回 Token 给前端。前端可以在每次请求的时候带上 Token 证明自己的合法地位

## session与token区别
token存储在客户端；session存储在服务器端；
token提供认证和授权功能，作为身份认证，token安全性比session好，因为每个请求都有签名还能防止监听以及重放攻击；session就必须靠链路层来保障通讯安全，如果你需要实现有状态的会话，仍然可以增加session来在服务器端保存一些状态
token不一定存储；session存在服务器中，增加服务器压力；
token可以跨域；session不可以跨域，它是与域名绑定的，扩展性不强；
token适用于项目级的前后端分离（前后端代码运行在不同的服务器下）；session这种会话存储方式方式只适用于客户端代码和服务端代码运行在同一台服务器上
token是时间换空间；session是空间换时间
token是开发定义的；session是http协议规定的；
token和session都是为了身份验证，token被翻译为令牌；session被翻译为会话
token和session都需要去管理过期时间
