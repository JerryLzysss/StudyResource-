[TOC]
# angularAPI

参考地址:https://www.angular.cn/api 与 https://www.runoob.com/angularjs/angularjs-reference.html

# 常用api

## 指令
指令|描述
---|---
ng-app|	定义应用程序的根元素。
ng-bind|	绑定 HTML 元素到应用程序数据
ng-bind-html|	绑定 HTML 元素的 innerHTML 到应用程序数据，并移除 HTML 字符串中危险字符
ng-bind-template|	规定要使用模板替换的文本内容
ng-blur	|规定 blur 事件的行为
ng-change|	规定在内容改变时要执行的表达式
ng-checked|	规定元素是否被选中
ng-class	|指定 HTML 元素使用的 CSS 类
ng-class-even|	类似 ng-class，但只在偶数行起作用
ng-class-odd|	类似 ng-class，但只在奇数行起作用
ng-click|	定义元素被点击时的行为
ng-cloak|	在应用正要加载时防止其闪烁
ng-controller|	定义应用的控制器对象
ng-copy|	规定拷贝事件的行为
ng-csp|	修改内容的安全策略
ng-cut|	规定剪切事件的行为
ng-dblclick|	规定双击事件的行为
ng-disabled|	规定一个元素是否被禁用
ng-focus|	规定聚焦事件的行为
ng-form|	指定 HTML 表单继承控制器表单
ng-hide|	隐藏或显示 HTML 元素
ng-href|	为 the <a> 元素指定链接
ng-if|	如果条件为 false 移除 HTML 元素
ng-include|	在应用中包含 HTML 文件
ng-init|	定义应用的初始化值
ng-jq|	定义应用必须使用到的库，如：jQuery
ng-keydown|	规定按下按键事件的行为
ng-keypress|	规定按下按键事件的行为
ng-keyup|	规定松开按键事件的行为
ng-list|	将文本转换为列表 (数组)
ng-model|	绑定 HTML 控制器的值到应用数据
ng-model-options|	规定如何更新模型
ng-mousedown|	规定按下鼠标按键时的行为
ng-mouseenter|	规定鼠标指针穿过元素时的行为
ng-mouseleave|	规定鼠标指针离开元素时的行为
ng-mousemove|	规定鼠标指针在指定的元素中移动时的行为
ng-mouseover|	规定鼠标指针位于元素上方时的行为
ng-mouseup|	规定当在元素上松开鼠标按钮时的行为
ng-non-bindable|	规定元素或子元素不能绑定数据
ng-open|	指定元素的 open 属性
ng-options|	在 <select> 列表中指定 <options>
ng-paste|	规定粘贴事件的行为
ng-pluralize|	根据本地化规则显示信息
ng-readonly|	指定元素的 readonly 属性
ng-repeat|	定义集合中每项数据的模板
ng-selected|	指定元素的 selected 属性
ng-show|	显示或隐藏 HTML 元素
ng-src|	指定 <img> 元素的 src 属性
ng-srcset|	指定 <img> 元素的 srcset 属性
ng-style|	指定元素的 style 属性
ng-submit|	规定 onsubmit 事件发生时执行的表达式
ng-switch|	规定显示或隐藏子元素的条件
ng-transclude|	规定填充的目标位置
ng-value|	规定 input 元素的值

## 事件
* ng-click 
* ng-dbl-click
* ng-mousedown
* ng-mouseenter
* ng-mouseleave
* ng-mousemove
* ng-keydown
* ng-keyup
* ng-keypress
* ng-change

## 方法
方法|描述
---|---
angular.lowercase()|	将字符串转换为小写
angular.uppercase()|	将字符串转换为大写
angular.copy()|	数组或对象深度拷贝
angular.forEach()|	对象或数组的迭代函数
angular.isArray()|	如果引用的是数组返回 true
angular.isDate()|	如果引用的是日期返回 true
angular.isDefined()|	如果引用的已定义返回 true
angular.isElement()|	如果引用的是 DOM 元素返回 true
angular.isFunction()|	如果引用的是函数返回 true
angular.isNumber()|	如果引用的是数字返回 true
angular.isObject()|	如果引用的是对象返回 true
angular.isString()|	如果引用的是字符串返回 true
angular.isUndefined()|	如果引用的未定义返回 true
angular.equals()|	如果两个对象相等返回 true
angular.fromJson()|	反序列化 JSON 字符串
angular.toJson()|	序列化 JSON 字符串
angular.bootstrap()|	手动启动 AngularJS
angular.element()|	包裹着一部分DOM element或者是HTML字符串，把它作为一个jQuery元
angular.module()|	创建，注册或检索 AngularJS 模块