[TOC]
# VueCliDemo2
用途:展示与记录多个组件

# VueRouter
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
### 具名路由
当需要在一个页面渲染多个页面组件的时候，可以提供components参数,然后在主页面中引入name进行渲染，当router-view不具备名字时，默认为default

## 导航和定向
### 重定向
对某些访问的地址进行重定向，例如无权访问的时候重定向返回到相关的界面.
```
  routes: [
    { path: '/a', redirect: '/b' }
  ]
```
### 别名
匹配规则与URL分离,例如/a的别名是/b,那么访问/b的时候,url是/b,但是匹配规则为/a,也就是说访问/b等价于访问/a.
```
 routes: [
    { path: '/a', component: A, alias: '/b' }
  ]
```
## 组件传参
```
---PropsRouter.vue---
props:['id']
---route.js---
<!-- 同理，命名路由需要逐一配置 -->
routes:[{path:/user/:id},props:true,component:User]
```
### 布尔型
设置props为true后，对应的传参写入props即可，通过route.params能够获取对应的参数
props:true
### 对象型
通过设置对象的方式获得的参数为对应的值，例如id:3,那么当获取该参数的时候:id的参数不会影响最终结果。也就是说如何传入，传出的情况保持一致
props:{id:3}
### 函数型
可以通过创建函数返回props,
props:id=>({params:route.params.id})
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
### 其他导航方法
```router.replace(location,onComplete?onAborted)```这个方法与router.push相似，唯一的不同点是替换掉当前历史记录，而不是新增历史记录
```router.go(n)```这个方法是在history记录中向前或者后退n步,也就是浏览器中的回退与前进
```router.go(1)==history.forward()```
```router.go(-1)==history.back()```
```router.go(100)```如果超出history记录范围那么就不会生效
## URL模式
默认下为Hash模式也就是带有localhost:8080/#/xxxx.html
如果说需要更改模式可以设置为mode:'history'/mode:'hash'

## 导航守卫
正如其名，vue-router 提供的导航守卫主要用来通过跳转或取消的方式守卫导航。
记住参数或查询的改变并不会触发进入/离开的导航守卫。可以通过观察 $route 对象来应对这些变化，或使用 beforeRouteUpdate 的组件内守卫。
### 全局前置守卫
router.beforeEach(to,from,next)
可以获取到导航的参数内容
to:即将进入的路由
from:正要离开的路由
next:进入路由的钩子
其中next():正常进行跳转到to地址
next(false):中断跳转:返回from地址
next('/'):跳转到其他导航地址,
next(error):如果是一个error实例，那么导航会被终止并且返回给router.onError的回调.
### 全局解析守卫
router.beforeResolve(to,from,next)与前置守卫相似区别是在其他守卫与异步路由组件解析完后，在导航确认之前才会被调用.
### 全局后置守卫
与前置守卫相对应，不同点是该守卫不接受next函数也不改变导航(所以有啥用呢..乐)
### 路由独享守卫
```
routes:[{
  path:'foo',
  component:Foo,
  beforeEnter:(to,from,next)=>{
    console.log(to,from)
  }
}]
```
将守卫放置到路由当中，也就是类似于全局守卫，只不过把范围从全体退回到单独个体.
### 组件内守卫
与上述的对应，可以在组件的内部定义以下组件,那么如上所述，可以认定的是:
组件内的功能与上述全局守卫等相似.
其具有以下几个函数:
1.beforeRouteEnter(进入路由之前)
2.beforeRouteUpdate(同路由跳转例如/foo/1 => /foo/2)
3.beforeRouteLeave(离开路由之前)
### 守卫解析流程
1.导航被触发。
2.在失活的组件里调用beforeRouteLeave 守卫。
3.调用全局的 beforeEach 守卫。
4.在重用的组件里调用 beforeRouteUpdate 守卫 (2.2+)。
5.在路由配置里调用 beforeEnter。
解析异步路由组件。
6.在被激活的组件里调用 beforeRouteEnter。
7.调用全局的 beforeResolve 守卫 (2.5+)。
8.导航被确认。
9.调用全局的 afterEach 钩子。
10。触发 DOM 更新。
11.调用 beforeRouteEnter 守卫中传给 next 的回调函数，创建好的组件实例会作为回调函数的参数传入。
## 路由元信息
配置方式:routes:[{path:'xxx',meta:{xxx:true}}]
可以用来配置是否完成权限鉴定，例如:
meta:{requiresAuth:true}
```
router.beforeEach((to, from, next) => {
  if (to.matched.some(record => record.meta.requiresAuth)) {
   <!-- 通过守卫判断这个路由是否需要身份验证，如果验证通过那么通行，否则返回某个页面，如果不需要验证也直接通行 -->
    if (!auth.loggedIn()) {
      next({
        path: '/login',
        query: { redirect: to.fullPath }
      })
    } else {
      next()
    }
  } else {
    next() // 确保一定要调用 next()
  }
})
```
## 数据获取
导航完成之后获取：先完成导航，然后在接下来的组件生命周期钩子中获取数据。在数据获取期间显示“加载中”之类的指示。
导航完成之前获取：导航完成前，在路由进入的守卫中获取数据，在数据获取成功后执行导航。

