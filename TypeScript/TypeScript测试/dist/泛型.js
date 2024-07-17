/* 在定义函数或者是类的时候如果遇到类型不明确的可以使用泛型 */
function fn(a) {
    console.log(a);
}
fn('1'); /* 不指定泛型，T是可以自动对类型进行推断 */
fn('hello'); //指定泛型
function fn2(a, b) {
    console.log(a + " " + b);
}
/* 泛型可以指定多个 */
fn2(1, '1');
/* 表示泛型T必须是Inter实现类 */
function fn3(a) {
    return a.length;
}
fn3('123');
fn3({ length: 10 });
