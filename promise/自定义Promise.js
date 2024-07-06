/* 
自定义Promise函数模块:IIFE
*/
(function(window){
    /* promise构造函数
    executor 执行器(同步执行)*/
    
    function Promise(excutor){
        /* 立即同步执行excutor */
       const that=this
        that.status='pending'/* 给Promise对象指定status属性，初始值为pending */
        that.data='undefined'/* 给Promise对象指定一个用于存储结果是数据的属性 */
        that.callbacks=[]/* 每个元素的结构:{onResolved(){},onRejected(){}} */
        function resolve(value){
            /* 如果当前状态不是pending,直接结束 */
            if(that.status!=='pending')
            return 

            /* 将状态改变为resolved */
            that.status='resolved'
            /* 保存value数据 */
            that.data=value
            /* 如果有执行的callback函数，立刻执行回调 */
            if(that.callbacks.length>0)
            {
                setTimeout(()=>{
                    that.callbacks.forEach(callbacksObj=>{
                    callbacksObj.onResolved(value)
                        })
                    }
                )
            }
        }
        function reject(reason){
            if(that.status!=='pending')
            return 
             /* 将状态改变为resolved */
             that.status='rejected'
             /* 保存value数据 */
             that.data=reason
             /* 如果有执行的callback函数，立刻执行回调 */
             if(that.callbacks.length>0)
             {
                 setTimeout(()=>{
                     that.callbacks.forEach(callbacksObj=>{
                     callbacksObj.onRejected(reason)
                         })
                     }
                 )
             }
        }
        try
        {
            excutor(resolve,reject)
        }
        catch(error)
        {
            reject(error)
        }
    }
   
    /* Promise原型对象的then()
    指定成功和失败的回调函数
    返回一个新的promise对象 */
    Promise.prototype.then=function(onResolved,onRejected){
        const that=this
        onResolved=typeof onResolved==='function'?onResolved:value=>value/* 向后传递原因 */
        /* 指定默认的失败回调（实现错误/异常穿透的关键点） */
        onRejected=typeof onRejected==='function'?onRejected:reason=>{throw reason}
      
      
        /* 返回一个新的Promise对象 */
        return new Promise((resolve,reject)=>{
            /* 指定回调函数 */
           function handle(callback) {
        /* 1.回调函数抛出异常，则返回的Promise就会失败，reason就是error
          2. 回调函数返回的不是 promise，则返回的promise就会成功，value就是result
          3.回调函数返回的是promise，则返回的promise取决于这个promise
        */
       
        try {
          const result = callback(that.data)
          if (result instanceof Promise) {
            // 3.回调函数返回的是promise，则返回的promise取决于这个promise
            result.then(
              value => resolve(value), // 当result成功，返回的promise也成功
              reason => reject(reason) // 当result失败，返回的promise也失败
            )
            // result.then(resolve, reject) // 等同写法
          } else {
            //2. 回调函数返回的不是 promise，则返回的promise就会成功，value就是result
            resolve(result)
          }
        } catch (error) {
          // 1.回调函数抛出异常，则返回的Promise就会失败，reason就是error
          reject(error)
        }
      }
           if(that.status==='pending')
           {
                that.callbacks.push({
                    onResolved(value){
                        handle(onResolved)
                    },
                    onRejected(reason){
                        handle(onRejected)
                    }
                })
           }
           else if(that.status==='resolved')
           {
                setTimeout(()=>{
                    /* 
                    1.如果抛出异常，return中的promise就会失败，return是error
                    2.如果回调函数返回不是promise,return的promise会成功，value就是返回的值
                    3.如果回调函数返回是promise,return的promise结果就是这个promise的结果
                     */
                    handle(onResolved)
                })
           }
           else
           {
            setTimeout(()=>{
                /* 
                1.如果抛出异常，return中的promise就会失败，return是error
                2.如果回调函数返回不是promise,return的promise会成功，value就是返回的值
                3.如果回调函数返回是promise,return的promise结果就是这个promise的结果
                 */
                handle(onRejected)
            })
           }

        })
    }
    
    Promise.prototype.catch=function(onRejected){
        return this.then(undefined,onRejected)
    }
    /* Promise函数对象resolve方法
    返回一个成功的promise */
    Promise.resolve=function(value){
        return new Promise((resolve,reject)=>{
            /* value是promise */
            if(value instanceof Promise){
                value.then(resolve,reject)
            }
            else{
                resolve(value)
            }
        })
    }

    /* Promise函数对象reject 
    返回一个指定reason的失败的promise*/
    Promise.reject=function(reason){
        return new Promise((resolve,reject)=>{
            reject(reason)
        })
    }
    /* Promise函数对象all 
    返回一个promise只有当所有promise都成功才成功，否则失败*/
    Promise.all=function(promises){
       return new Promise((resolve,reject)=>{
        const values=new Array(promises.length)
        let resolvedCount=0
        /* 遍历promises获取每个promise的结果 */
       promises.forEach((p,index)=>{
            Promise.resolve(p).then(
                value=>{
                    resolvedCount++
                    values[index]=value
                    /* 如果全部成功，返回resolve */
                    if(resolvedCount===promises.length){
                        resolve(values)
                    }
                    else{
                        reject(reason)
                    }
                },
                reason=>{
                    reject(reason)
                }
            )
        })
       })
    }
    /* Promise函数对象的race
    返回一个promise，结果由第一个完美的promise决定 */
    Promise.race=function(promises){
        return new Promise((resolve,reject)=>{
            promises.forEach((p,index)=>{
                Promise.resolve(p).then(/* 第一个一旦有成功则成功，一旦有失败则失败*/
                    value=>{
                        resolve(value)
                    },
                    reason=>{
                        reject(reason)
                    }
                )
            })
        })
    }
    /* 返回一个Promise，在指定时间后才确定结果 */
    Promise.resolveDelay=function(value,time)
    {
        
            return new Promise((resolve,reject)=>{
                setTimeout(()=>{
                    if(value instanceof Promise){
                        value.then(resolve,reject)
                    }
                    else{
                        resolve(value)
                    }
                },time)
            })
      
    }
    Promise.rejectDelay=function(reason,time)
    {
        
            return new Promise((resolve,reject)=>{
                setTimeout(()=>
                {reject(reason)},time)
            })
        
    }
    /* 向外暴露Promise函数 */
    window.Promise=Promise
})(window)
