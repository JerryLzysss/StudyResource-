# Restful
REST即表述性状态传递（英文：Representational State Transfer，简称REST）是Roy Fielding博士在2000年他的博士论文中提出来的一种软件架构风格。

表述性状态转移是一组架构约束条件和原则。满足这些约束条件和原则的应用程序或设计就是RESTful。需要注意的是，REST是设计风格而不是标准。REST通常基于使用HTTP，URI，和XML（标准通用标记语言下的一个子集）以及HTML（标准通用标记语言下的一个应用）这些现有的广泛流行的协议和标准。REST 通常使用 JSON 数据格式。
URL路径表示资源
## Restful使用
操作资源要与HTTP请求方法对应
操作结果要与HTTP相应状态码对应

json-Server 用来搭建Restful api
全局安装
npm i -g json-Server
创建JSON文件
{
    "song":[
        {"id":1,"name":2,"sing":3},
        {"id":1,"name":2,"sing":5},
        {"id":1,"name":2,"sing":4}
    ]
}
以JSON文件所在文件夹执行命令
json-server --watch db.json