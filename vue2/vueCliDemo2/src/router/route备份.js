import VueRouter from 'vue-router' 
import About from '../pages/About'
import Home from '../pages/Home'
import News from '../pages/News'
import Message from '../pages/Message'
import Detail from '../pages/detail'
const router =new VueRouter({
    routes:[
        {
            name:'about',
            path:'/about',
            component:About,
           
        },
        {
            name:'home',
            path:'/home',
            component:Home,
            children:[
               {
                    path:'news',
                    component:News
               },
               {
                    path:'message',
                    component:Message,
                    children:[
                        {
                            name:'detail',
                        //query     path:'detail',
                            path:'detail/:id/:title',
                            component:Detail,
                            /* props的第一种写法:值与对象的形式 */
                            //props:{a:1,b:2}
                            /* props的第二种写法:布尔值为真，则该路由会接收所有的params，以props的形式传递 */
                            props:true,
                            /* props的第三种写法:值为函数
                            props($route)
                            {
                                return {id:$route.query.id,title:$route.query.title}
                            } */

                            /* 独享守卫，一个路由单独享受的路由，
                            注意不存在后置独享，只有前置独享 */
                            beforeEnter(to,from,next){
                                console.log(to,from)
                                next()
                            }
                        }
                            ]
               }   
            ]
        }
    ]
})
/* 全局前置路由收尾--初始化的时候被调用，路由切换前调用 */
router.beforeEach((to,from,next)=>{
    console.log(to,from)
    next()
})
/* 全局前置路由收尾--初始化的时候被调用，路由切换后调用 */
router.afterEach((to,from)=>{

})
export default router
