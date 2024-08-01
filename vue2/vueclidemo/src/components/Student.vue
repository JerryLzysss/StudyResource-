<template>
    <!-- 组件结构 -->
    <div class="demo">
        <h2>{{ myName }}</h2>
        <h2>{{ myAge }}</h2>
        <button @click="showName">提示名字</button>
        <button @click="update">更新年龄</button>
    </div>
</template>

<script>

export default{
        name:'student',
        data()
        {
            return{
                myName:this.Name,
                myAge:this.age
                
            }
        },
        methods:{
            showName()
            {
                alert(this.Name)
            },
            update()
            {
                alert(this.myAge);
                this.myAge++;
            }
        },
        props:['Name','age'],
    
       /*  props:{
            Name:String,
            age:Number
        } */
    
    
}
</script>


<style >

</style>