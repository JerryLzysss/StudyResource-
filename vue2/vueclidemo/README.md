# test

### vue.config.js
```
使用vue inspect > output.js 可以查看到vue脚手架的默认配置
使用vue.config.js可以对脚手架进行个性化定制
```
### ref属性
```
1.被用来给元素或子组件注册引用信息
2.应用在HTML标签获取的是真实DOM元素，应用在组件标签是组件实例对象(vc)
3.使用方式
表示:<h1 ref="xxx">或者<school ref="xxx">
获取:this.$refs.xxx
```
### prop属性
```
功能:让组件接收外部传过来的数据
（1）传递数据:<xxx name="xxx">
(2)接收数据:第一种方式:props:['name']
            第二种方式:props:{NAME:String}
        第三种方式:props:{
            name:{
                type:String//类型
                required:true,//必要性
                default:'1'//默认值
            }
        }
        备注:props是只读的，修改需要复制到data后进行修改。
```
### mixin(混合)
```
功能:将多个组件共用的配置提取成一个混入对象
第一步定义混合:{
    data(){

    }
    methods:{

    }
}
第二步应用混合:
(1)全局混入:Vue.mixin(xxx)
(2)局部混入:mixins:['xxx']
```
### 插件
```
功能:增强Vue
本质:包含install方法的一个对象
install的第一个参数是Vue,第二个参数是插件使用的数据
定义插件:
对象.install=function(Vue,options){
    1.添加全局过滤器
    Vue.filter(...)
    2.添加全局指令
    Vue.directive(...)
    3.配置全局混入
    Vue.mixin(...)
    4.添加实例方法
    Vue.prototype.$method=function(){...}
    Vue.prototype.$myproperty=xxxx
}
使用插件:Vue.use()
```
### scoped
```
作用:让样式在局部生效，防止冲突。
写法:<style lang="css/less" scoped>
使用less的时候需要安装less-loader
注意:在外部引入包含在scoped的样式需要使用v:deep或者/deep/才能生效
```
# 组件的自定义事件
```
1.组件间通信的方式:子=>父
2.绑定自定义事件
第一种方式:<xxx @test="test"/>或者<xxx v-on:test="test">
其中@test表示自定义事件
第二种方式是<xxx ref="demo"/>
mounted()
{
    this.$refs.xxx.$on('test',this.test)
}
3.触发自定义事件:this.$emit('test',传回的数据)
4.解绑自定义事件:this.$off('test')
5.组件可以使用原生DOM但是需要native修饰
例如@click.native
6.通过this.$refs.xxx.$on('test',回调)绑定的时候，回调需要配置在methods,或者使用箭头，否则指向会出错。
```

### 全局事件总线
1.一种组件间的通信方式，适用于任意组件通信
2.安装全局事件总线
new Vue({
    beforeCreate()
    {
        Vue.prototype.$bus=this
    }
})
3.使用事件总线:
1.接受数据:A组件想接受事件，则在A时间中给$bus绑定自定义事件，回调留在A组件自身
methods()
{
    demo(data)
    {
        ....
    }
}
mounted()
{
    this.$bus.$on('xxxx',this.demo)
}
4.最好在beforeDestory钩子使用$off去解绑


## Project setup
```
npm install
```

### Compiles and hot-reloads for development
```
npm run serve
```

### Compiles and minifies for production
```
npm run build
```

### Lints and fixes files
```
npm run lint
```

### Customize configuration
See [Configuration Reference](https://cli.vuejs.org/config/).

