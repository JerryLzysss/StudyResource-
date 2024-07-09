[TOC]
# axios 介绍
Axios，是一个基于promise [5]的网络请求库，作用于node.js和浏览器中，它是 isomorphic 的(即同一套代码可以运行在浏览器和node.js中)。在服务端它使用原生node.js http模块, 而在客户端 (浏览端) 则使用XMLHttpRequest。

# axios 特色
* 从浏览器创建XMLHttpRequests
* 从 node.js 创建 http 请求
* 支持 Promise API
* 拦截请求和响应
* 转换请求和响应数据
* 取消请求
* 自动转换JSON数据
* 客户端支持防御XSRF

# axios 目录
* axios应用 - axios.html
* axios其他方法 - axios其他添加方法.html
* axios实例化 - axios实例对象.html
* axios取消请求 - axios取消请求.html
* axios实现 
  * axios创建 - axios创建过程.html 
  * axios发送步骤 - axios发送过程.html
  * axios拦截 - axios拦截器.html
  * axios发送与取消发送- axios模拟发送&取消发送.html
# axios 总结
总而言之，就是基于promise封装下的一个库，用来进行网络请求，掌握如何应用即可.如果需要深层封装原理可以考察一下axios实现的几个html.