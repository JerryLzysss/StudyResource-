import Vue from 'vue'
import VueRouter from "vue-router"
import ActiveRouter  from '../components/ActiveRouter.vue'
import Home from '../components/home.vue'
import About from '../components/about.vue'
import mainPage from '../components/mainPage.vue'
import ParentRouter from '@/components/ParentRouter.vue'
import ChildrenRouter from '@/components/ChildrenRouter.vue'
const router=new VueRouter({
    routes:[{
        name:'home,',
        path:'/home',
        component:Home,
    },{
        name:'about',
        path:'/about/:id',
        component:About,
    },{
        name:'ActiveRouter',
        path:'/ActiveRouter',
        component:ActiveRouter,
    },,{
        name:'parentRouter',
        path:'/parent',
        component:ParentRouter,
        children:[{
            name:'childrenRouter',
            path:'/parent/children',
            component:ChildrenRouter
        }]
    },{
        name:'mainPage',
        path:'*',
        component:mainPage,
    }],
    

    
   
})


export default router