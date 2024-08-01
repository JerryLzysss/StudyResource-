<template>
  <div id="root">
      <div class="todo-container">
        <div class="todo-wrap">
            <myHeader :addTodo="addTodo"></myHeader>
            <myList 
            :todos="todos" 
            :checkTodo="checkTodo"
            :deleteTodo="deleteTodo"
            ></myList>
      
            <myFooter :todos="todos" :checkAllTodo="checkAllTodo" :clearAllTodo="clearAllTodo"></myFooter>
        </div>
      </div>
  </div>
</template>

<script>
import myList from "./components/MyList.vue"
import myFooter from "./components/MyFooter.vue"
import myItem from "./components/MyItem.vue"
import myHeader from "./components/MyHeader.vue"
export default {
  name: 'App',
  components: {
      myFooter,
      myList,
      myItem,
      myHeader
  },
   data() {
    return {
      todos: [
        { id: '001', title: '吃饭', done: true },
        { id: '002', title: '睡觉', done: false },
        { id: '003', title: '喝水', done: true },
      ]
    }
  },
  methods:{
    addTodo(todoObj)
    {
      this.todos.unshift(todoObj);
    },
    updateTodo(title1,title2)
    {
      this.todos.forEach((todos)=>{
        if(title1===todos.title)
        todos.title=title2
     })
    },
    checkTodo(title)
    {
        this.todos.forEach((todos)=>{
          if(todos.title===title)
          {
          todos.done=!todos.done
          console.log(todos.title);
          console.log(todos.done);  
          }
        })
       
    },
    deleteTodo(title)
    {
      this.todos=this.todos.filter((todos)=>{
        return todos.title!==title
      })
    },
    checkAllTodo(done)
    {
      this.todos.forEach((todos)=>{
        todos.done= done
      })
    },
    clearAllTodo()
    {
      this.todos.forEach((todos)=>{
        todos.done=false
      })
    }
  },
  mounted()
  {
    this.$bus.$on('checkTodo',this.checkTodo)
    this.$bus.$on('deleteTodo',this.deleteTodo)
    this.$bus.$on('updateTodo',this.updateTodo)
  },
  beforeDestory()
  {
    this.$bus.$off('checkTodo')
    this.$bus.$off('deleteTodo')
    this.$bus.$off('updateTodo')
  }
}
</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
body{
  background:#fff;
}
.btn{
  display: inline-block;
  padding:4px 12px;
  margin-bottom:0;
  font-size:14px;
  line-height:20px;
  text-align:center;
  vertical-align:middle;
  cursor:pointer;
  box-shadow:inset 0 1px 0 rgba(255,255,255,0.2),0 1px 2px rgba(0,0,0,0.05);
}
.btn-danger{
  color:fff;
  background-color:#da4f49;
  border:1px solid #bd362f;
}
.btn-danger:hover{
  color:#fff;
  background-color:#bd362f;
}
.btn:focus{
  outline:none;
}
.todo-container{
  width:600px;
  margin:0 auto;
}
.todo-container .todo-wrap{
  padding:10px;
  border:1px solid #ddd;
  border-radius:5px;
}



</style>
