import Vue from 'vue'
import VueRouter from "vue-router"
import ActiveRouter  from '../components/ActiveRouter.vue'
import Home from '../components/home.vue'
import About from '../components/about.vue'
import mainPage from '../components/mainPage.vue'
import ParentRouter from '@/components/ParentRouter.vue'
import ChildrenRouter from '@/components/ChildrenRouter.vue'
import NameSpaceView from '@/components/nameSpaceView.vue'
import PropsRouter from '@/components/PropsRouter.vue'
import Guard from '@/components/Guard.vue'
import DataFetch from '@/components/DataFetch.vue'
import DataFetch2 from '@/components/DataFetch2.vue'
import VueXDemo from '@/components/vueXDemo.vue'
const Foo={template:`<div>Foo</div>`}
const Bar={template:`<div>Bar</div>`}
const router=new VueRouter({
    routes:[{
        name:'home,',
        path:'/home',
        scrollBehavior(to,from,savedPosition){
            return {x:0,y:0}
        },
        component:Home,
    },{
        name:'about',
        path:'/about/:id',
        component:About,
    },{
        name:'ActiveRouter',
        path:'/ActiveRouter',
        component:ActiveRouter,
    },{
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
    },{
        name:'nameSpaceView',
        path:'/nameSpaceView',
     
        components:{
            a:Foo,
            b:Bar,
            default:NameSpaceView,
        }
    },{
        name:'/a',
        path:'/a',
        redirect:'/b',
        alias:'/b',
    },{
      
            path:'/propsRouter/:id',
            component:PropsRouter,
           /*  props:{id:3}, */
          /*  props:route=>({id:route.params.id}) */
           /*  props:true, */
            /* 命名视图,假设有一个sidebar */
            /* components:{default:PropsRouter,sidebar:sidebar},
            props:{default:true,sidebar:false} */
        
    },{
        path:'/Guard',
        component:Guard,
    },{
        path:'/DataFetch',
        component:DataFetch
    },{
        path:'/DataFetch2',
        component:DataFetch2
    },{
        path:'/vueX',
        component:VueXDemo,
    }],
    

    
   
})
/* 全局前置守卫 */
router.beforeEach((to,from,next)=>{
    console.log('before : ')
    console.log(to,from)
    next()
})
/* 全局后置守卫 */
router.afterEach((to,from)=>{
    console.log('after : ')
    console.log(to,from)
    
})

export default router