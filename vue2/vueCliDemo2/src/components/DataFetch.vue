<template>
    <!-- 导航完成后获取数据 -->
    <div id="app">
        <div v-if="loading">
          ...loading
        </div>
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
    } ,
    created()
    {
        this.fetchData()
    },
    watch:{
      '$route':'fetchData'
    },
    methods:{
       fetchData(){
        this.error=this.post=null
        this.loading=true
          this.$axios({
            /* 请求类型 */
            method:'GET',
            /* URL */
            url:'http://localhost:3000/posts'
        }).then(response=>{
            this.loading=false
            this.post=response.data[0]
            console.log(response.data[0])
        }).catch(err=>{
            this.error=err.toString()
            
        });
      }
    }
}
</script> 