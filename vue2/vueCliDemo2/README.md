[TOC]
# VueCliDemo2
用途:展示与记录多个组件

## VueRouter
Vue Router 是 Vue.js (opens new window)官方的路由管理器。它和 Vue.js 的核心深度集成，让构建单页面应用变得易如反掌。包含的功能有：
* 嵌套的路由/视图表
* 模块化的、基于组件的路由配置
* 路由参数、查询、通配符
* 基于 Vue.js 过渡系统的视图过渡效果
* 细粒度的导航控制
* 带有自动激活的 CSS class 的链接
* HTML5 历史模式或 hash 模式，在 IE9 中自动降级
* 自定义的滚动条行为
参考:https://v3.router.vuejs.org/zh/
### VueRouter安装
1.直接安装/CDN
```
<script src="/path/to/vue.js"></script>
<script src="/path/to/vue-router.js"></script>
通过这种方式默认下载最新版本
注意:Vue2是需要使用VueRouter3+的版本，而Vue3则是VueRouter4+
因此使用Vue2的时候需要加载
<script src="https://unpkg.com/vue-router@3.0.0/dist/vue-router.js"></script>

```
2.通过node.js安装
```
npm install vue-router@3
npm install vue-router
```
3.脚手架安装
```
如果存在VUE CLI的项目，可以通过插件的形式进行生成```vue add router```
不过需要注意的是:这个方式会覆盖掉当前APP.vue
```
4.git安装
```
git clone https://github.com/vuejs/vue-router.git node_modules/vue-router
cd node_modules/vue-router
npm install
npm run build
```
### VueRouter 的导入与创建
1.如果使用script src进行导入则不需要引入模块
2.创建router文件夹并写入route.js配置
3.引入方式
```
--- main.js ---
import Vue from 'vue'
import VueRouter from 'vue-router'
import router from '路由位置'
Vue.use(VueRouter)
new Vue({
  render: h => h(App),
 
    Router:router,//注册router组件,可以简写为router
}).$mount('#app')

```
```
---route.js---
import Vue from 'vue'
import VueRouter from "vue-router"

import Home from '../components/home.vue'
import About from '../components/about.vue'

const router=new VueRouter({
    routes:[{
        name:'home,',
        path:'/home',
        component:Home,
    },{
        name:'about',
        path:'/about',
        component:About,
    }]
})
export default router
```

4.在App.vue或是其他组件中使用
```<router-view></router-view>```
## 路由
### 动态路由
当需要将某些参数与数据进行对应的时候可以通过params的方式进行传递
使用实例:ActiveRouter.vue + about.vue
```
<!-- 此处表示的:id即是动态路径参数，可以通过其他形式进行传递 -->
{path:'/user/:id',component:xxx}
获取该:id的时候则在传递的vue文件里面使用{{$route.params.id}}进行获取
```
除此之外,还有其他方法例如$route.params/$route.query/$route.hash等等可以使用.
### 路由监听
在路由中可以使用watch方法来获取当前路由变化的情况
```
---跳转页.vue---
watch:{
    $route(from,to,next)
    {
        <!-- 对路由变化做出响应 -->
    }
}
```
也可以使用beforeRouteUpdate
### 路由通配符
常规参数只会匹配被 / 分隔的 URL 片段中的字符。如果想匹配任意路径，我们可以使用通配符 (*)：
```
<!-- 会匹配所有路径 -->
{path:'*'}
<!-- 会匹配所有/user-开头的路径 -->
{path:'/user-*'}
如果需要获取该*内容可以通过this.$route.params.pathMatch来获取
```
### 路由匹配 & 优先级
高级匹配模式
vue-router 使用 [path-to-regexp](https://github.com/pillarjs/path-to-regexp/tree/v1.7.0) 作为路径匹配引擎，所以支持很多高级的匹配模式，例如：可选的动态路径参数、匹配零个或多个、一个或多个，甚至是自定义正则匹配。
学习高阶的路径匹配，还有这个例子 展示 vue-router 怎么使用这类匹配。
有时候，同一个路径可以匹配多个路由，此时，匹配的优先级就按照路由的定义顺序：路由定义得越早，优先级就越高。
### 路由嵌套
当路由表示多层级关系的时候需要使用到路由嵌套的方式

```
name:'parentRouter',
path:'/parent',
component:ParentRouter,
children:[{
    name:'childrenRouter',
    path:'/parent/children',
    component:ChildrenRouter
}]
// 当 /parent/children 匹配成功，
// children 会被渲染在 parent 的 <router-view> 中
如果需要渲染，可以提供一个空路由
{ path: '', component: ChildrenRouter }
```
### 命名路由
有时候，通过一个名称来标识一个路由显得更方便一些，特别是在链接一个路由，或者是执行一些跳转的时候。你可以在创建 Router 实例的时候，在 routes 配置中给某个路由设置名称。
```
---route.js---
const router = new VueRouter({
  routes: [
    {
      path: '/user/:userId',
      name: 'user',
      component: User
    }
  ]
})

---xxx.vue---
<router-link :to="{ name: 'user', params: { userId: 123 }}">User</router-link>
OR
router.push({ name: 'user', params: { userId: 123 } })
```
## 导航和定向

### 内部与外部导航
通常使用的情况下，路由跳转可以通过在html中使用```$router.push(location,onComplete?,onAbort?)```来实现.而如果要在内部使用这种方法则需要通过$router.push的方法来实现.
```
// 字符串
router.push('home')
// 对象
router.push({ path: 'home' })
// 命名的路由
router.push({ name: 'user', params: { userId: '123' }})
// 带查询参数，变成 /register?plan=private
router.push({ path: 'register', query: { plan: 'private' }})

注意：如果提供了 path，params 会被忽略，上述例子中的 query 并不属于这种情况。取而代之的是下面例子的做法，你需要提供路由的 name 或手写完整的带有参数的 path：

const userId = '123'
router.push({ name: 'user', params: { userId }}) // -> /user/123
router.push({ path: `/user/${userId}` }) // -> /user/123
// 这里的 params 不生效
router.push({ path: '/user', params: { userId }}) // -> /user

```
在 2.2.0+，可选的在 router.push 或 router.replace 中提供 onComplete 和 onAbort 回调作为第二个和第三个参数。这些回调将会在导航成功完成 (在所有的异步钩子被解析之后) 或终止 (导航到相同的路由、或在当前导航完成之前导航到另一个不同的路由) 的时候进行相应的调用。在 3.1.0+，可以省略第二个和第三个参数，此时如果支持 Promise，router.push 或 router.replace 将返回一个 Promise。
注意： 如果目的地和当前路由相同，只有参数发生了改变 (比如从一个用户资料到另一个 /users/1 -> /users/2)，你需要使用 beforeRouteUpdate 来响应这个变化 (比如抓取用户信息)。
### 其他方法
```router.replace(location,onComplete?onAborted)```这个方法与router.push相似，唯一的不同点是替换掉当前历史记录，而不是新增历史记录
```router.go(n)```这个方法是在history记录中向前或者后退n步,也就是浏览器中的回退与前进
```router.go(1)==history.forward()```
```router.go(-1)==history.back()```
```router.go(100)```如果超出history记录范围那么就不会生效