## 滚动行为
```
可以通过返回x,y两个值来作为跳转后的位置
 scrollBehavior(to,from,savedPosition){
            return {x:0,y:0}
        },
```

## 导航故障
从3.1.0版本之后具有onComplete与onAbort参数进行回调函数提供，router.push/router.replace会返回一个promise，在里面可以执行onComplete与onAbort的调用,
在此之前可以通过isNavigationFailure进行故障判断.
```
router.push('/admin').catch(failure => {
  if (isNavigationFailure(failure, NavigationFailureType.redirected)) {
    // 向用户显示一个小通知
    showToast('Login in order to access the admin panel')
  }
})
```
### 故障类型
NavigationFailureType 可以帮助开发者来区分不同类型的导航故障。有四种不同的类型：
redirected：在导航守卫中调用了 next(newLocation) 重定向到了其他地方。
aborted：在导航守卫中调用了 next(false) 中断了本次导航。
cancelled：在当前导航还没有完成之前又有了一个新的导航。比如，在等待导航守卫的过程中又调用了 router.push。
duplicated：导航被阻止，因为我们已经在目标位置了。
### 故障to和from属性
```
通过to和from可以获得本次失败的导航的目标位置与当前位置.
router.push('/admin').catch(failure => {
  if (isNavigationFailure(failure, NavigationFailureType.redirected)) {
    failure.to.path // '/admin'
    failure.from.path // '/'
  }
})
```

# VueX
Vuex 是一个专为 Vue.js 应用程序开发的状态管理模式。它采用集中式存储管理应用的所有组件的状态，并以相应的规则保证状态以一种可预测的方式发生变化。Vuex 也集成到 Vue 的官方调试工具 devtools extension (opens new window)，提供了诸如零配置的 time-travel 调试、状态快照导入导出等高级调试功能。
## 安装
前置:promise
如果浏览器不支持Promise,那么需要安装相关的promise管理器，例如ES6-promise
```<script src="https://cdn.jsdelivr.net/npm/es6-promise@4/dist/es6-promise.auto.js"></script>```
或者是```npm install es6-promise --save```
1.直接下载/CDN引入
```<script src="https://unpkg.com/vuex@3.0.0"></script>```
2.npm引入
npm install vuex@3
3.git克隆
```
git clone https://github.com/vuejs/vuex.git node_modules/vuex
cd node_modules/vuex
npm install
npm run build
```
## 使用
1.建立store.js实现基本操作state,getters,mutations,actions
2.引入store
```
---main.js---
import store from store.js

```
## 五个过程与其概念
### State
Vuex 使用单一状态树——是的，用一个对象就包含了全部的应用层级状态。”而存在。这也意味着，每个应用将仅仅包含一个 store 实例。
#### 获得状态
由于已经将vuex绑定在了原型上，通过this.$store.state.xxx属性就能够访问到该相关属性。
#### mapState
当一个组件需要获取多个状态的时候，将这些状态都声明为计算属性会有些重复和冗余。为了解决这个问题，可以使用 mapState 函数,说白了就是通过这个函数将this.$store.state.xxx映射为平常使用的数据，然后直接通过模板语法使用.
```
---使用mapState---
computed:mapState({
  count:state=> state.count,
  count2: state => state.count2,
  count3: state => state.count3,
  show: function (state) {
    return state.count + ' - ' + state.count2 + ' - ' + state.count3
  }
})
---不使用mapState---
count = this.$store.state.count,
count2 = this.$store.state.count2,
count3 = this.$store.state.count3,
show(){
  return this.$store.state.count + '-' + this.$store.state.count2 + ' - ' + this.$store.state.count3
}
```
使用...mapState用作对象展开运算符,当需要放置其他方法的时候，如果还是以mapState的形式，无法引入到位置上，因此可以用...mapState作为存储的方式.

