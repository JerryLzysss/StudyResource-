[TOC]
# TypeScript Map映射
Map 对象保存键值对，并且能够记住键的原始插入顺序。
任何值(对象或者原始值) 都可以作为一个键或一个值。
Map 是 ES6 中引入的一种新的数据结构，可以参考 ES6 Map 与 Set。

# 创建
```
let myMap=new Map();
let myMap = new Map([
        ["key1", "value1"],
        ["key2", "value2"]
    ]); 
```

# 函数与属性
函数|描述
--|--
map.clear() | 移除 Map 对象的所有键/值对 。
map.set() | 设置键值对，返回该 Map 对象。
map.get() | 返回键对应的值，如果不存在，则返回 undefined。
map.has() | 返回一个布尔值，用于判断 Map 中是否包含键对应的值。
map.delete() | 删除 Map 中的元素，删除成功返回 true，失败返回 false。
map.size | 返回 Map 对象键/值对的数量。
map.keys() | 返回一个 Iterator 对象， 包含了 Map 对象中每个元素的键 。
map.values() | 返回一个新的Iterator对象，包含了Map对象中每个元素的值 。

# 编译方式
tsc --target es6 xxx.ts =>以ES6的形式进行编译

# 迭代
```
// 迭代 Map 中的 key
for (let key of nameSiteMapping.keys()) {
    console.log(key);                  
}
// 迭代 Map 中的 value
for (let value of nameSiteMapping.values()) {
    console.log(value);                 
}
// 迭代 Map 中的 key => value
for (let entry of nameSiteMapping.entries()) {
    console.log(entry[0], entry[1]);   
}
// 使用对象解析
for (let [key, value] of nameSiteMapping) {
    console.log(key, value);            
}
```