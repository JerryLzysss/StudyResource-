var fs = require("fs");
var zlib = require('zlib');

/* 读取操作 */
// 创建可读流
var readerStream = fs.createReadStream('stream.txt');
// 设置编码为 utf8。
readerStream.setEncoding('UTF8');
var data = '';
// 处理流事件 --> data, end, and error
readerStream.on('data', function(chunk) {
   data += chunk;
});
readerStream.on('end',function(){
   console.log(data);
});
readerStream.on('error', function(err){
   console.log(err.stack);
});
console.log("读取程序执行完毕");

/* 写入操作 */
var writeData = '123';
// 创建一个可以写入的流，写入到文件 output.txt 中
var writerStream = fs.createWriteStream('output.txt');
// 使用 utf8 编码写入数据
writerStream.write(writeData,'UTF8');
// 标记文件末尾
writerStream.end();
// 处理流事件 --> finish、error
writerStream.on('finish', function() {
    console.log("写入完成。");
});
writerStream.on('error', function(err){
   console.log(err.stack);
});
console.log("写入程序执行完毕");

/* 管道读写操作 */
// 读取 stream.txt 文件内容，并将内容写入到 pipe-output.txt 文件中
var pipeReader = fs.createReadStream('stream.txt');
var pipeWriter = fs.createWriteStream('pipe-output.txt');
pipeReader.pipe(pipeWriter);
console.log("管道程序执行完毕");

/* 链式操作  需要导入zlib*/
// 压缩 stream.txt 文件为 stream.txt.gz
fs.createReadStream('stream.txt')
  .pipe(zlib.createGzip())
  .pipe(fs.createWriteStream('stream.txt.gz'));
console.log("文件压缩完成。");

// 解压到 decompress-output.txt，避免覆盖原 stream.txt
fs.createReadStream('stream.txt.gz')
  .pipe(zlib.createGunzip())
  .pipe(fs.createWriteStream('decompress-output.txt'));
console.log("文件解压完成。");
