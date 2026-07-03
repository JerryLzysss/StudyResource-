# Angular 信号 (Signals)

Angular 信号是一个系统，能够细粒度地跟踪状态在整个应用中的使用方式和位置，使框架能够优化渲染更新。

## 什么是信号？

信号是围绕一个值的包装器，当该值发生变化时会通知感兴趣的消费者。信号可以包含任何值，从基本类型到复杂的数据结构。

通过调用其 getter 函数来读取信号的值，这使 Angular 能够跟踪信号的使用位置。

信号可以是**可写**的或**只读**的。

### 可写信号

可写信号提供直接更新其值的 API。通过调用 `signal` 函数并传入初始值来创建：

```typescript
import { signal } from '@angular/core';

const count = signal(0);

// 信号是 getter 函数 — 调用它们来读取值
console.log('The count is: ' + count());
```

要更改可写信号的值，可以直接 `.set()`：

```typescript
count.set(3);
```

或使用 `.update()` 从前一个值计算新值：

```typescript
count.update((value) => value + 1);
```

### 计算信号

计算信号是从其他信号派生其值的只读信号。使用 `computed` 函数定义：

```typescript
import { signal, computed } from '@angular/core';

const count = signal(0);
const doubleCount = computed(() => count() * 2);
```

`doubleCount` 信号依赖于 `count` 信号。每当 `count` 更新时，Angular 知道 `doubleCount` 也需要更新。

#### 计算信号的特性

- **惰性求值和记忆化** — 首次读取时才计算，之后返回缓存值
- **不可直接赋值** — 不能对计算信号调用 `.set()`
- **动态依赖** — 只有推导过程中实际读取的信号才会被跟踪

## 响应式上下文

响应式上下文是 Angular 监控信号读取以建立依赖关系的运行时状态。

Angular 在以下情况自动进入响应式上下文：

- 执行 effect、afterRenderEffect 回调
- 评估计算信号
- 渲染组件模板

## 在 OnPush 组件中读取信号

当你在 `OnPush` 组件的模板中读取信号时，Angular 会将该信号跟踪为该组件的依赖项。当信号值发生变化时，Angular 会自动标记该组件以进行更新。

## 与 RxJS 互操作

有关信号与 RxJS 之间互操作的详细信息，请参阅 [RxJS 与 Angular 信号互操作](https://angular.cn/guide/signals/rxjs-interop) 指南。

---

> 参考：[Angular 信号指南](https://angular.cn/guide/signals)
