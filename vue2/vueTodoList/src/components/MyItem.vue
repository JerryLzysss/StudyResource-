
<template>
       <li>
                      <label>
                        <input type="checkbox" 
                        :checked="todo.done" 
                        @change="handle(todo.title)"/>
                        
                        <span v-show="!todo.isEdit">{{ todo.title }}</span>
                         <input 
                         v-show="todo.isEdit" 
                         type="text" 
                         :value="todo.title"
                         @blur="handleBlur(todo,$event)"
                         ref="edits">
                      </label>
                      <button class="btn btn-danger" 
                      @click="deletes(todo.title)">删除</button>
                      
                     
                      <button class="btn btn-edit"
                      @click="handleEdit(todo)">编辑</button>
                    </li>
</template>
<script>
export default {
    name: 'myItem',
    /* 声明接收对象 */
    props:['todo','checkTodo','deleteTodo'],
    methods:{
        handle(title)
        {
            //this.checkTodo(title)
          this.$bus.$emit('checkTodo',title)
          },
        deletes(title)
        {
           // this.deleteTodo(title)
           this.$bus.$emit('deleteTodo',title)
           // console.log(title)
        },
        handleEdit(todo)
        {
          if(todo.hasOwnProperty('isEdit'))
          {
            todo.isEdit=true
          }
          else
          {
          this.$set(todo,'isEdit',true)
          }
          this.$nextTick(function () {
        this.$refs.edits.focus()
      })
          //todo.isEdit=true
        },
        handleBlur(todo,e)
        {
          this.todo.isEdit=false
          console.log(e.target.value)
          this.$bus.$emit('updateTodo',this.todo.title,e.target.value)
        }
    }
}
</script>
<style scoped>

 li{
  list-style:none;
  height:36px;
  line-height:36px;
  padding:0 5px;
  border-bottom:1px solid #ddd;
}
li label{
  float:left;
  cursor:pointer;
}
li label li input{
  vertical-align:middle;
  margin-right:6px;
  position:relative;
  top:-1px;
}
li button{
  float : right;
  display:none;
  margin-top:3px;
}
li:before{
  content:initial;
}
li:last-child{
  border-bottom:none;
}
li:hover button{
    display:block;
}
</style>