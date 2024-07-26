[TOC]
# BootStrap 4 介绍
Bootstrap基于HTML、CSS、JavaScript 开发的简洁、直观、强悍的前端开发框架，使得 Web 开发更加快捷。Bootstrap提供了优雅的HTML和CSS规范，它即是由动态CSS语言Less写成。说白了就是能够用来优化html页面，动态调整页面结构的布局。
https://www.runoob.com/bootstrap4/bootstrap4-tutorial.html
https://v4.bootcss.com/docs/getting-started/introduction/
# BootStrap 4 目录
* 入门
* 布局
    * 容器
    * 网格系统
        * 网格类
        * 偏移量 
    * 文字排版
    * 表格
    * 图像形状
    * 媒体对象
    * 巨幕
    * flex 伸缩布局
    * position 定位
* 组件
    * 颜色
    * 信息提示框
    * 超大屏
    * 徽章
    * 面包屑
    * 按钮
    * 按钮组
    * 卡片
    * 轮播图
    * 折叠
    * 下拉菜单
    * 表单
    * 输入组
    * 列表组
    * 模态框
    * 导航
    * 导航条
    * 分页
    * 弹出框
    * 进度条
    * 滚动监听
    * 旋转图标
    * 轻量弹框
    * 工具提示框
    * 边框
    * 关闭图标
* 样式
  * 清除浮动
  * display展示
  * float浮动
  * interactions 交互方式
  * overflow 溢出
  * screenreader 屏幕阅读器
  * shadow 阴影
  * size 尺寸
  * margin,padding 间隔
  * strectched link 拓展连接
  * text 文本
  * vertical-align 垂直对齐
  * visible 可见性
## BootStrap 4 容器
-|Extra small(<576px)|small(>=576px)|Medium(>=768px)|Large(>=992px)|Extra large(>=1200px)
---|---|---|---|---|---
.container|100%|540px|720px|960px|1140px
.container-sm|100%|540px|720px|960px|1140px
.container-md|100%|100%|720px|960px|1140px
.container-lg|100%|100%|100%|960px|1140px
.container-xl|100%|100%|100%|100%|1140px
.container-fluid|100%|100%|100%|100%|100%
## BootStrap 4 网格系统
类别 | 描述
--- | ---
.col- |针对所有设备
.col-sm- | 平板 - 屏幕宽度等于或大于 576px
.col-md- | 桌面显示器 - 屏幕宽度等于或大于 768px
.col-lg- |大桌面显示器 - 屏幕宽度等于或大于 992px
.col-xl- | 超大桌面显示器 - 屏幕宽度等于或大于 1200px
## BootStrap 4 文字排版

类名|描述	
---|---
.font-weight-bold|加粗文本	
.font-weight-normal|普通文本	
.font-weight-light|更细的文本	
.font-italic|斜体文本	
.lead|让段落更突出	
.small|指定更小文本 (为父元素的 85% )	
.text-left|	左对齐	
.text-center|居中	
.text-right|右对齐	
.text-justify|设定文本对齐,段落中超出屏幕部分文字自动换行	
.text-nowrap|段落中超出屏幕部分不换行	
.text-lowercase|设定文本小写	
.text-uppercase|设定文本大写	
.text-capitalize|设定单词首字母大写	
.initialism|显示在 ```<abbr>``` 元素中的文本以小号字体展示，且可以将小写字母转换为大写字母	
.list-unstyled|移除默认的列表样式，列表项中左对齐 (``` <ul>``` 和``` <ol>``` 中)。 这个类仅适用于直接子列表项 (如果需要移除嵌套的列表项，你需要在嵌套的列表中使用该样式)	
.list-inline|将所有列表项放置同一行	
.pre-scrollable|使``` <pre>``` 元素可滚动，代码块区域最大高度为340px,一旦超出这个高度,就会在Y轴出现滚动条
## BootStrap4 表格
类名|描述
--|--
.table-primary|蓝色: 指定这是一个重要的操作
.table-success|绿色: 指定这是一个允许执行的操作
.table-danger|红色: 指定这是可以危险的操作
.table-info|浅蓝色: 表示内容已变更
.table-warning|橘色: 表示需要注意的操作
.table-active|灰色: 用于鼠标悬停效果
.table-secondary|灰色: 表示内容不怎么重要
.table-light|浅灰色，可以是表格行的背景
.table-dark|深灰色，可以是表格行的背景

