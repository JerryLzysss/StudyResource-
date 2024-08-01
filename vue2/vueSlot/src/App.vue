<template>
  <div id="app">
    <div class="container">
    <Category title="1">
        <div slot="footer">gg</div>
    </Category>
     <Category title="2" >
        <ul slot="center">
            <li v-for="item in games">{{ item }}</li>
        </ul>
      </Category>
      <Category title="3" ></Category>
    </div>
  </div>
</template>

<script>
import Category from './components/Category.vue'
export default {
  name: 'App',
  components: {
    Category
  },
  data()
  {
    return{
        foods:['1','2','3','4'],
        games:['11','22','33','44'],
        films:['111','222','333','444']
    }
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
.container{
  display:flex;
  justify-content:space-around
}
</style>
