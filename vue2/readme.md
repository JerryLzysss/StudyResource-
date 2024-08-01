[TOC]
# Vue2
Vue 是一款用于构建用户界面的 JavaScript 框架。它基于标准 HTML、CSS 和 JavaScript 构建，并提供了一套声明式的、组件化的编程模型，可以高效地开发用户界面。无论是简单还是复杂的界面，Vue 都可以胜任。
## Vue 目录
* Vue 模板
   * Vue 基本使用
* Vue 底层
   * 模型(MVVM)
   * 双向数据绑定原理(defineProperty)
   * 数据代理
   * 数组对象不支持响应式(Vue.set)
   * 数据劫持
   * 生命周期
   * 组件与实例原型链关系
   * 订阅者与发布者模式(pubsub)/全局订阅
* Vue 原型方法
   * [el名].$mount('[根属性]') // 实例绑定
   * Vue.set // 将对象添加新属性，并确保新对象具有响应式.
   * Vue.extend // 拓展组件
   * Vue.compoent('组件名',组件) // 使用组件
   * Vue.nextTick // 在下一次DOM更新结束后执行指定的回调
   * Vue.mixin // 使用混合
   * Vue.prototype.$methods/var //绑定方法或者变量
   * Vue.use // 全局引入插件
* Vue 方法
   * Vue Data(数据,可分为函数式与对象式)
   * Vue el(实例)
   * Vue methods(方法存储)
   * Vue Computed(计算属性)
   * Vue Watch(监视)  
      * deep:true(多层监视)
   * Vue directives(自定义函数,引入时就可以使用v-xxx)
      * directives中函数内部回调
         *  bind(element,binding)(指令所在模板绑定)     
         *  inserted(element,binding)(指令所在模板插入)   
         *  update(element,binding)(指令所在模板更新)
   * Vue components(组件引入)
   * Vue props(接收外部传来参数)
   * Vue mixins(混合)  
* Vue 属性
   * v-model + v-bind(数据绑定) 
      *  v-model.trim输入首尾空格过滤
      * v-model.lay失去焦点在收集数据
      * v-model.number输入字符串转为有效数字
   * @click/v-on:click(事件绑定)
      * v-on:click.prevent(事件修饰,阻止默认事件)
   * @keyup.ctrl(键盘事件) 
   * :class/:style(动态绑定类名/样式)
   * v-if(条件渲染，为否时不加载DOM)
   * v-show(条件渲染，为否时隐藏DOM)
   * v-for(循环)
      * :key设置关键词
      * js原生方法
         * filter (过滤器)
         * sort (排序)
   * v-text (向所在节点渲染文本内容,与插值语法的区别在于v-text会替换原文本的内容)
   * v-pre  (跳过其节点的编译过程)
   * v-once (在初次动态渲染后就视为静态资源)
   * v-html (向指定节点中渲染包含html结构的内容)
   * v-cloak (特殊属性，配合CSS可以让VUE接管容器后删除，避免出现网速慢引起的提示)
   * slot (插槽)
   * ref (获取DOM或者组件)       
* Vue 常用包
   * VueX(集中式状态管理)
   * VueRouter(单文件路由)
   
## Vue2 引入html
1.从官网下载vue.js并放入到对应的html当中后引入```<script type="text/javascript" src="./vue.js"></script>```
2.直接从CDN中引入
```
<script src="https://cdn.bootcdn.net/ajax/libs/vue/2.6.13/vue.js"></script>
```
## Vue2 脚手架
Vue脚手架是Vue提供的标准化开发工具
文档:https://cli.vuejs.org/zh/
通过脚手架进行搭建，可以简便构建Vue的过程，同时提供了package可以直接进行node组件的安装与使用

也可以使用vue ui进行导入
### Vue-Cli
1.安装脚手架
npm install -g @vue/cli 或者 yarn global add @vue/cli
2.创建项目
vue create <项目名>
3.按照提示进入之后启动输入npm run serve查看效果.
### Vite(Vue3)
1.安装vite
npm init vite@latest
2.选择框架-> vue
  选择语法->js/ts
3.按照提示进入启动输入.
