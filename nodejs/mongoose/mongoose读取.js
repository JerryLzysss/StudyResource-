//1.安装mongoose
//npm install mongoose
//2.导入mongoose
const mongoose= require('mongoose');

//3.连接mongodb服务(mongodb://地址+数据库)
//数据库不存在自动创建
mongoose.connect('mongodb://127.0.0.1:27017/admin');

/* mongoose.set('strictQuery',true)避免MONGODB7的警告 */

//4.设置回调
//mongoose.connection.once(事件回调只执行一次)
mongoose.connection.on('open',()=>{
    console.log('连接成功');
    /* 设置集合中文档属性及其属性值 */
    let bookSchema=new mongoose.Schema({
    name:{
        type:String,
        required:true
    },
    author:String,
    Price:Number,
    Date:Date,
    Random:mongoose.Schema.Types.Mixed

    });
    /* 创建模型对象 对文档操作的封装对象 */
    let bookModel=mongoose.model('books',bookSchema);
    /* 单独读取 */
    bookModel.findOne({name:'1'},(err,data)=>{
        if(err)
        {
            console.log(err);
            return ;
        }
        /* 属性填写错误时将不会写入 */
        console.log("1!");
        console.log(data);
        /* mongoose.disconnect()关闭数据库连接 ,项目运行不会选择关闭*/
      //  mongoose.disconnect();
    });
    /* 根据ID读取 */
    bookModel.findById('6506e34a1d377d686c35dd4f',(err,data)=>{
        if(err)
        {
            console.log(err);
            return ;
        }
        /* 属性填写错误时将不会写入 */
        console.log("2!");
        console.log(data);
        /* mongoose.disconnect()关闭数据库连接 ,项目运行不会选择关闭*/
      //  mongoose.disconnect();
    });
    /* 批量读取 */
    bookModel.find((err,data)=>{
        if(err)
        {
            console.log(err);
            return ;
        }
        /* 属性填写错误时将不会写入 */
        console.log("3!");
        console.log(data);
        /* mongoose.disconnect()关闭数据库连接 ,项目运行不会选择关闭*/
      //  mongoose.disconnect();
    });


/* 如果没有出错可以使用console.log(data)来返回插入后的文档 */

/* 关闭数据库连接 */


});//设置连接成功回调
mongoose.connection.on('error',()=>{
    console.log('连接失败');
});//设置连接失败回调
mongoose.connection.on('close',()=>{
    console.log('连接关闭');
});//设置连接关闭回调

/* 
setTimeout(()=>{
    mongoose.disconnect();
},2000)  */


/* 数据类型:
String 字符串
Number 数字
Boolean 布尔值
Array 数组
Date 日期
Buffer 缓存池BUFFER对象
Mixed 任意类型,需要使用mongoose.Schema.Types.Mixed
ObjectId 对象ID，需要使用mongoose.Schema.Types.ObjectId
Decimal128 高精度数字，需要使用mongoose.Schema.Types.Decimal128 */

/* 验证器:
必填项:   name:{
        type:String,
        required:true
    }
默认值:name{
    type:String,
    default:'ok'
    }
枚举值:name{
    type:String,
    enum:['1','2','3']
    如果不在枚举值则报错
唯一值:name{
    type:String
    unique:true
}(需要重建集合，否则不能使用)



}

*/