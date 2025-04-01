# Threads 进程
进程:在内存中执行的应用程序
线程:是线程中最小的执行单元
线程作用:负责当前进程中程序的运行，一个进程中至少有一个线程，可以有多个
# 并发和并行
并行:在同一个时刻，有多个执行在多个CPU同时执行
并发:在同一个时刻，有多个指令在单个CPU上交替执行
# CPU调度
分时调度:指的是让所有的线程轮流获取CPU使用权，并且平均分配每个线程占用CPU的时间片
抢占式调度:多个线程轮流抢占CPU使用权，优先级高的先使用.java使用的就是抢占式
# 创建线程
## 第一种方法:
1. 定义一个类，继承Thread
2.重写run方法，在run方法中执行线程
3.创建自定义线程类对象
4.调用Thread中的start方法
原理:开启一个多线程，会开启一个栈空间去运行
## 第二种方法:
1.创建类实现runnable接口
2.重写run方法，设置线程任务
3.利用Thread的构造方法：Thread(target)创建Thread对象，将自定义的类当参数传递到Thread构造
4.利用Thread的start方法开启线程
# 常用方法
start()启用线程
run()设置线程任务
getName()获取线程名字
setName()设置线程名字
Thread currentThread()获取当前线程对象
sleep（millis）线程睡眠
注意:重写的run方法有异常，只能try不能throws,犹豫继承的run方法没有抛出异常，所以重写完后也不能抛异常只能try

# 线程优先级

## 方法
setPriority(priority) 设置线程优先级，优先级越高的线程，概率越高
getPriority()获取线程优先级
setDaemon(on) 设置为守护线程，当非守护线程执行完毕，守护线程就要结束
yield() 礼让线程，当前线程让出CPU使用权
join() 插入线程或者叫做插队线程
## 解释
礼让线程:两个线程是尽可能的平衡，不是绝对的交替进行.
插入线程:表示把某线程插入到当前线程之前.

# 线程安全
概述:多个用户同时访问同一资源的时候产生了不安全的情况
原因:CPU在多个线程之间高速切换导致的.

## 第一种方式-同步代码块
synchronized(){
    不安全的代码
}
任意对象:就是我们的锁对象
一个线程拿到锁之后，会进入到同步代码块中执行，在此期间，其他线程拿不到锁，就进不去同步代码块，需要在代码块外面等待排队。
## 第二种方式-同步方法
支持静态static,
synchronized function(){
    return ...
}
其实就是把上锁的步骤放到了方法里面.
默认锁:class对象
## 第三种方式-Callable
概述:Callable是一个接口，类似于run方法
方法:call()
相同点:call和run都是设置线程任务的
不同点:call有返回值，并且有异常可以throws,run没有返回值，并且有异常不可以throws.
Callable带有泛型\<v>,不填写则默认是object类型,返回值与该泛型类型一致
获取:FutureTask<V>
其中的get()方法获取其返回值
## 第四种方式-线程池
创建线程池对象:用具类:Executors
获取线程池对象:Executors的静态方法
ExecutorsService newFixedThreadPool(n)Threads 指定线程池最多的线程对象数
执行线程任务:ExecutorService的方法
* Future<?>submit(Runnable task)提交runnable任务
* Future\<T>submit(callable\<T>task)提交callable方法
submit的返回值时Future接口，但是run没有返回值，call是有返回值的需要用Future接收.
# 死锁
概述:两个或两个以上的线程在执行的过程中由于竞争同步锁而产生的阻塞现象。
也就是两个锁之间互相嵌套

# 线程状态
线程状态|导致状态发生条件
---|---
NEW|线程创建未启动
Runnable|可以在运行的
Blocked|被堵塞当一个线程试图获取对象锁的时候，而其他线程拥有，如果获取成功则转为Runnable
Waiting|一个线程在等待另一个线程执行的时候，进入这个状态后需要另一个状态使用notify或者notifyAll唤醒
Timed Waiting|同样是waiting,但是不同的是有超时参数，这一状态将保持到超时期满或者收到唤醒通知,例如Thread.sleep或者Object.wait.
Terminated|因为run或者没有捕获的异常而导致的终止.
## 状态方法的注意点
sleep(time):线程睡眠，线程是不会释放锁的，其他线程抢不到锁，时间到了自动醒来继续执行.
wait(time):线程等待，这个过程会释放锁，其他线程可以抢到，如果在等待的过程中被唤醒或者时间超时，其他线程重新抢锁，抢到了继续执行，否则阻塞
notify():会唤醒正在等待的线程，一次只能唤醒一条，如果有多条等待则随机唤醒
wait和notify两个方法都需要锁对象调用，所以都需要用到同步代码块，并且必须是同一个锁对象调用.
# Lock锁
概述:Lock是一个接口
实现类:ReentrantLock
方法:lock() 获取锁
unlock() 释放锁
不同点Synchronized不管是同步代码块还是方法都需要在结束后释放锁对象
Lock:是通过两个办法控制需要被同步的代码.
# Timer
概述:定时器.
构造:Timer()
方法:void schedule(Timertask task,Date firstTime,long Period)
task:抽象类,runnable的实现类
firstTime:从什么时候开始执行
period:每隔多长时间执行一次