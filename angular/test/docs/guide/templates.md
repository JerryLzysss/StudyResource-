# 模板 (Templates)

Angular 模板是 HTML 的增强版本，使用 Angular 特有的语法来绑定数据和控制 DOM 结构。

## 数据绑定

### 插值

```html
<p>{{ title }}</p>
```

### 属性绑定

```html
<img [src]="imageUrl" [alt]="description" />
```

### 事件绑定

```html
<button (click)="onClick()">点击</button>
```

### 双向绑定

```html
<input [(ngModel)]="name" />
```

## 控制流

Angular 17+ 引入了内置控制流语法：

```html
@if (isLoggedIn) {
  <p>欢迎回来！</p>
} @else {
  <p>请先登录</p>
}

@for (item of items; track item.id) {
  <li>{{ item.name }}</li>
}

@switch (status) {
  @case ('loading') { <span>加载中...</span> }
  @case ('done') { <span>完成</span> }
  @default { <span>未知</span> }
}
```

## 延迟加载 (@defer)

`@defer` 控制块允许声明式地将模板划分为可惰性加载的部分：

```html
@defer (on viewport) {
  <heavy-component />
} @placeholder {
  <p>加载中...</p>
}
```

## 管道 (Pipes)

管道用于在模板中转换数据：

```html
<p>{{ birthday | date:'yyyy-MM-dd' }}</p>
<p>{{ price | currency:'CNY' }}</p>
```

---

> 参考：[Angular 模板指南](https://angular.cn/guide/templates)
