<template>
    <div id="app">
      about {{ $route.params.id }}
    </div>
  </template>
<script>
export default{ 
  /*监听同级路由跳转 */
  /* beforeRouteUpdate(to,from,next)
  {
    console.log(to,from,next)
  }, */
 /*  watch:{
        $route(to,from,next){
            console.log(to,from,next)
        }
    }, */
}
</script> 