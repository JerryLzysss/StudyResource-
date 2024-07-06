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

# CSS动画



# 数据导出导入


# Git问题

Q:fatal: 'origin' does not appear to be a git repository
fatal: Could not read from remote repository.
A:重新输入一次地址
``` git remote add <地址> ```

Q:error: src refspec main does not match any
error: failed to push some refs to 'github地址'
A:不存在该分支，重新选择分支即可。

Q:fatal: unable to access '<地址>': Failed to connect to github.com port 443: Timed out
A:可以尝试取消代理（也有可能是太慢了)
``` git config --global --unset http.proxy```

Q:Logon failed, use ctrl+c to cancel basic credential prompt.
remote: Support for password authentication was removed on August 13, 2021.
remote: Please see https://docs.github.com/get-started/getting-started-with-git/about-remote-repositories#cloning-with-https-urls for information on currently recommended modes of authentication.
fatal: Authentication failed for <地址>
A:github取消了使用密码登录的方式，需要配置令牌
```
1.点击个人页面的 settings
2.在左侧寻找到最下面的 Developer settings
3.点击 Personal access tokens(个人访问令牌)
4.点击 Generate new token
5.设置 token 信息
6.根据所需过期时间，建议设置成永远，以免麻烦，建议所有选项都选上
7.点击 Generate token 生成令牌
8.得到生成的令牌
9.应用令牌
10.修改现有的 url
git remote set-url origin  https://<your_token>@github.com/<USERNAME>/<REPO>.git
将<your_token>换成你自己得到的令牌。<USERNAME>是你自己github的用户名，<REPO>是你的项目名称
换成你自己得到的令牌。是你自己github的用户名，`是你的项目名称
然后再次执行 pull push 操作
```


Q:生成密钥的方式
A：1.首先设置用户名与邮箱..
```
git config --list 查看git config信息
git config --global --edit 修改全局config(vim模式)
git config user.name "username" 添加内容user.name,值为username
```

2.设置生成密钥
ssh-keygen -t rsa -C "邮箱"

3.在主机中寻找生成的密钥信息
C:\Users(用户)\用户名\.ssh\id_rsa.pub

4.打开个人信息设置
个人头像/setting/SSH and GPG keys
将内容复制进入即可完成

Git报错：Updates were rejected because the tip of your current branch is behind