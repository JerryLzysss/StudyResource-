/* 字符编码使用 */
const buf = Buffer.from('runoob', 'ascii');
console.log(buf.toString('hex'));
console.log(buf.toString('base64'));
/* buffer类使用 */
const buf1 = Buffer.alloc(10);
const buf2 = Buffer.alloc(10, 1);
const buf3 = Buffer.allocUnsafe(10);
const buf4 = Buffer.from([1, 2, 3]);
const buf5 = Buffer.from('tést');
const buf6 = Buffer.from('tést', 'latin1');
console.log(buf1,buf2,buf3,buf4,buf5,buf6)
/* buffer方法使用 */
var buf7 = Buffer.from('abcdefghijkl');
var buf8 = Buffer.from('RUNOOB');
buf7.copy(buf8, 2);
console.log(buf7.toString());
var buffer1 = Buffer.from('ABC');
var buffer2 = Buffer.from('ABCD');
var result = buffer1.compare(buffer2);
if(result < 0) {
   console.log(buffer1 + " 在 " + buffer2 + "之前");
}else if(result == 0){
   console.log(buffer1 + " 与 " + buffer2 + "相同");
}else {
   console.log(buffer1 + " 在 " + buffer2 + "之后");
}

