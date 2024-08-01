import Vue from 'vue'
import App from './App.vue'
import plugins from './plugins'
Vue.config.productionTip = false
Vue.use(plugins)
new Vue({
  render: h => h(App),

}).$mount('#app')
/* vue.js与vue.runtime.js的区别在于
1.vue.runtime.js是运行版的vue，只包含核心功能:没有模板解析器
2.因为vue.runtime.xxx.js没有模板解析器不能使用template配置项
需要使用render函数接收到的createElement函数去指定具体内容 */