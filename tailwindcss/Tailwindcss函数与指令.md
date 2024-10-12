[TOC]

# Tailwindcss 函数与指令

## @Tailwind

使用这个指令向 css 添加 tailwind 的 base,components,utilities 和 screens 样式

```
@tailwind base;
base:最基础的层级，界定了一些基础样式例如margin/padding/color/font-size
@tailwind components;
components:这个层级创建可复用的样式，例如按钮，卡片，默认情况下是空的.
@tailwind utilities;
utilities:作为工具层级，包括了tailwind的大部分功能，例如:layout,flex,grid,spacing,colors,border等等
@tailwind screen;
screens:作为响应式用来适配各个屏幕的大小
```

## @apply

使用@apply 将任何功能类内联到 CSS 中.

```
.btn{
  @apply bg-blue-500
}
```

- 注意:该 CSS 的原始位置不是根据@apply 之后的顺序，而是跟类的行为匹配

```
---tailwind---
.btn{
  @apply py-2 p-4;
}
---css---
.btn{
  padding:1rem;
  padding-top:0.5rem;
  padding-bottom:0.5rem;
}
此处p-4在css中位置要先于py-2。
```

- 如果需要顺序安排，那么要对这些语句通过多个@apply 来实现.

```
.btn{
  @apply py-2;
  @apply p-4;
}
```

- 允许与原生混合使用

```
.btn{
 transform:rotate(45deg)
  @apply bg-black;
}
```

- 任何@apply 内联规则中的!important 将被删除,如果需要设置那么在 apply 后面跟着!important.

```
---
.foo{
  color:blue !important
}
.bar{
  @apply foo;
}
---
.foo{
  color:blue;
}
.bar{
  color:blue;
}
--- 该形式会导致!important的形式消失

如果需要实现可以通过以下方式实现.
---
.btn{
  @apply font-bold py-2 px-4 rounded !important
}
---

```

- sass 下需要通过插值功能才能使用

```
.btn{
  @apply font-bold py-2 px-4 rounded #{!important}
}
```

## @layer

通过这个指令告诉 tailwind 这组自定义样式应该属于哪个层级

```
@layer utilities{
  .flexTest{
    @apply flex items-center justify-center;
  }
}
```

## @variants

通过这个指令可以声明自己的功能类用来生成 responsive,hover,focus,active.

```
@variants focus,hover{
  .rotate-0{
    transform:rotate(0deg)
  }
  .rotate-90{
    transform:rotate(90deg);
  }
}
---

  .rotate-0{
    transform:rotate(0deg)
  }
  .rotate-90{
    transform:rotate(90deg);
  }
.rotate-0:focus{
    transform:rotate(0deg)
  }
  .rotate-90:focus{
    transform:rotate(90deg);
  }
  .rotate-0:hover{
    transform:rotate(0deg)
  }
  .rotate-90:hover{
    transform:rotate(90deg);
  }
```

## @responsive

通过这个指令声明定义用来生成类.

```
@responsive{
  .bg{
    background:linear-gradient(blue,green);
  }
}
---

.bg{
    background:linear-gradient(blue,green);
}

@media(min-width:640px){
  .bg{
    background:linear-gradient(blue,green);
  }
}
@media(min-width:768px){
  .bg{
    background:linear-gradient(blue,green);
  }
}
@media(min-width:1024px){
  .bg{
    background:linear-gradient(blue,green);
  }
}
@media(min-width:1280px){
  .bg{
    background:linear-gradient(blue,green);
  }
}
```

## @screen

允许通过名称引用媒体查询，而不是在 css 复制.

```
@media screen(sm) = @media(min-width:640px)
```

## theme()

使用 theme()可以通过点符号获取 tailwind 配置值，可以用来代替@apply.

```
.btn-blue{
  background:theme('colors.blue.500')
}
```
