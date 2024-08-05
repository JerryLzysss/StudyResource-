<template>
  <div>
    <button>{{ show }}</button><br>
    <a>{{count}}--{{count2}}--{{ count3 }}</a>
    <br><a>{{count4}}</a>
    <button @click="mut">{{ count }}</button>
  </div>

</template>
<script>
import { mapState,mapGetters } from 'vuex'
export default {
  data(){
    return{
      tempcount1:'1',
      tempcount2:'2',
    }
  },
 mounted(){
  this.init()
 },
 methods:{
    init(){
      let x=[1,2,3,4,5]
      let [a,b,...num]=x
      console.log(a,b,num)
      console.log(this.$store.getters.Todos)
      console.log(this.done)
      console.log('A:'+this.$store.state.a.count)
      console.log('B:'+this.$store.state.b.count)
    },
    mut(){
     /*  this.$store.commit('a/increment') */
   /*    this.$store.commit('decrement',{number:5}) */
     /*  this.$store.dispatch('a/incrementChild') */
       /*  console.log(this.$store.getters['a/get']) */
      console.log(this.$store.state.a.count)
    }
 },
computed:{
  ...mapState('a',{
    count4:state=>state.count
  }),
    ...mapState({
    count:state=> state.count,
    count2: state => state.count2,
    count3: state => state.count3,
    show: function (state) {
      return state.count + ' - ' + state.count2 + ' - ' + state.count3
    }
  }),
  ...mapGetters({
    done:'Todos'
  })
}
  
}
</script>