类名|	屏幕宽度
--|--
.table-responsive-sm|	< 576px
.table-responsive-md|	< 768px
.table-responsive-lg|	< 992px
.table-responsive-xl|	< 1200px
## BootStrap4 轮播图

### data选项
名字|类型|默认|描述
--|--|--|--
interval|number|5000|切换时间间隔
keyboard|boolean|true|是否对键盘事件进行响应
pause|string|hover|如果设置为hover,那么鼠标放上时可以暂停，设置为false,则不会触发
ride|string|false|在用户执行完一轮后轮播，如果为carousel则在载入时轮播
wrap|boolean|true|决定是否连续播放
touch|boolean|true|决定是否向前向后滑动
### methods方法
```
使用方法:$('#identifier').carousel({
    interval: 2000
})
.carousel('cycle')从左到右循环轮播项目。
.carousel('pause')停止轮播循环项目。	
.carousel(number)循环轮播到某个特定的帧（从 0 开始计数，与数组类似）。	
.carousel('prev')循环轮播到上一个项目。	
.carousel('next')循环轮播到下一个项目。
.carousel('dispose')摧毁元素
.carousel('nextWhenVisible') 当父元素不显示或者自身不显示时，不执行循环(早于Slide.bs.carousel)
.carousel('to') 循环特定的框架	(早于slide.bs.carousel)
```
### events事件
```
实例:
('#identifier').on('slide.bs.carousel', function () {
    // 执行一些动作...
})
slide.bs.carousel 调用Slide实例触发方法
slid.bs.carousel 当完成动画的时候
```

## BootStrap4 折叠框
### data选项
名字|类型|默认|描述
--|--|--|--
parent|selector,object,dom|false|如果设置了选项，当该节点开启时候其他的折叠会随着关闭
toggle|boolean|true|是否可以切换
### methods方法
```
实例:$('#myCollapsible').collapse({
  toggle: false
})
.collapse('toggle')|切换当前状态
.collapse('show')|显示折叠框
.collapse('hide')|关闭折叠框
.collapse('dispose')|销毁折叠框
```
### event事件
```
实例:$('#myCollapsible').on('hidden.bs.collapse', function () {
  // do something...
})
```
show.bs.carousel 调用show实例触发方法
shown.bs.carousel 当完成show动画的时候
hide.bs.carousel 调用hide实例触发方法
hidden.bs.carousel 当完成hide动画的时候

## BootStrap4 下拉框

### data选项
名字|类型|默认|描述
--|--|--|--
offset|number,string,function|0|下拉菜单的偏移量
flip|boolean|true|翻转
boundary|string,element|scrollParent|边界防止溢出，设置的属性值有viewport,window,scrollParent或者是HTML元素
reference|string,element|toggle|参考对应元素进行打开或关闭可以设置为toggle和parent，
display|string|dynamic|如果使用static则会关闭
popperConfig|null,object|null|修改popper属性

### methods方法

方法|描述
--|--
.dropdown('toggle')|切换下拉框
.dropdown('show')|显示下拉框
.dropdown('hide')|隐藏下拉框
.dropdown('update')|更新下拉框的位置
.dropdown('dispose')|销毁下拉框

### 事件
show.bs.dropdown 调用show实例触发方法
shown.bs.dropdown  当完成show动画的时候
hide.bs.dropdown  调用hide实例触发方法
hidden.bs.dropdown  当完成hide动画的时候

## BootStrap4 模态框(modal)
### data选项
名字|类型|默认|描述
--|--|--|--
backdrop|boolean/static|true|包含有背景，如果设置为static则不会在点击后关闭表单
keyboard|boolean|true|当点击esc时关闭表单
focus|boolean|true|集中焦点到modal上
show|boolean|true|初始化时显示modal
### methods方法
```
$('#myModal').modal({
  keyboard: false
})
toggle:切换状态
show:展示
hide:隐藏
handleupdate:更新
dispose:销毁
```
### events事件
```
$('#myModal').on('hidden.bs.modal', function (event) {
  // do something...
})
```
事件|描述
--|--
show.bs.modal|当show实例方法调用时
shown.bs.modal|当show动画执行完
hide.bs.modal|当hide实例方法调用
hidden.bs.modal|当hide动画执行完
hidePrevented.bs.modal|当使用esc键或者点击背景(设置为static属性)或者keyboard配置设置为false时

