[TOC]
# BootStrap 4 介绍
Bootstrap基于HTML、CSS、JavaScript 开发的简洁、直观、强悍的前端开发框架，使得 Web 开发更加快捷。Bootstrap提供了优雅的HTML和CSS规范，它即是由动态CSS语言Less写成。说白了就是能够用来优化html页面，动态调整页面结构的布局。
https://www.runoob.com/bootstrap4/bootstrap4-tutorial.html
https://v4.bootcss.com/docs/getting-started/introduction/
# BootStrap 4 目录
* 入门
* 容器
* 网格系统
    * 网格类
    * 偏移量 
* 文字排版
* 颜色
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
# BootStrap 4 总结