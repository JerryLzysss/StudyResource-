[TOC]

# Tailwindcss 功能类

传统 CSS 下定制设计需要对应的 CSS.
通过功能类的方式进行定义有以下几个作用:

- 省去命名的麻烦，专注于功能上.
- 实现功能上的重用，减少反复添加
- 全局的定义下进行单独某个文件修改不会影响到全局的样式

其写法类似于内联样式，但是结合了类的优点:

- 设计约束，内联样式往往需要修改各种的配置，而通过功能类只需要填入对应的数值与类名
- 响应设计，允许使用媒体查询与响应
- hover,focus 等伪类的使用，内联样式无法使用

如果需要添加某些功能类可以通过@apply 的形式添加

```
<!-- Using utilities -->
<button class="py-2 px-4 font-semibold rounded-lg shadow-md text-white bg-green-500 hover:bg-green-700">Click me</button>
<button class="btn btn-green"></button>
<style>
  .btn{
    @apply py-2 px-4 font-semibold rounded-lg shadow-md;
  }
  .btn-green{
    @apply text-white bg-green-500 hover:bg-green-700;
  }
</style>
```
