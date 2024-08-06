[TOC]
# Vue2
Vue 是一款用于构建用户界面的 JavaScript 框架。它基于标准 HTML、CSS 和 JavaScript 构建，并提供了一套声明式的、组件化的编程模型，可以高效地开发用户界面。无论是简单还是复杂的界面，Vue 都可以胜任。
## Vue 目录
### Vue 模板
### Vue 基本使用
### Vue 底层
   * 模型(MVVM)
   * 双向数据绑定原理(defineProperty)
   * 数据代理
   * 数组对象不支持响应式(Vue.set)
   * 数据劫持
   * 生命周期(图使用mermaid插件可以查看)
   ```mermaid
     
      flowchart TD;
      A["new Vue()"]-->B["初始化事件与生命周期循环"];
      B-->C("BeforeCreate")
      B-->D["初始化注入与活动"]
      D-->E("created")
      D-->F{"是否有el数据"};
      F-->G{"是否有template数据"}
      G-->YES-->H("编译模板到render函数")
      G-->NO-->I("编译el的外部HTML作为模板")
      H-->J(beforeMount)
      I-->J
      J-->K(通过vm.$el替换el)
      K-->L(mounted)
      L-->M(数据发生改变)
      M-->M1(beforeUpdated)-->N(虚拟DOM重新渲染)
      N-->M2(updated)-->L
      L-->O(vm.$destory事件触发)
      O-->P(beforeDestory)-->Q(清除所有监听器，子组件与事件监听)-->R(destroyed)
     
   ```
   ```
      
       beforeCreated:在实例初始化之后,进行数据侦听和事件/侦听器的配置之前同步调用.
       created:在实例创建完成后被立即同步调用。在这一步中，实例已完成对选项的处理，
       意味着以下内容已被配置完毕：数据侦听、计算属性、方法、事件/侦听器的回调函数。
       然而，挂载阶段还没开始，且 $el property 目前尚不可用。"
       beforeMount:在挂载开始之前被调用：相关的 render 函数首次被调用。该钩子在服务器端渲染期间不被调用。
       Mounted:实例被挂载后调用，这时 el 被新创建的 vm.$el 替换了。如果根实例挂载到了一个文档内的元素上，当 mounted 被调用时 vm.$el 也在文档内。
       注意 mounted 不会保证所有的子组件也都被挂载完成。如果你希望等到整个视图都渲染完毕再执行某些操作，可以在 mounted 内部使用 vm.$nextTick：
       beforeUpdate:在数据发生改变后，DOM 被更新之前被调用。这里适合在现有 DOM 将要被更新之前访问它，比如移除手动添加的事件监听器。
       updated:在数据更改导致的虚拟 DOM 重新渲染和更新完毕之后被调用。
       当这个钩子被调用时，组件 DOM 已经更新，所以你现在可以执行依赖于 DOM 的操作。然而在大多数情况下，你应该避免在此期间更改状态。如果要相应状态改变，通常最好使用计算属性或 watcher 取而代之。
       注意，updated 不会保证所有的子组件也都被重新渲染完毕。如果你希望等到整个视图都渲染完毕，可以在 updated 里使用 vm.$nextTick：
       actived:被 keep-alive 缓存的组件激活时调用。
       deactived:被 keep-alive 缓存的组件失活时调用。
       beforedestory:实例销毁之前调用。在这一步，实例仍然完全可用。
       destroyed:实例销毁后调用。该钩子被调用后，对应 Vue 实例的所有指令都被解绑，所有的事件监听器被移除，所有的子实例也都被销毁。
       errorCaptured:在捕获一个来自后代组件的错误时被调用。此钩子会收到三个参数：错误对象、发生错误的组件实例以及一个包含错误来源信息的字符串。此钩子可以返回 false 以阻止该错误继续向上传播。
   ```
   
   * 组件与实例原型链关系
   * 订阅者与发布者模式(pubsub)/全局订阅
