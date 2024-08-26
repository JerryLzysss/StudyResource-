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
    bookModel.find({Price:{$lt: 100}},(err,data)=>{
        if(err)
        {
            console.log('读取失败');
            return;
        }
        console.log(data);
    });

    bookModel.find({$or:[{Price:{$lt: 99}},{Price:{$gt:101}}]},(err,data)=>{
        if(err)
        {
            console.log('读取失败');
            return;
        }
        console.log(data);
    });

    bookModel.find({name:new RegExp('2')},(err,data)=>{
        if(err)
        {
            console.log('读取失败');
            return;
        }
        console.log(data);
    });
   /* 条件设置
   1.采用替代符号
   $gt 大于
   $lt 小于
   $gte 大于等于
   $lte 小于等于
   $ne 不等于
   $or 或
   $and 与
   
   2.采用正则匹配的方式
   */
      


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