<template>
    <!-- 组件结构 -->
    <div class="demo">
        <h2>{{ schoolName }}</h2>
        <h2>{{ address }}</h2>
        <button @click="showName">提示名字</button>
    </div>
</template>

<script>
export default{
        name:'school',
        data()
        {
            return{
                schoolName:'1',
                address:'1'
            }
        },
        methods:{
            showName()
            {
                alert(schoolName)
            }
        },
    
    
}
</script>


<style >

</style>