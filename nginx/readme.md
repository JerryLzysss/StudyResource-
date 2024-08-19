[TOC]
# nginx
Nginx是一款 轻量级 的 Web服务器、反向代理服务器，由于它的内存占用少，启动极快，高并发能力强。
# nginx作用
## 正向代理与反向代理
正向代理：通过客户机的配置，实现服务器代理客户机，客户的所有请求都交给代理服务器进行提交.也就是通过代理服务器访问到对应服务器上.
反向代理:通过服务器代理真实的服务器，用户访问的请求发送到代理服务器后，再由代理服务器选择对应的服务器发送资源，此时就是暴露了代理服务器地址，从而隐藏真实服务器地址.
## 负载均衡
负载均衡（Load Balance）其意思就是分摊到多个操作服务器上进行执行，以用来解决单个服务器性能不足无法处理请求的问题.
nginx可以通过分配不同的权重来将服务器的性能与访问比率结合在一起.
有以下三种分配方式:
1.轮询法(默认)，按照顺序逐个进行访问.
2.加权轮询，按照比重进行访问，比重高的更容易访问到.
3.ip hash,对请求ip进行hash操作，根据hash结果分发到同一台服务器进行处理，可以解决
4.least_conn 依据最少来凝结方式，分发给处理链接少的服务器
5.url_hash 依据url分配方式，一个固定的url对应的服务器也是固定的.
6.fair 按照后端服务器的响应时间来分配请求，响应时间短的服务器优先分配请求.
session不共享的问题.
4.热备，相当于提供一份备份，如果当前服务器无法运行，那么就跳到备份当中进行执行操作.
## 静态资源处理
Nginx动静分离简单来说就是把动态和静态请求分开，不能理解成只是单纯的把动态页面和静态页面物理分离。严格意义上说应该是动态请求和静态请求分开，可以理解成使用Nginx处理静态请求，Tomcat处理动态请求。
# nginx目录
|-- conf
|   |-- fastcgi.conf
|   |-- fastcgi.conf.default
|   |-- fastcgi_params
|   |-- fastcgi_params.default
|   |-- koi-utf
|   |-- koi-win
|   |-- mime.types
|   |-- mime.types.default
|   |-- nginx.conf
|   |-- nginx.conf.default
|   |-- scgi_params
|   |-- scgi_params.default
|   |-- uwsgi_params
|   |-- uwsgi_params.default
|   `-- win-utf
|-- html
|   |-- 50x.html
|   `-- index.html
|-- logs
|-- sbin
    |-- nginx

conf
核心配置目录，大部分配置操作在这里进行。

html
默认站点目录

logs
存放nginx日志文件，首次启动之前里面啥都没有，如果启动一次，则会生成access.log 、 errors.log 、Nginx.pid 其中pid是当前启动的nginx的进程id

sbin
nginx命令的目录，比如启动nginx。

# nginx指令
启动: Nginx -s start 开启Nginx,
快速关闭：Nginx -s stop 快速关闭，马上丢弃连接，停止工作。
平缓关闭： Nginx -s quit 平缓关闭，允许nginx服务完成当前的请求，不再接收新的请求。
热重启： Nginx -s reload，向主进程发送信号，要求其重新加载配置文件。
重启： Nginx -s reopen ，重启命令。
# nginx配置
主要是配置conf/nginx.conf的内容配置
