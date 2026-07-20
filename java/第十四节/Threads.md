# 线程（Threads）

## 进程与线程

- **进程**：在内存中运行的应用程序
- **线程**：进程中的最小执行单元

一个进程至少有一个线程，也可以有多个线程。

## 并发和并行

- **并行**：同一时刻，多个任务在多个 CPU 上同时执行
- **并发**：同一时刻，多个任务在单个 CPU 上交替执行

## CPU 调度

- **分时调度**：线程轮流获得 CPU，时间片大致平均
- **抢占式调度**：线程竞争 CPU，优先级高的更可能先执行；Java 使用抢占式调度

## 创建线程

### 方式一：继承 Thread

1. 定义类继承 `Thread`
2. 重写 `run`，编写线程任务
3. 创建对象并调用 `start()`

### 方式二：实现 Runnable

1. 定义类实现 `Runnable`
2. 重写 `run`
3. `new Thread(runnable).start()`

### 方式三：Callable + FutureTask

- `call()` 可有返回值，并可声明抛出异常
- 通过 `FutureTask` / `Future.get()` 获取返回值

## 常用方法

| 方法 | 作用 |
|------|------|
| `start()` | 启动线程 |
| `run()` | 线程任务（由线程调度调用） |
| `getName()` / `setName()` | 获取/设置线程名 |
| `Thread.currentThread()` | 当前线程对象 |
| `sleep(millis)` | 休眠指定毫秒 |

注意：重写 `Thread.run` 时，若有受检异常，通常只能 `try-catch`，不能 `throws`（因为父类 `run` 未声明抛出）。

## 线程优先级与协作

- `setPriority` / `getPriority`：优先级
- `setDaemon(true)`：守护线程；非守护线程结束后，守护线程会随之结束
- `yield()`：礼让，尽量让出 CPU（不保证严格交替）
- `join()`：等待该线程执行结束（常说「插队等待」）

## 线程安全

多个线程同时访问共享资源时可能出现数据不一致，常用同步手段：

### 1. 同步代码块

```java
synchronized (锁对象) {
    // 不安全代码
}
```

同一把锁下，同时只能有一个线程进入同步块。

### 2. 同步方法

```java
synchronized void function() {
    // ...
}
```

实例方法默认锁是 `this`；静态同步方法锁是类的 `Class` 对象。

### 3. Lock

- 接口：`Lock`；常用实现：`ReentrantLock`
- `lock()` 获取锁，`unlock()` 释放锁（建议放在 `finally` 中）

## 线程池

工具类：`Executors`

示例：

```java
ExecutorService pool = Executors.newFixedThreadPool(n); // 最多 n 个工作线程
Future<?> f1 = pool.submit(runnableTask);
Future<T> f2 = pool.submit(callableTask);
```

`submit` 返回 `Future`；`Callable` 的结果可通过 `Future.get()` 获取。

## 死锁

两个及以上线程互相等待对方持有的锁，导致永久阻塞。典型原因是多把锁嵌套获取顺序不一致。

## 线程状态

| 状态 | 含义 |
|------|------|
| NEW | 已创建未启动 |
| RUNNABLE | 可运行（含正在运行/等待调度） |
| BLOCKED | 等待获取监视器锁而阻塞 |
| WAITING | 无限等待，需被 `notify` / `notifyAll` 等唤醒 |
| TIMED_WAITING | 限时等待，如 `sleep`、带超时的 `wait` |
| TERMINATED | 已结束 |

### wait / sleep / notify

- `sleep`：不释放已持有的锁，时间到后继续
- `wait`：释放锁并等待；被唤醒或超时后需重新竞争锁
- `notify` / `notifyAll`：唤醒等待线程
- `wait` / `notify` 必须由同一把锁对象在同步代码中调用

## Timer

定时任务工具（较旧，现代项目更常用 `ScheduledExecutorService`）。

- `schedule(TimerTask task, Date firstTime, long period)`
- `TimerTask`：抽象类，实现 `Runnable`