### Getter
类似于store的计算属性,当需要对state中的属性进行过滤等操作且不影响原数据的前提之下，可以使用Getter.
基本访问的方式和state保持一致，以及其拥有的mapper函数用法也和mapstate一致。

### Mutation
更改 Vuex 的 store 中的状态的唯一方法是提交 mutation。Vuex 中的 mutation 非常类似于事件：每个 mutation 都有一个字符串的事件类型和一个回调函数。这个回调函数就是我们实际进行状态更改的地方，并且它会接受 state 作为第一个参数：
而当需要在函数中使用这个方法的时候则是通过store.commit('xxxx')来实现.
#### payload
payload属于mutations的额外参数,可以传入对象或者是字符串之类，可以根据需要设置传入的类型.
另一种传递payload的方式是通过store.commit({type,payload})其他内容不变，也可以通过暴露常量的方式来处理mutation事件.
#### mutations同步
mutations必须是同步函数，同时，mutations也可以通过映射方式来进行简写，方式是同样的引入mapMutations,之后的操作就和getters与state一样了.
解决mutations的异步问题可以通过action实现.
### Action
Action提交的是mutation,需要commit使用，而不是直接变更状态，其操作可以包含异步操作.
#### Action分发
Action调用需要通过dispatch方法执行，即调用的时候需要使用this.$store.dispatch(operation,payload),其作用在于处理异步操作，因此该函数返回的结果是promise类型，也就可以通过promise的回调方法来逐步执行.同理，其也有所对应的映射方式mapAction.
### Module
由于使用单一状态树，应用的所有状态会集中到一个比较大的对象。当应用变得非常复杂时，store 对象就有可能变得相当臃肿。
为了解决以上问题，Vuex 允许我们将 store 分割成模块（module）。每个模块拥有自己的 state、mutation、action、getter。
#### 基本使用
```
const moduleA = {
  state: () => ({ ... }),
  mutations: { ... },
  actions: { ... },
  getters: { ... }
}

const moduleB = {
  state: () => ({ ... }),
  mutations: { ... },
  actions: { ... }
}

const store = createStore({
  modules: {
    a: moduleA,
    b: moduleB
  }
})

store.state.a // -> moduleA 的状态
store.state.b // -> moduleB 的状态
```
### 命名空间
默认情况下，模块内部的 action 和 mutation 仍然是注册在全局命名空间的——这样使得多个模块能够对同一个 action 或 mutation 作出响应。Getter 同样也默认注册在全局命名空间，但是目前这并非出于功能上的目的（仅仅是维持现状来避免非兼容性变更）。必须注意，不要在不同的、无命名空间的模块中定义两个相同的 getter 从而导致错误。
如果希望你的模块具有更高的封装度和复用性，你可以通过添加 namespaced: true 的方式使其成为带命名空间的模块。当模块被注册后，它的所有 getter、action 及 mutation 都会自动根据模块注册的路径调整命名
说白了就是在模块里面加入namespaced:true。
例如:
```
---使用命名空间---
const ModuleA={
    namespaced:true,
    state:()=>({count:1}),
    mutations:{
        increment(state){
          console.log(state.count)
        }
    }
}
访问的时候需要使用this.$store.state.commit('moduleA(模块名)/increment(函数)')
---不使用命名空间---
this.$store.state.commit('increment')
需要注意的是:如果出现重复函数那么就会执行多次，也就是出现错误,因此如果需要出现重复命名可以使用namespaced:true,否则就不能出现同名的情况.
```
### 方法获取
mutation与getters只能对内部进行操作,而在actions中可以获取到大量参数,诸如rootState等等，相比于mutations,actions的操作更为广泛.因此，当需要修改到其他模块的时候可以使用action(...arg)来获取到相应的参数.
### 命名空间的mapper绑定

