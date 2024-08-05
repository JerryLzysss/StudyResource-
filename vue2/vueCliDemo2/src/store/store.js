import Vue from 'vue'
import Vuex from 'vuex'
Vue.use(Vuex)
const ModuleA={
    namespaced:true,
    state:()=>({count:1}),
    mutations:{
        increment(arg){
          console.log(arg)
        }
    },
    actions:{
        incrementChild(arg){
            console.log(arg)
        }
    },
    getters:{
        get(state){
            return state
          
        }
    }
}
const ModuleB={
    state:()=>({count:2})
}
const store=new Vuex.Store({
    state:{
        count:0,
        count2:5,
        count3:10,
        todos:[{id:1,text:'1',done:true},{id:2,text:'2',done:false}]
    },
    mutations:{
        increment(state){
        
            state.count++
        },
        decrement(state,payload){
            state.count-=payload.number
        }
    },
    getters:{
        Todos(state){
            return state.todos.filter((todo)=>{
                return todo.done===true
            })
        }
    },
    actions:{
        increments(context)
        {
            setTimeout(()=>{
                context.commit('increment')
            },1000)
            
        }
    },
    modules:{
       a:ModuleA,
       b:ModuleB,
    }
})

export default store