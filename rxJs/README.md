[TOC]

# RxJS 中文学习文档

RxJS 是一个专为处理异步数据流而设计的强大 JavaScript 库。它通过一种被称为 Observable (可观察对象) 的核心类型，将各种异步事件（如HTTP请求、DOM事件、定时器等）统一为随时间推送的数据流，让你能用一套一致、声明式且功能丰富的API来编写和处理复杂的异步逻辑。

它的主要作用可以概括为以下几点：

* 统一处理异步世界：它将所有异步操作（如用户点击、网络请求、定时器）都转化为数据流，使用统一的接口进行管理，告别了传统的回调函数和容易失控的Promise。

* 声明式数据处理：RxJS 提供了大量纯函数式的操作符（如 map、filter、mergeMap 等）。你可以像组装管道一样组合这些操作符，以声明的方式描述数据的流动和变换，让代码变得简洁且易于理解，有效避免了"回调地狱"。

* 增强代码的弹性：它内置了强大的错误处理机制，如 catchError 和 retry，允许你优雅地处理错误，甚至在某些操作失败时自动重试，使应用在面对网络波动等问题时更加健壮。

* 优化性能和状态管理：利用 debounceTime、throttleTime 等操作符，可以轻松控制高频事件（如搜索框输入、滚动事件）的处理频率，提升应用性能。同时，Subject 及其变种还能作为一种轻量级的状态管理工具，方便地在应用的不同部分共享和同步数据。

## 安装

### yarn/npm/pnpm
```
npm install rxjs
yarn add rxjs
pnpm add rxjs
```

### script<CDN>
```
<script src="https://unpkg.com/rxjs@7/dist/bundles/rxjs.umd.min.js"></script>

```
### Angular Cli
Angular本身依赖于rxjs,不需要单独安装,直接引入即可
```
import {Observable,of} from 'rxjs';
```

## 目录结构

```
rxJs/
├── README.md              # 本说明文件
├── overview/              # 总览教程（入门）
├── docs/                  # 文字说明文档（中文文件名）
├── index/                 # RxJS API 索引
├── operators/             # RxJS 运算符
├── ajax/                  # Ajax 模块
├── fetch/                 # Fetch 模块
├── webSocket/             # WebSocket 模块
└── testing/               # 测试模块
```

## 快速开始

1. 用浏览器直接打开任意 `.html` 文件即可阅读与运行演示。
2. 建议从 `overview/` 总览教程开始，再按需查阅 API 与运算符。
3. 所有演示依赖 CDN 加载 RxJS，需联网。

## 总览教程（overview/）

| 文件 | 主题 |
|------|------|
| [observable-overview.html](overview/observable-overview.html) | Observable 可观察对象 |
| [observer-pattern.html](overview/observer-pattern.html) | Observer 观察者模式 |
| [operators-overview.html](overview/operators-overview.html) | Operators 运算符概览 |
| [subscription-overview.html](overview/subscription-overview.html) | Subscription 订阅 |
| [subject-overview.html](overview/subject-overview.html) | Subject 主题 |
| [scheduler-overview.html](overview/scheduler-overview.html) | Scheduler 排程器 |
| [animation-frame.html](overview/animation-frame.html) | animationFrameScheduler 动画帧调度 |
| [example.html](overview/example.html) | 综合示例 |

## 说明文档（docs/）

| 文件 | 说明 |
|------|------|
| [介绍.md](docs/介绍.md) | RxJS 简介 |
| [安装.md](docs/安装.md) | 安装方式 |

## API 索引（index/）

共 **73** 个页面，涵盖创建函数、Subject、调度器、类型定义与错误类等。

### 调度器

| 文件 | 说明 |
|------|------|
| [asap.html](index/asap.html) | 尽快调度程序 |
| [async.html](index/async.html) | 异步调度程序 |
| [queue.html](index/queue.html) | 队列调度程序 |
| [VirtualTimeScheduler.html](index/VirtualTimeScheduler.html) | 虚拟时间调度器 |

> 动画帧调度器见 [overview/animation-frame.html](overview/animation-frame.html)

### Subject 系列

