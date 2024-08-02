<template>
  <div id="app">
    <img alt="Vue logo" src="./assets/logo.png">
    
    <router-view></router-view>
  
   <!--命名路由-->  
   <!-- <router-view name="a"></router-view> -->

  </div>
</template>

<script>

export default {
  name: 'App',
  components: {
   
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

.one {width: 100%;height: 100px;border: 1px solid red;background:skyblue;}
.two {width: 20%;height: 300px;float: left;border: 1px solid blue;background:salmon;}
.three {width: 80%;height: 300px;float: right;border: 1px solid orange;background:chartreuse;}
</style>
