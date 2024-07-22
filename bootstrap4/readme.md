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

# BootStrap4 总结