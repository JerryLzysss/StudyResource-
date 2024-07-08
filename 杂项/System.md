[TOC]
# 代理方式
问题产生:响应头的不同导致无法访问到对应的ip地址获取内容。
1.Vue自行代理
(1)打开vue.config.js
```
devServer: {
        port: 8083, //端口，设置此处修改访问端口
		proxy: {
			'/api': { 
					target: 'http://183.6.5.226:89/api/', //代理目标
					pathRewrite: { //重定向
							'^/api': '/',
					},
					on: { //修改代理请求头
							onProxyReq(proxyReq, req, res) {
									proxyReq.setHeader('Host', '183.6.5.226:89');
							
							}
					}
			}
	}
```
2.Nginx代理
(1)下载nginx客户端
(2)在nginx/conf/nginx.conf中添加
```
   location /api/ { 
            proxy_set_header Host       $host; //配置响应头
            #proxy_pass http://192.168.4.56:9900/;
            #proxy_pass http://192.168.4.178:9900/;
            
            proxy_pass http://183.6.5.226:89/api/;
            //配置响应代理IP
            #proxy_pass http://127.0.0.1:9900/;
            client_max_body_size 50m;
            client_body_buffer_size 50m;
        }
    
```
(3)nginx常用指令:
```
nginx -s quit 退出
nginx -s reload 重载 
nginx -s reopen 重新打开日志
nginx -s start 启动
nginx -s stop 关闭
```

# SVN操作

# Echart建立


# Element-ui/Ant修改样式

1.多数ui库中不支持直接修改，需要采用深度修改。
```
/deep/ .ant-tag{
        //1.通过deep方式
    }

>>> .Talk.ant-tag-orange{
     //2.通过>>>进行修改(与DEEP相同)
    width:100px;
    width: 170px;
    height: 75px;
    line-height:70px;
    text-align:center;
    font-family: Microsoft YaHei, Microsoft YaHei;
    font-weight: bold;
    font-size: 28px;
    color: #C8B386;
    font-style: normal;
    text-transform: none;
}
```

# 高德地图API使用


# 实用网站
1.https://echarts.apache.org/examples/zh/index.html echart官方
2.https://element.eleme.cn/#/zh-CN/component/layoute elementui官方
3.https://www.antdv.com/components/overview antd官方
4.https://www.isqqw.com/ref/ 速查表
5.http://datav.aliyun.com/portal/school/atlas/area_selector#&lat=30.332329214580188&lng=106.72278672066881&zoom=3.5 数据化可视
6.https://www.isqqw.com/ Echart图表大全
7.http://color.oulu.me/ 渐变色查询

# 运行问题

在 cmd中运行带有空格的文件名时需要带上双引号，例如 node abc cde.js
则需要node "abc cde.js",如果时带有引号的js,例如node "abc".js，
则需要node ""abc"".js