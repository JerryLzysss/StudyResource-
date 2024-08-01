<template>
    <div class="Category">
        <h3>{{title}}分类</h3>
        
            <!-- 定义一个插槽，等待组件使用者进行处理 -->
            <slot name="center"></slot>
            <slot name="footer"></slot>
    </div>
</template>

<script>
    export default{
        name:'Category',
        props:['title']
    }

</script>
<style>

    .Category{
        background-color:skyblue;
        width:200px;
        height:300px;
    }
</style>