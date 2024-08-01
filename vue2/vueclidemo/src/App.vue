<template>
  <div>
    <img src="./assets/logo.png" alt="logo">
    <!-- 1.通过父组件给子组件传递函数的props实现 -->
    <school :getschoolName="getschoolName" v-on:delivername2="getschoolName2" ref="sch"></school>
    
    <!-- :xxx是用表达式进行计算 不加则是字符串形式 -->
    <student Name='gg' :age="20+1"></student>
    <button @click="show">查看ref属性</button>
     <button @click="showName()">插件测试</button>
  </div>
</template>
<script>
import school from './components/School.vue'
import student from './components/Student.vue'
export default {
  name: 'app',
  components: {
    school,
    student
  },
  methods:{
    show()
    {
      console.log(this.$refs.sch)
    },
    getschoolName(name)
    {
      console.log(name)
    },
    getschoolName2(name)
    {
      console.log(name)
    }
    /* getschoolName2(name,...params)
    {
      获取更多形参
    } */
  },
  mounted()
  {
    console.log('第三种方法获得')
    this.$refs.sch.$on('delivername2',this.getschoolName)
    /* setTimeout(()==>{
      this.$refs.sch.$on('delivername2',this.getschoolName)
    },3000)这种方式可以使用定时器等方式更为灵活 */
  
  },
  
 
}
</script>
<style>

</style>