| 文件 | 说明 |
|------|------|
| [Subject.html](index/Subject.html) | 基本主题 |
| [BehaviorSubject.html](index/BehaviorSubject.html) | 行为主题 |
| [ReplaySubject.html](index/ReplaySubject.html) | 重放主题 |
| [AsyncSubject.html](index/AsyncSubject.html) | 异步主题 |

### 创建函数

| 文件 | 说明 |
|------|------|
| [of.html](index/of.html) | 固定值序列 |
| [from.html](index/from.html) | 从数组/Promise 等创建 |
| [fromEvent.html](index/fromEvent.html) | 从 DOM 事件创建 |
| [fromEventPattern.html](index/fromEventPattern.html) | 从自定义事件模式创建 |
| [interval.html](index/interval.html) | 定时递增序列 |
| [timer.html](index/timer.html) | 延迟/定时序列 |
| [range.html](index/range.html) | 数字范围 |
| [defer.html](index/defer.html) | 延迟创建 |
| [generate.html](index/generate.html) | 条件生成 |
| [iif.html](index/iif.html) | 条件选择 |
| [using.html](index/using.html) | 资源管理 |
| [bindCallback.html](index/bindCallback.html) | 回调转 Observable |
| [bindNodeCallback.html](index/bindNodeCallback.html) | Node 回调转 Observable |

### 组合函数

| 文件 | 说明 |
|------|------|
| [combineLatest.html](index/combineLatest.html) | 组合最新值 |
| [concat.html](index/concat.html) | 顺序连接 |
| [merge.html](index/merge.html) | 合并 |
| [forkJoin.html](index/forkJoin.html) | 等待全部完成 |
| [race.html](index/race.html) | 竞速 |
| [zip.html](index/zip.html) | 拉链组合 |
| [onErrorResumeNext.html](index/onErrorResumeNext.html) | 错误时继续下一个 |
| [pairs.html](index/pairs.html) | 对象键值对 |
| [partition.html](index/partition.html) | 分区 |

### 常量与工具

| 文件 | 说明 |
|------|------|
| [EMPTY.html](index/EMPTY.html) | 空 Observable |
| [NEVER.html](index/NEVER.html) | 永不完成的 Observable |
| [throwError.html](index/throwError.html) | 抛出错误 |
| [noop.html](index/noop.html) | 空函数 |
| [identity.html](index/identity.html) | 恒等函数 |
| [pipe.html](index/pipe.html) | 管道组合 |
| [scheduled.html](index/scheduled.html) | 调度创建 |
| [isObservable.html](index/isObservable.html) | 类型判断 |
| [config.html](index/config.html) | 全局配置 |

### 核心类型

| 文件 | 说明 |
|------|------|
| [Observable.html](index/Observable.html) | Observable 类 |
| [observable.html](index/observable.html) | observable 装饰器 |
| [Observer.html](index/Observer.html) | 观察者 |
| [Subscriber.html](index/Subscriber.html) | 订阅者 |
| [Subscription.html](index/Subscription.html) | 订阅对象 |
| [Notification.html](index/Notification.html) | 通知 |
| [ConnectableObservable.html](index/ConnectableObservable.html) | 可连接 Observable |
| [GroupedObservable.html](index/GroupedObservable.html) | 分组 Observable |

### 接口与类型别名

| 文件 | 说明 |
|------|------|
| [Operator.html](index/Operator.html) | Operator 接口 |
| [OperatorFunction.html](index/OperatorFunction.html) | 运算符函数类型 |
| [MonoTypeOperatorFunction.html](index/MonoTypeOperatorFunction.html) | 单类型运算符 |
| [PartialObserver.html](index/PartialObserver.html) | 部分观察者 |
| [NextObserver.html](index/NextObserver.html) | next 观察者 |
| [ErrorObserver.html](index/ErrorObserver.html) | error 观察者 |
| [CompletionObserver.html](index/CompletionObserver.html) | complete 观察者 |
| [Subscribable.html](index/Subscribable.html) | 可订阅接口 |
| [SubscribableOrPromise.html](index/SubscribableOrPromise.html) | 可订阅或 Promise |
| [Unsubscribable.html](index/Unsubscribable.html) | 可取消订阅 |
| [ObservableInput.html](index/ObservableInput.html) | Observable 输入类型 |
| [ObservedValueOf.html](index/ObservedValueOf.html) | 推断值类型 |
| [ObservedValuesFromArray.html](index/ObservedValuesFromArray.html) | 数组推断类型 |
| [InteropObservable.html](index/InteropObservable.html) | 互操作 Observable |
| [FactoryOrValue.html](index/FactoryOrValue.html) | 工厂或值 |
| [UnaryFunction.html](index/UnaryFunction.html) | 一元函数 |
| [TeardownLogic.html](index/TeardownLogic.html) | 清理逻辑 |
| [SchedulerLike.html](index/SchedulerLike.html) | 调度器接口 |
| [SchedulerAction.html](index/SchedulerAction.html) | 调度动作 |
| [TimeInterval.html](index/TimeInterval.html) | 时间间隔 |
| [Timestamp.html](index/Timestamp.html) | 时间戳 |

