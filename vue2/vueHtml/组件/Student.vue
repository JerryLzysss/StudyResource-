<template>
    <!-- 组件结构 -->
    <div class="demo">
        <h2>{{ Name }}</h2>
        <h2>{{ age }}</h2>
        <button @click="showName">提示名字</button>
    </div>
</template>

<script>
export default{
        name:'student',
        data()
        {
            return{
                Name:'2',
                age:18
            }
        },
        methods:{
            showName()
            {
                alert(Name)
            }
        },
    
    
}
</script>


<style >

</style>