通过对应到模块名的绑定，例如模块名为
```
computed: {
  ...mapState({
    a: state => state.module.a,
    b: state => state.module.b
  }),
  ...mapGetters([
    getter1:'module/getter1',
    getter2:'module/getter2',
  ])
},
methods: {
  ...mapActions([
    mapper1:'module/mapper1',
    mapper2:'module/mapper2'
  ])
  }
```
也可以通过为mapState/mapGetters...提供第一个参数作为映射的对应模块.
```
...mapState('module',{
  mapper1:'mapper1'
})
```
还有一种方法就是通过createNamespacedHelpers创建辅助函数
```
import { createNamespacedHelpers } from 'vuex'
const { mapState, mapActions } = createNamespacedHelpers('module')
...mapState({
  mapper1:'mapper1'
})
```
然后绑定完后，同样使用模板语法例如{{count}}来引入即可.
### 模块的方法函数
```
store.registerModule('module',{}) //注册模块
store.registerModule(['module1','module2'],{})//注册嵌套模块module1/module2
store.unregisterModule(moduleName)//卸载动态模块(不能卸载静态模块，也就是初始声明的).
store.hasModule(moduleName)//查询是否已经注册某个模块(此处的moduleName需要以数组形式传递，例如['module1','module2']=>'module1/module2')
```
## 其余要点
### 项目结构
应用层级的状态应该集中到单个 store 对象中。
提交 mutation 是更改状态的唯一方法，并且这个过程是同步的。
异步逻辑都应该封装到 action 里面。
### UseState钩子(Vue3)
可以通过调用 useStore 函数，来在 setup 钩子函数中访问 store。这与在组件中使用选项式 API 访问 this.$store 是等效的。
```
import {useStore} from 'vuex'
export default{
  setup(){
    const store=useStore()
    return{
      increment:()=>store.commit('increment')
    }
  }
}
```
### 插件
Vuex 的 store 接受 plugins 选项，这个选项暴露出每次 mutation 的钩子。Vuex 插件就是一个函数，它接收 store 作为唯一参数：
```
const myPlugin = (store) => {
  // 当 store 初始化后调用
  store.subscribe((mutation, state) => {
    // 每次 mutation 之后调用
    // mutation 的格式为 { type, payload }
  })
}
const store = createStore({
  // ...
  plugins: [myPlugin]
})
```
在插件中不允许直接修改状态——类似于组件，只能通过提交 mutation 来触发变化。
通过提交 mutation，插件可以用来同步数据源到 store。例如，同步 websocket 数据源到 store（下面是个大概例子，实际上 createWebSocketPlugin 方法可以有更多选项来完成复杂任务）：
```
export default function createWebSocketPlugin (socket) {
  return (store) => {
    socket.on('data', data => {
      store.commit('receiveData', data)
    })
    store.subscribe(mutation => {
      if (mutation.type === 'UPDATE_DATA') {
        socket.emit('update', mutation.payload)
      }
    })
  }
}
const plugin = createWebSocketPlugin(socket)

const store = createStore({
  state,
  mutations,
  plugins: [plugin]
})
```
Vuex 自带一个日志插件用于一般的调试:
```
import { createLogger } from 'vuex'
const store = createStore({
  plugins: [createLogger()]
})
const logger = createLogger({
  collapsed: false, // 自动展开记录的 mutation
  filter (mutation, stateBefore, stateAfter) {
    // 若 mutation 需要被记录，就让它返回 true 即可
    // 顺便，`mutation` 是个 { type, payload } 对象
    return mutation.type !== "aBlocklistedMutation"
  },
  actionFilter (action, state) {
    // 和 `filter` 一样，但是是针对 action 的
    // `action` 的格式是 `{ type, payload }`
    return action.type !== "aBlocklistedAction"
  },
  transformer (state) {
    // 在开始记录之前转换状态
    // 例如，只返回指定的子树
    return state.subTree
  },
  mutationTransformer (mutation) {
    // mutation 按照 { type, payload } 格式记录
    // 我们可以按任意方式格式化
    return mutation.type
  },
  actionTransformer (action) {
    // 和 `mutationTransformer` 一样，但是是针对 action 的
    return action.type
  },
  logActions: true, // 记录 action 日志
  logMutations: true, // 记录 mutation 日志
  logger: console, // 自定义 console 实现，默认为 `console`
})
```
### 严格模式
在状态发生变更后，不是由mutations引起的状态变更就会报错.
<strong>不要在发布环境下启用严格模式！</strong>严格模式会深度监测状态树来检测不合规的状态变更——请确保在发布环境下关闭严格模式，以避免性能损失。
```
const store = createStore({
  // ...
  strict: process.env.NODE_ENV!=='production'
})
```