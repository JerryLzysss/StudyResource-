# TypeScript String

## 使用
```
var sites:string[]; 
sites = ["Google","Runoob","Taobao"]
var arr_names:number[] = new Array(4)  //声明数组大小
```
## 数组解构
通过一对一的形式将元素以映射的形式从数组中解构出来
```
var arr:number[] = [12,13] 
var[x,y] = arr // 将数组的两个元素赋值给变量 x 和 y
console.log(x) //12
console.log(y) //13
```
## 数组迭代
```
var j:any; 
var nums:number[] = [1001,1002,1003,1004] 
 
for(j in nums) { 
    console.log(nums[j]) 
}
```
## 多维数组
其实就是数组的嵌套
```
var arr_name:datatype[][]=[ [val1,val2,val3],[v1,v2,v3] ]
```
## 函数传递
```
function disp(arr_sites:string[]) {
        for(var i = 0;i<arr_sites.length;i++) { 
                console.log(arr_sites[i]) 
        }  
}  
```
disp(sites);
## 函数返回
```
function disp():string[] { 
        return new Array("Google", "Runoob", "Taobao", "Facebook");
} 
```
## 方法
使用方法:
```
var alpha = ["a", "b", "c"]; 
var beta = ["a", "b", "c"]; 
alpha.concat(beta)
```
函数|描述
--|--
concat()|连接两个或更多的数组，并返回结果。
every()|检测数值元素的每个元素是否都符合条件。
filter()|检测数值元素，并返回符合条件所有元素的数组。
forEach()|数组每个元素都执行一次回调函数。
indexOf()|搜索数组中的元素，并返回它所在的位置。如果搜索不到，返回值 -1，代表没有此项。
join()|把数组的所有元素放入一个字符串。
lastIndexOf()|返回一个指定的字符串值最后出现的位置，在一个字符串中的指定位置从后向前搜索。
map()|通过指定函数处理数组的每个元素，并返回处理后的数组。
pop()|删除数组的最后一个元素并返回删除的元素。
push()|向数组的末尾添加一个或更多元素，并返回新的长度。
reduce()|将数组元素计算为一个值（从左到右）。
reduceRight()|将数组元素计算为一个值（从右到左）。
reverse()|反转数组的元素顺序。
shift()|删除并返回数组的第一个元素。
slice()|选取数组的的一部分，并返回一个新数组。
some()|检测数组元素中是否有元素符合指定条件。
sort()|对数组的元素进行排序。
splice()|从数组中添加或删除元素。
toString()|把数组转换为字符串，并返回结果。
unshift()|向数组的开头添加一个或更多元素，并返回新的长度。