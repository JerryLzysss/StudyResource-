[TOC]
# UML
序列图是一种交互图，显示进程如何彼此运行以及以什么顺序运行。该序列图不同于基础的序列图.
# 基本使用
```mermaid
zenuml
    title Demo
    Alice->John: Hello John, how are you?
    John->Alice: Great!
    Alice->John: See you later!
```
# 语法
## 参加者
参与者或参与者按照图表源文本中的出现顺序渲染。有时，你可能希望以不同于第一条消息中的顺序显示参与者。可以通过执行以下操作来指定角色的出场顺序：
```mermaid
zenuml
    title Declare participant (optional)
    Bob
    Alice
    Alice->Bob: Hi Bob
    Bob->Alice: Hi Alice
```
## 注释者
特别想使用符号而不仅仅是带有文本的矩形，你可以通过使用注释器语法来声明参与者，如下所示.
```mermaid
zenuml
    title Annotators
    @Actor Alice
    
    @Database Bob
    Alice->Bob: Hi Bob
    Bob->Alice: Hi Alice
```

相关的注释器还有如下
<img src='./image.png' alt=''>

## 别名
参与者可以有一个方便的标识符和描述性标签。
```mermaid
zenuml
    title Aliases
    A as Alice
    J as John
    A->J: Hello John, how are you?
    J->A: Great!
```
## 信息
消息可以是以下之一：
同步消息
异步消息
创建消息
响应消息
### 同步信息
```mermaid
zenuml
    title Sync message
    A.SyncMessage
    A.SyncMessage(with, parameters) {
      B.nestedSyncMessage()
    }
```
### 异步信息
```mermaid
zenuml
    title Async message
    Alice->Bob: How are you?
```
### 创建信息
```mermaid
zenuml
    new A1
    new A2(with, parameters)
```
### 响应信息
```mermaid
zenuml
    // 1. assign a variable from a sync message.
    a = A.SyncMessage()

    // 1.1. optionally give the variable a type
    SomeType a = A.SyncMessage()

    // 2. use return keyword
    A.SyncMessage() {
    return result
    }

    // 3. use @return or @reply annotator on an async message
    @return
    A->B: result
```
### 信息嵌套
同步消息和创建消息自然可以与 {} 嵌套。
```mermaid
zenuml
    A.method() {
      B.nested_sync_method()
      B->C: nested async message
    }
```
## 循环
通过以下几种方式实现：
1.while
2.for
3.forEach
4.loop
```mermaid
zenuml
    Alice->John: Hello John, how are you?
    while(true) {
      John->Alice: Great!
    }
```
## 判断
通过if...else实现
```mermaid
zenuml
    Alice->Bob: Hello Bob, how are you?
    if(is_sick) {
      Bob->Alice: Not so good :(
    } else {
      Bob->Alice: Feeling fresh like a daisy
    }
```
## 选择
通过opt实现
``` mermaid
zenuml
    Alice->Bob: Hello Bob, how are you?
    Bob->Alice: Not so good :(
    opt {
      Bob->Alice: Thanks for asking
    }
```
## 异常捕获
通过try/catch/finally来实现.
```mermaid
zenuml
    try {
      Consumer->API: Book something
      API->BookingService: Start booking process
    } catch {
      API->Consumer: show failure
    } finally {
      API->BookingService: rollback status
    }
```

