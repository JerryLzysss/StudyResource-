<template>
    <div id="app">
        <!-- 动态路由 -->
      <input type="text" placeholder="输入参数" v-model="params">
      <button @click="jumps">点击跳转</button>
    </div>
  </template>
<script>
export default{ 
    name:'ActiveRouter',
    data(){
        return{
        params:'',
        }
    },
    methods:{
        jumps()
        {
            this.$router.push('about/'+this.params)
        }
    }
  }
</script> 