### 错误类

| 文件 | 说明 |
|------|------|
| [ArgumentOutOfRangeError.html](index/ArgumentOutOfRangeError.html) | 参数越界 |
| [EmptyError.html](index/EmptyError.html) | 空序列错误 |
| [ObjectUnsubscribedError.html](index/ObjectUnsubscribedError.html) | 已取消订阅错误 |
| [TimeoutError.html](index/TimeoutError.html) | 超时错误 |
| [UnsubscriptionError.html](index/UnsubscriptionError.html) | 取消订阅错误 |

## 运算符（operators/）

共 **98** 个页面

### 缓冲与采样

[audit](operators/audit.html) · [auditTime](operators/auditTime.html) · [buffer](operators/buffer.html) · [bufferCount](operators/bufferCount.html) · [bufferTime](operators/bufferTime.html) · [bufferToggle](operators/bufferToggle.html) · [bufferWhen](operators/bufferWhen.html) · [sample](operators/sample.html) · [sampleTime](operators/sampleTime.html) · [throttle](operators/throttle.html) · [throttleTime](operators/throttleTime.html)

### 转换与展平

[map](operators/map.html) · [mapTo](operators/mapTo.html) · [flatMap](operators/flatMap.html) · [mergeMap](operators/mergeMap.html) · [mergeMapTo](operators/mergeMapTo.html) · [mergeAll](operators/mergeAll.html) · [mergeScan](operators/mergeScan.html) · [concatMap](operators/concatMap.html) · [concatMapTo](operators/concatMapTo.html) · [concatAll](operators/concatAll.html) · [switchMap](operators/switchMap.html) · [switchMapTo](operators/switchMapTo.html) · [switchAll](operators/switchAll.html) · [exhaustMap](operators/exhaustMap.html) · [exhaust](operators/exhaust.html) · [expand](operators/expand.html) · [scan](operators/scan.html) · [reduce](operators/reduce.html) · [CombineAll](operators/CombineAll.html)

### 过滤与条件

[filter](operators/filter.html) · [take](operators/take.html) · [takeLast](operators/takeLast.html) · [takeUntil](operators/takeUntil.html) · [takeWhile](operators/takeWhile.html) · [skip](operators/skip.html) · [skipLast](operators/skipLast.html) · [skipUntil](operators/skipUntil.html) · [skipWhile](operators/skipWhile.html) · [first](operators/first.html) · [last](operators/last.html) · [single](operators/single.html) · [elementAt](operators/elementAt.html) · [find](operators/find.html) · [findIndex](operators/findIndex.html) · [every](operators/every.html) · [isEmpty](operators/isEmpty.html) · [distinct](operators/distinct.html) · [distinctUntilChanged](operators/distinctUntilChanged.html) · [distinctUntilKeyChanged](operators/distinctUntilKeyChanged.html) · [ignoreElements](operators/ignoreElements.html) · [throwIfEmpty](operators/throwIfEmpty.html) · [defaultIfEmpty](operators/defaultIfEmpty.html)

### 时间相关

[debounce](operators/debounce.html) · [debounceTime](operators/debounceTime.html) · [delay](operators/delay.html) · [delayWhen](operators/delayWhen.html) · [timeout](operators/timeout.html) · [timeoutWith](operators/timeoutWith.html) · [timeInterval](operators/timeInterval.html) · [timestamp](operators/timestamp.html)

### 组合与多播

