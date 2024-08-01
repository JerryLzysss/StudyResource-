<template>
    <ul class="todo-main">
            <myItem v-for="item in todos"  
            :key="item.id" 
            :todo="item" />
    </ul>
</template>
<script>
import myItem from './MyItem.vue'
export default {
    name: 'myList',
    components:{myItem},
    props:['todos','checkTodo','deleteTodo']
   
}
</script>
<style>
.todo-main{
  margin-left:0px;
  border:1px solid #ddd;
  border-radius:2px;
  padding:0px;
}
.todo-empty{
  height:40px;
  line-height:40px;
  border:1px solid #ddd;
  border-radius:2px;
  padding-left:5px;
  margin-top:10px;
}
</style>