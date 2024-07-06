[TOC]
# promise目录

- 01.html [ Promise初次使用 ]
- 02.js [ Promise使用于异步任务(fs) ]
- 03.html [ Promise用于异步任务(http) ]
- 04.js [ Promise封装 ]
- 05.js [ Promisify方法 ]
- 06.html [ Promise用于异步任务(ajax) ]
- 07.html [ Promise方法运用 ]
  - 08.html
  - 09.html
  - 10.html
- 自定义Promise.js [ 底层Promise实现 ]
- Promise1.html [ 涉及promise的题目]
  - Promise2.html
  - Promise3.html
  - Promise4.html
  - test.html
  - test2.html
  - test3.html
  
# promise介绍
一种异步变成的解决方案，用于让异步操作请求变得更加直观和易于理解,主要是用来解决回调地狱问题.

## 回调函数
当一个函数作为参数传入另一个参数中，并且它不会立即执行，只有当满足一定条件后该函数才可以执行，这种函数就称为回调函数。我们熟悉的定时器和Ajax中就存在有回调函数：
```
setTimeout(function(){   //function(){console.log('执行了回调函数')}就是回调函数，它只有在3秒后才会执行
	console.log('执行了回调函数');
},3000)  //3000毫秒
```
## 异步任务
与之相对应的概念是“同步任务”，同步任务在主线程上排队执行，只有前一个任务执行完毕，才能执行下一个任务。异步任务不进入主线程，而是进入异步队列，前一个任务是否执行完毕不影响下一个任务的执行。
```
setTimeout(function(){
            console.log('执行了回调函数');
        },3000)
        console.log('111');
```

## 回调地狱

根据前面我们可以得出一个结论：存在异步任务的代码，不能保证能按照顺序执行。
```
        setTimeout(function () {  //第一层
            console.log('1');
            setTimeout(function () {  //第二程
                console.log('2');
                setTimeout(function () {   //第三层
                    console.log('3');
                }, 1000)
            }, 2000)
        }, 3000)
```
可以看到，代码中的回调函数套回调函数，居然套了3层，这种回调函数中嵌套回调函数的情况就叫做回调地狱。
总结一下，回调地狱就是为是实现代码顺序执行而出现的一种操作，它会造成我们的代码可读性非常差，后期不好维护。


## 异步操作
如上述所说需要解决相关的回调地狱问题，
那么下面集中操作是涉及到异步操作，也就是需要使用promise解决的操作.
* fs文件操作
* 数据库操作
* ajax操作
* 定时器


# promise状态
实例对象的一个属性 [PromiseState]
* pending 判断
* resolved/fulfilled 成功
* rejected 失败
# promise结果
1.pending 变为 resolved
2.pending 变为 rejected
说明:只有这2种，且一个promise对象只能改变一次，
无论成功还是失败只会有一个结果
成功的数据叫value,失败的数据叫reason
# promise对象值
实例对象中的另一个属性 [PromiseResult]
保存着异步对象成功/失败的结果
* resolve
* reject

# promise对象流程

## 1.Promise(executor){}
(1)executor函数:执行器(resolve,reject)=>{}
(2)resolve函数:内部定义成功时调用函数:resolve()
(3)rejects函数:内部定义失败时调用函数:reject()
说明:executor会在promise内部立即同步调用，异步操作在执行器中执行

## 2.Promise.protoype.then
方法:Promise.protoype.then(onResolved,onRejected)=>{}
(1)onResolved函数:成功的回调函数(value)=>{}
(2)onRejected函数:失败的回调函数(reason)=>{}
说明:指定用于得到value的成功回调和用于的到失败reason的回调,返回一个新的promise对象

## 3.Promise.prototype.catch
Promise.prototype.catch(OnRejected)=>{}
(1)onRejected函数:失败回调函数(reason)=>{}

## 4.Promise.resolve
方法:Promise.resolve(value)=>{}
(1)value:成功的数据或promise对象
说明:返回一个成功/的promise对象
返回一个非Promise对象时为成功
如果传入为Promise对象则参数的结果决定resolve结果
## 5.Promise.reject
方法:Promise.reject(reason)=>{}
(1)reason:失败的原因
说明:返回一个失败的reason

## 6.Promise.all
方法:Promise.all{promises}=>{}
(1)Promises:包含n个promise的数组
(2)返回一个新的promise,只有所有的promise对象都成功才成功，否则直接失败

## 7.Promise.race
方法:{promises}=>{}
(1)Promises:包含n个promise的数组
说明:返回一个新的promise,第一个完成的promise的结果状态就是最终的结果状态

## 8.Promise的状态改变方法
 /* 1.resolve函数 */
/*  resolve('ok')*/
/* 2.reject函数 */
/* reject('error') */
/* 3.抛出错误 */
/* throw 'err' */

## 9.Promise指定多个成功/失败函数
当Promise改变为对应状态都会调用

## 10.改变Promise状态和指定回调函数谁先谁后
（1）都有可能，正常情况是先指定回调在改变状态
（2）如何先改变状态在执行回调
1.在执行器直接调用resolve()/reject()
2.延迟更长时间才调用then{}
(3)怎样才能得到数据（回调函数什么时候执行）
（1）如果先指定回调，那状态改变，回调函数调用得到数据
（2）如果先改变状态，当指定回调，回调函数就会调用，得到数据

## 11.Promise.then()返回的promise结果与其value有关系
由then()指定的回调函数执行的结果决定
如果抛出异常:promise变为rejected，reason为抛出的异常
如果返回的是非promise对象的任意值，promise会变为resolved,value返回的值
如果返回的是另一个新的promise,此promise的结果会变成新promise的结果

## 12.promise如何串联多个操作任务
（1）promise的then()返回一个新的Promise，可以开成then()的链式调用

## 13.promise异常穿透
(1)当使用promise的then链式调用，可以在最后指定失败的回调
（2）前面操作出现异常，都会传到最后失败的回调处理。

## 14.中断promise链
返回pending状态的promise对象