[multicast](operators/multicast.html) · [publish](operators/publish.html) · [publishBehavior](operators/publishBehavior.html) · [publishLast](operators/publishLast.html) · [publishReplay](operators/publishReplay.html) · [share](operators/share.html) · [shareReplay](operators/shareReplay.html) · [refCount](operators/refCount.html) · [groupBy](operators/groupBy.html) · [pairwise](operators/pairwise.html) · [withLatestFrom](operators/withLatestFrom.html) · [zipAll](operators/zipAll.html) · [startWith](operators/startWith.html) · [endWith](operators/endWith.html)

### 窗口

[window](operators/window.html) · [windowCount](operators/windowCount.html) · [windowTime](operators/windowTime.html) · [windowToggle](operators/windowToggle.html) · [windowWhen](operators/windowWhen.html)

### 错误处理与工具

[catchError](operators/catchError.html) · [retry](operators/retry.html) · [retryWhen](operators/retryWhen.html) · [repeat](operators/repeat.html) · [repeatWhen](operators/repeatWhen.html) · [finalize](operators/finalize.html) · [onErrorResumeNext](operators/onErrorResumeNext.html) · [tap](operators/tap.html) · [pluck](operators/pluck.html) · [count](operators/count.html) · [max](operators/max.html) · [min](operators/min.html) · [toArray](operators/toArray.html) · [materialize](operators/materialize.html) · [dematerialize](operators/dematerialize.html) · [sequenceEqual](operators/sequenceEqual.html)

### 调度

[observeOn](operators/observeOn.html) · [subscribeOn](operators/subscribeOn.html)

## Ajax 模块（ajax/）

| 文件 | 说明 |
|------|------|
| [ajax.html](ajax/ajax.html) | ajax 请求运算符 |
| [AjaxError.html](ajax/AjaxError.html) | Ajax 错误 |
| [AjaxRequest.html](ajax/AjaxRequest.html) | 请求配置 |
| [AjaxResponse.html](ajax/AjaxResponse.html) | 响应对象 |
| [AjaxTimeoutError.html](ajax/AjaxTimeoutError.html) | 超时错误 |

## Fetch 模块（fetch/）

| 文件 | 说明 |
|------|------|
| [fromFetch.html](fetch/fromFetch.html) | 基于 Fetch API 的请求 |

## WebSocket 模块（webSocket/）

| 文件 | 说明 |
|------|------|
| [webSocket.html](webSocket/webSocket.html) | webSocket 工厂函数 |
| [WebSocketSubject.html](webSocket/WebSocketSubject.html) | WebSocketSubject 类 |
| [WebSocketSubjectConfig.html](webSocket/WebSocketSubjectConfig.html) | 配置接口 |

## Testing 模块（testing/）

| 文件 | 说明 |
|------|------|
| [TestScheduler.html](testing/TestScheduler.html) | 大理石测试调度器 |

## 文件命名说明

- HTML 文档统一使用**英文文件名**，与 RxJS API 名称对应。
- `overview/` 总览页使用 `-overview` 后缀区分，如 `observable-overview.html`。
- `docs/` 中的 [介绍.md](docs/介绍.md) 与 [安装.md](docs/安装.md) 保留中文文件名。

## 已跳过的已弃用内容

| 类别 | 已弃用项 | 替代方案 |
|------|----------|----------|
| index | `empty` | [EMPTY.html](index/EMPTY.html) |
| index | `never` | [NEVER.html](index/NEVER.html) |
| operators | `combineLatest` | [combineLatest.html](index/combineLatest.html) |
| operators | `concat` | [concatAll.html](operators/concatAll.html) |
| operators | `merge` | [mergeAll.html](operators/mergeAll.html) |
| operators | `partition` | [partition.html](index/partition.html) |
| operators | `race` | [race.html](index/race.html) |
| operators | `zip` | [zipAll.html](operators/zipAll.html) |

## 统计

| 分类 | 文件数 |
|------|--------|
| 总览教程 | 8 |
| 说明文档 | 2 |
| API 索引 | 73 |
| 运算符 | 98 |
| Ajax | 5 |
| Fetch | 1 |
| WebSocket | 3 |
| Testing | 1 |
| **合计** | **191** |

## 参考链接

- [w3cschool RxJS 中文文档](https://www.w3cschool.cn/rxjs/)
- [RxJS 官方文档](https://rxjs.dev/)
