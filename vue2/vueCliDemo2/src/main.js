import Vue from 'vue'
import App from './App.vue'
import VueRouter from 'vue-router'
import router from '.././src/router/route.js'
Vue.use(VueRouter)
Vue.config.productionTip = false
new Vue({
  render: h => h(App),
  /* 注意不要用大写的Router冲突 */
  router
}).$mount('#app')