## BootStrap4 工具提示框
### data选项
名字|类型|默认|描述
--|--|--|--
animation|boolean|true|添加隐藏过渡
container|string,element,false|false|添加到一个指定元素，用来允许tooltip悬浮在靠近触发元素的文件流上。
delay|number,object|0|推迟隐藏或者显示的时间
html|boolean|false|允许在tooltip中使用html
placement|string,function|'top'|设置tooltip的位置，如果是auto会自动调整
selector|string,false|提供selector，tooltip会寄托到特定元素中
template|string|`'<div class="tooltip" role="tooltip"><div class="arrow"></div><div class="tooltip-inner"></div></div>'`|tooltip的模板，title对应.tooltip-inner,.arrow对应arrow,最外层必须有.tooltip和role="tooltip"
title|string,element,function|""|默认title不会显示
trigger|string|'hover focus'|如何触发tootip,拥有的为click,hover,focus,manual,可以通过.tooltip('show'),.tooltip('hide')以及.tooltip('toggle')方法进行触发
offset|number,string,function|0|与其元素的对应的偏移量，如果使用function那么第一个参数必须是offset的数值，并且返回时必须是同样的结构，操作元素dom是第二个参数
fallbackPlacement|string,array|flip|允许特定的popper使用这个反馈
customClass|string,function|""，添加类到tooltip当tooltip展现时
boundary|string,element|'scrollParent'|允许接收参数viewport,window,scrollParent,或者HTML元素(只允许JS的元素),用来控制边界
sanitize|boolean|true|不懂..
whiteList|object|default value|允许属性和标签的对象
sanitizeFn|null,function|null|不懂..
popperConfig|null,project|null|配置popper
### methods方法
```
使用方法:
$('#myModal').tooltip({
  show:false
})
$('#element').tooltip('show') 显示
$('#element').tooltip('hide')隐藏
$('#element').tooltip('toggle')切换
$('#element').tooltip('dispose')销毁
$('#element').tooltip('enable')开启
$('#element').tooltip('disable')禁用
$('#element').tooltip('toggleEnabled')切换
$('#element').tooltip('update')更新
```
### events事件
```
使用方法:
$('#myTooltip').on('hidden.bs.tooltip', function () {
  // do something...
})
show.bs.tooltip
shown.bs.tooltip
hide.bs.tooltip
hidden.bs.tooltip
inserted.bs.tooltip 当tooltip被插入到DOM元素之后触发
```
## BootStrap4 flex布局
在bootstrap的flex布局中可以引入大部分的display下布局以及引入对应的大小模块
### flex
```
.d-flex
.d-inline-flex
.d-sm-flex
.d-sm-inline-flex
.d-md-flex
.d-md-inline-flex
.d-lg-flex
.d-lg-inline-flex
.d-xl-flex
.d-xl-inline-flex
```
### column && row
```
.flex-row
.flex-row-reverse
.flex-column
.flex-column-reverse
.flex-sm-row
.flex-sm-row-reverse
.flex-sm-column
.flex-sm-column-reverse
.flex-md-row
.flex-md-row-reverse
.flex-md-column
.flex-md-column-reverse
.flex-lg-row
.flex-lg-row-reverse
.flex-lg-column
.flex-lg-column-reverse
.flex-xl-row
.flex-xl-row-reverse
.flex-xl-column
.flex-xl-column-reverse
```
### justify-content
```
.justify-content-start
.justify-content-end
.justify-content-center
.justify-content-between
.justify-content-around
.justify-content-sm-start
.justify-content-sm-end
.justify-content-sm-center
.justify-content-sm-between
.justify-content-sm-around
.justify-content-md-start
.justify-content-md-end
.justify-content-md-center
.justify-content-md-between
.justify-content-md-around
.justify-content-lg-start
.justify-content-lg-end
.justify-content-lg-center
.justify-content-lg-between
.justify-content-lg-around
.justify-content-xl-start
.justify-content-xl-end
.justify-content-xl-center
.justify-content-xl-between
.justify-content-xl-around
```
### align-item
```
.align-items-start
.align-items-end
.align-items-center
.align-items-baseline
.align-items-stretch
.align-items-sm-start
.align-items-sm-end
.align-items-sm-center
.align-items-sm-baseline
.align-items-sm-stretch
.align-items-md-start
.align-items-md-end
.align-items-md-center
.align-items-md-baseline
.align-items-md-stretch
.align-items-lg-start
.align-items-lg-end
.align-items-lg-center
.align-items-lg-baseline
.align-items-lg-stretch
.align-items-xl-start
.align-items-xl-end
.align-items-xl-center
.align-items-xl-baseline
.align-items-xl-stretch
```
### align-self
```
.align-self-start
.align-self-end
.align-self-center
.align-self-baseline
.align-self-stretch
.align-self-sm-start
.align-self-sm-end
.align-self-sm-center
.align-self-sm-baseline
.align-self-sm-stretch
.align-self-md-start
.align-self-md-end
.align-self-md-center
.align-self-md-baseline
.align-self-md-stretch
.align-self-lg-start
.align-self-lg-end
.align-self-lg-center
.align-self-lg-baseline
.align-self-lg-stretch
.align-self-xl-start
.align-self-xl-end
.align-self-xl-center
.align-self-xl-baseline
.align-self-xl-stretch
```
### fill
```
.flex-fill
.flex-sm-fill
.flex-md-fill
.flex-lg-fill
.flex-xl-fill
```
### grow && shrink
```
.flex-{grow|shrink}-0
.flex-{grow|shrink}-1
.flex-sm-{grow|shrink}-0
.flex-sm-{grow|shrink}-1
.flex-md-{grow|shrink}-0
.flex-md-{grow|shrink}-1
.flex-lg-{grow|shrink}-0
.flex-lg-{grow|shrink}-1
.flex-xl-{grow|shrink}-0
.flex-xl-{grow|shrink}-1
```
### wrap
```
.flex-nowrap
.flex-wrap
.flex-wrap-reverse
.flex-sm-nowrap
.flex-sm-wrap
.flex-sm-wrap-reverse
.flex-md-nowrap
.flex-md-wrap
.flex-md-wrap-reverse
.flex-lg-nowrap
.flex-lg-wrap
.flex-lg-wrap-reverse
.flex-xl-nowrap
.flex-xl-wrap
.flex-xl-wrap-reverse
```
### order
```
.order-0
.order-1
.order-2
.order-3
.order-4
.order-5
.order-6
.order-7
.order-8
.order-9
.order-10
.order-11
.order-12
.order-sm-0
.order-sm-1
.order-sm-2
.order-sm-3
.order-sm-4
.order-sm-5
.order-sm-6
.order-sm-7
.order-sm-8
.order-sm-9
.order-sm-10
.order-sm-11
.order-sm-12
.order-md-0
.order-md-1
.order-md-2
.order-md-3
.order-md-4
.order-md-5
.order-md-6
.order-md-7
.order-md-8
.order-md-9
.order-md-10
.order-md-11
.order-md-12
.order-lg-0
.order-lg-1
.order-lg-2
.order-lg-3
.order-lg-4
.order-lg-5
.order-lg-6
.order-lg-7
.order-lg-8
.order-lg-9
.order-lg-10
.order-lg-11
.order-lg-12
.order-xl-0
.order-xl-1
.order-xl-2
.order-xl-3
.order-xl-4
.order-xl-5
.order-xl-6
.order-xl-7
.order-xl-8
.order-xl-9
.order-xl-10
.order-xl-11
.order-xl-12
```
### align-content
```
.align-content-start
.align-content-end
.align-content-center
.align-content-between
.align-content-around
.align-content-stretch
.align-content-sm-start
.align-content-sm-end
.align-content-sm-center
.align-content-sm-between
.align-content-sm-around
.align-content-sm-stretch
.align-content-md-start
.align-content-md-end
.align-content-md-center
.align-content-md-between
.align-content-md-around
.align-content-md-stretch
.align-content-lg-start
.align-content-lg-end
.align-content-lg-center
.align-content-lg-between
.align-content-lg-around
.align-content-lg-stretch
.align-content-xl-start
.align-content-xl-end
.align-content-xl-center
.align-content-xl-between
.align-content-xl-around
.align-content-xl-stretch
```
## BootStrap4 float样式
```
.float-left
.float-right
.float-none
.float-sm-left
.float-sm-right
.float-sm-none
.float-md-left
.float-md-right
.float-md-none
.float-lg-left
.float-lg-right
.float-lg-none
.float-xl-left
.float-xl-right
.float-xl-none
```

# BootStrap4 总结
总的来说，boootstrap是一款基于scss之上的布局组件，也就是说通过bootstrap的布局功能可以完成大部分网页上的设计，而且
其中的类型样式齐全，源码可以修改，而且能对各种屏幕进行适应，在完成基础静态页面有着很大的用处，但是还有很多问题，框架的巨大难以避免，同时在数据的处理还是只能使用原生的方法，没有实现重要的修改。