### Vue 原型方法
   * [el名].$mount('[根属性]') // 实例绑定
   * Vue.set // 将对象添加新属性，并确保新对象具有响应式.
   * Vue.extend // 拓展组件
   * Vue.compoent('组件名',组件) // 使用组件
   * Vue.nextTick // 在下一次DOM更新结束后执行指定的回调
   * Vue.mixin // 使用混合
   * Vue.prototype.$methods/var //绑定方法或者变量
   * Vue.use // 全局引入插件
   * Vue.version //获取Vue安装版本号
   * Vue.observable //让一个对象可以响应.
   * Vue.compile //将一个模板字符串编译为render函数
   * Vue.delete // 删除对象的property
   * vue.filter //注册全局过滤器
   * render(VNode) //提供模板，第一个参数作为createElement的方法参数用来创建node，如果是函数组件，渲染函数还会接收一个额外的context提供上下文信息.
   * renderError(Vnode,error) //当render遭遇错误的时候，提供另一种渲染输出,其错误将会作为第二个参数传递到renderError.
### Vue 实例方法
   * vm.$data(观察的数据对象)
   * vm.$props(接收到的props对象)
   * vm.$el(readonly)(当前的根DOM元素)
   * vm.$options(readonly)(当前vue实例的初始化选项)
   * vm.$parent(readonly)(如果当前有父实例就指出)
   * vm.$root(readonly)(当前vue的根实例)
   * vm.$children(readonly)(当前实例的直接子组件，需要注意$children并不保证顺序，也不是响应式的.)
   * vm.$slots(readonly)(用来访问被插槽分发的内容)
   * vm.$scopedSlots(用来访问作用域插槽，包括默认slot在内的每一个插槽都包含一个返回对应VNODE的函数)
   * vm.$refs(获取注册在ref的所有DOM元素和组件实例)
   * vm.$isServer(当前是否运行在服务器)
   * vm.$attrs(包含父作用域中不作为props被识别的属性绑定)
   * vm.$listeners(包含父作用域中不作为props被识别的监听器)
   * vm.$watch(等同于watch方法，可以设置immediate,deep等属性)
   * vm.$set(等同于Set方法)
   * vm.$delete(等同于delete方法)
   * vm.$on(监听当前实例的自定义事件，可以由$emit触发，回调函数接收所有传入事件触发函数的额外参数)
   * vm.$once(只监听一次的监听事件)
   * vm.$off(移出自定义事件监听器,没有提供参数移出所有事件，提供事件移出所有该事件的监听器，提供事件与回调，则移出这个回调的监听器)
   * vm.$emit(触发当前实例事件，附加参数都会传给监听器回调.)
   * vm.$mount(手动挂载实例)
   * vm.$forceUpdate(强制Vue重新渲染)
   * vm.$nextTick(将回调延迟到下次 DOM 更新循环之后执行,与全局方法一致，不同的是回调的this自动绑定到调用实例)
   * vm.$destroy(完全销毁实例，清理并解绑)
### Vue 内部函数
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
   * Vue name(允许模板调用自身，并且便于提供有名字的警告信息)
   * Vue delimters(改变纯本文插入分隔符)
   * Vue functional(使组件无状态和无实例)
   * Vue model(允许使用v-model时定制prop和event)
   * Vue inheritAttrs(默认情况下父作用域不被认作props的属性绑定，通过设置false后去掉该默认行为,通过$attrs可以让这些属性生效,并且通过v-bind绑定到非根元素上.)
   * Vue comment(保留且渲染模板中的HTML注释，默认是舍弃) 
### Vue 属性
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
   * transition/transition-group(动画过渡与过度组)
   * keep-alive(缓存不活动的组件)

### Vue 全局配置
   * vue.config.silent=true (取消所有的日志与警告)
   * vue.devtools=true(允许devtools检查代码，开发版本默认为true,生产版本默认为false)
   * vue.errorHandler=function(err,vm,info)(处理未捕获错误的处理函数，可以获取错误信息和vue实例)
   * vue.warningHandler=function(msg,vm,trace(trace是组件的继承关系))处理警告自定义函数
   * vue.config.ignoredElements=['xxx-component','yyy-component'] (忽略Vue之外的自定义元素)
   * vue.config.keyCodes={key:value}(重新设置v-on对应的keyCode)
   * vue.config.performance=true (允许启用浏览器开发工具中的性能追踪)
   * vue.config.procutionTip=false(阻止vue启动的时候生成生产提示.)
### Vue 常用包
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
