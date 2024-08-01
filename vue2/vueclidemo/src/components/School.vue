<template>
    <!-- 组件结构 -->
    <div class="demo">
        <h2>{{ schoolName }}</h2>
        <h2>{{ address }}</h2>

        <button @click="showName">提示名字</button>
        <button @click="test">测试</button>
        <button @click="deliverName1">第一种获得</button> 
         <button @click="deliverName2">第二种获得</button>
         <button @click="unbind">解绑</button>
         <button @click="destroy">销毁</button>
    </div>
</template>

<script>
import {hunhe} from '../mixin'
export default{
        name:'school',
        data()
        {
            return{
                schoolName:'hehe',
                address:'1'
            }
        },
        methods:{
            showName()
            {
                alert(this.schoolName)
            },
            test()
            {
                alert(this.hello())
            },
            deliverName1()
            {
                
                this.getschoolName(this.schoolName)
            },
            deliverName2()
            {
                this.$emit('delivername2',this.schoolName)
            },
            unbind()
            {
                this.$off('delivername2')//解绑一个
             //   this.$off()解绑所有
             //   this.$off(['delivername2','deliver1'])解绑多个
            },
            destroy()
            {
                this.$destroy()/* 销毁了当前组件的实例，所有自定义事件均不能使用，但是依旧可以使用原生DOM */
            }
        },
        mixins:[hunhe],
        props: ['getschoolName']
    
}
</script>


<style >

</style>