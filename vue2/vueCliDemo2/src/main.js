import Vue from 'vue'
import App from './App.vue'
import VueRouter from 'vue-router'
import router from '.././src/router/route.js'
import axios from 'axios'
Vue.use(VueRouter)
Vue.prototype.$axios = axios
Vue.config.productionTip = false
new Vue({
  render: h => h(App),
  /* 注意不要直接用大写的Router冲突 */
  router
}).$mount('#app')
