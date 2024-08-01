export default{
    install(Vue)
    {
        console.log('install')
    
    /* 定义混入 */
    Vue.mixin({
            methods:{
        showName()
        {
            alert("ok")
        }
    },
    data(){
       return{ 
        x:100,
        y:100}
        
    }
    }),
    
    /* 给Vue原型添加一个方法 */
    Vue.prototype.hello=()=>{
        alert('hello');
    }
    }
}