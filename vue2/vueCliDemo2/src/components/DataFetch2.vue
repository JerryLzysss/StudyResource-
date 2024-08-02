<template>
    <!-- 导航完成后获取数据 -->
    <div id="app">
       
        <div v-if="error">
          {{error}}
          </div>
          <div v-if="post">
            {{ post.title }}
            {{ post.body }}
          </div>
    </div>
  </template>
<script>
export default{ 
    data()
    {
      return{
        loading:false,
        post:null,
        error:null,
      }
    },
    beforeRouteEnter(to,from,next){
        /* 此处由于this还未获取到对应的上下文,因此可以使用vm来进行代替 */
        next(vm=>vm.$axios({
            /* 请求类型 */
            method:'GET',
            /* URL */
            url:'http://localhost:3000/posts'
        }).then(response=>{
           
            vm.post=response.data[0]
            console.log(response.data[0])
        }).catch(err=>{
            vm.error=err.toString()
            
        }));
    },
    beforeRouteUpdate(to,from){
        this.post=null
        this.$axios({
            /* 请求类型 */
            method:'GET',
            /* URL */
            url:'http://localhost:3000/posts'
        }).then(response=>{
          this.fetchData(false,response)
        }).catch(err=>{
           this.fetchData(err,false)
            
        });
       next()
    },
    methods:{
       fetchData(err,post){
        if(err)
        {
            this.error=err.toString()
        }
        else{
            this.post=post
        }
      }
    }
}
</script> 